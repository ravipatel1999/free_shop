import 'dart:async';
import 'dart:developer';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../core/data/sharedPre.dart';
import '../../../core/utils/appString/app_storage_string.dart';
import '../../../core/utils/logger.dart';
import '../../SignUp/repositories/auth_repository.dart';
import '../../Cart/controllers/cart_controller.dart';
import '../models/shopping_models.dart';
import '../repositories/shopping_repository.dart';

class ShoppingController extends GetxController {
  var selectedIndex = 0.obs;
  RxInt currentPage = 1.obs;

  final AuthRepository _authRepository = AuthRepository();
  final ShoppingRepository _shoppingRepository = ShoppingRepository();

  var selectedCompany = Company(
    id: '',
    namePrint: 'Select Company',
    code: '',
  ).obs;

  var selectedGroup = 'All'.obs;
  var selectedCategory = 'All'.obs;
  var showFilters = false.obs;
  var isLoading = false.obs;
  var isProductsLoading = false.obs;
  var searchController = TextEditingController().obs;

  var allProducts = <Product>[].obs;
  var filteredProducts = <Product>[].obs;
  var availableGroups = <String>[].obs;
  var availableCategories = <String>[].obs;
  var companyID = "".obs;

  var companies = <Company>[].obs;
  var hasMore = true.obs;
  var isLoadMore = false.obs;
  var searchQuery = ''.obs;
  var showShimmer = true.obs;

  var productLoadingStates = <String, bool>{}.obs;

  final int limit = 24;
  Timer? _debounceTimer;

  @override
  void onInit() {
    super.onInit();
    _loadUserCompanies();

    _initializeFromArguments();

    searchController.value.addListener(() {
      final newQuery = searchController.value.text.trim();
      if (newQuery != searchQuery.value) {
        searchQuery.value = newQuery;
        _debounceSearch();
      }
    });
    _listenToCartUpdates();
  }

  void _initializeFromArguments() {
    final args = Get.arguments;
    if (args != null && args is Map<String, dynamic>) {
      final newCompanyId = args['companyId'] ?? '';
      if (newCompanyId.isNotEmpty && newCompanyId != companyID.value) {
        companyID.value = newCompanyId;

        _updateSelectedCompanyFromId(newCompanyId);

        _loadStockItems(newCompanyId, reset: true);
      }
    } else {}
  }

  void _updateSelectedCompanyFromId(String companyId) {
    try {
      final foundCompany = companies.firstWhere(
        (company) => company.id == companyId,
        orElse: () => Company(id: '', namePrint: 'Select Company', code: ''),
      );

      if (foundCompany.id.isNotEmpty) {
        selectedCompany.value = foundCompany;
      }
    } catch (e) {}
  }

  void _debounceSearch() {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      _loadStockItems(companyID.value, reset: true);
    });
  }

  void _loadUserCompanies() {
    try {
      final userDetails = _authRepository.getUserDetails();
      if (userDetails.isNotEmpty && userDetails.containsKey('access')) {
        final accessList = userDetails['access'] as List<dynamic>;

        final companyList = accessList
            .map((access) {
              if (access is Map && access.containsKey('company')) {
                final company = access['company'] as Map<String, dynamic>;
                return Company(
                  id: company['_id'] ?? '',
                  namePrint: company['namePrint'] ?? 'Unknown Company',
                  code: company['code'] ?? '',
                );
              }
              return Company(id: '', namePrint: 'Unknown', code: '');
            })
            .where((company) => company.id.isNotEmpty)
            .toList();

        companies.value = companyList;

        assert(() {
          log("✅ Loaded ${companies.length} companies from user access");
          return true;
        }());

        if (selectedCompany.value.id.isEmpty && companies.isNotEmpty) {
          selectedCompany.value = companies.first;
          companyID.value = companies.first.id;
          _loadStockItems(companies.first.id);
        }
      }
    } catch (e) {
      AppLogger.error("Error loading user companies: $e");
    }
  }

  Future<void> _loadStockItems(String companyId, {bool reset = false}) async {
    try {
      if (reset) {
        currentPage.value = 1;
        hasMore.value = true;
        showShimmer.value = true;
      } else {
        isLoadMore.value = true;
      }

      final response = await _shoppingRepository.fetchStockItems(
        companyId,
        page: currentPage.value,
        search: searchQuery.value,
      );

      if (response['statusCode'] == 200) {
        final items = response['data']['items'] as List<dynamic>;
        final totalItems = response['data']['total'] as int? ?? 0;
        final pagination =
            response['data']['pagination'] as Map<String, dynamic>?;

        if (pagination != null) {
          final currentPageNum = pagination['page'] as int? ?? 1;
          final totalPages = pagination['totalPages'] as int? ?? 1;
          hasMore.value = currentPageNum < totalPages;
        } else {
          hasMore.value = (currentPage.value * limit) < totalItems;
        }

        final products = items.map((item) {
          final productId = item['productId'] as Map<String, dynamic>?;
          final images = productId?['images'] as List<dynamic>? ?? [];

          return Product(
            id: item['_id'] ?? '',
            name: item['ItemName'] ?? 'Unknown Product',
            description:
                item['productId']?['remarks'] ?? 'No description available',
            price: (item['Price'] ?? 0.0).toDouble(),
            mrp: (item['MRP'] ?? 0.0).toDouble(),
            discount: (item['Discount'] ?? 0.0).toDouble(),
            totalQty: (item['TotalQty'] ?? 0).toInt(),
            group: item['Group'] ?? 'Uncategorized',
            category: item['Category'] ?? 'General',
            images: images.map((img) {
              return ProductImage(
                angle: img['angle'] ?? 'Front',
                fileUrl: img['fileUrl'] ?? '',
              );
            }).toList(),
          );
        }).toList();

        if (reset) {
          allProducts.assignAll(products);
        } else {
          final newProducts = products
              .where((newProduct) => !allProducts.any(
                  (existingProduct) => existingProduct.id == newProduct.id))
              .toList();

          allProducts.addAll(newProducts);
        }
        allProducts.refresh();

        _initializeFilters();
        _applyFilters();

        if (!reset && products.isNotEmpty) {
          currentPage.value++;
        }
      }
    } catch (e) {
      AppLogger.error("Error loading stock items: $e");
    } finally {
      isProductsLoading.value = false;
      isLoadMore.value = false;
      showShimmer.value = false;
    }
  }

  void loadMoreProducts() {
    if (!isLoadMore.value && hasMore.value && companyID.value.isNotEmpty) {
      assert(() {
        log("🔄 Loading more products... Page: ${currentPage.value + 1}");
        return true;
      }());
      _loadStockItems(companyID.value);
    }
  }

  void refreshProducts() {
    showShimmer.value = true;
    _loadStockItems(companyID.value, reset: true);
  }

  void updateSelectedCompany(Company company) {
    if (company.id == selectedCompany.value.id) {
      return;
    }

    selectedCompany.value = company;
    companyID.value = company.id;
    searchController.value.clear();
    searchQuery.value = '';
    showShimmer.value = true;
    _loadStockItems(company.id, reset: true);
    SharedpreferenceUtil.setString(AppStorage.selectedCompanyId, company.id);
    final cartController = Get.put(CartController());
    cartController.fetchCartItems();
  }

  void _initializeFilters() {
    final validProducts = allProducts.where((p) => p.totalQty > 0).toList();

    availableGroups.value =
        ['All'] + validProducts.map((p) => p.group).toSet().toList();
    availableCategories.value =
        ['All'] + validProducts.map((p) => p.category).toSet().toList();
  }

  void _applyFilters() {
    var filtered =
        allProducts.where((product) => product.totalQty > 0).toList();

    if (selectedGroup.value != 'All') {
      filtered = filtered
          .where((product) => product.group == selectedGroup.value)
          .toList();
    }

    if (selectedCategory.value != 'All') {
      filtered = filtered
          .where((product) => product.category == selectedCategory.value)
          .toList();
    }

    if (searchQuery.value.isNotEmpty) {
      filtered = filtered.where((product) {
        return product.name
                .toLowerCase()
                .contains(searchQuery.value.toLowerCase()) ||
            product.description
                .toLowerCase()
                .contains(searchQuery.value.toLowerCase()) ||
            product.group
                .toLowerCase()
                .contains(searchQuery.value.toLowerCase()) ||
            product.category
                .toLowerCase()
                .contains(searchQuery.value.toLowerCase());
      }).toList();
    }

    filteredProducts.value = filtered;
  }

  Future<void> addToCartWithLoading({
    required String productId,
    required int quantity,
    required Function() onSuccess,
    required Function(String error) onError,
  }) async {
    try {
      productLoadingStates[productId] = true;
      update();

      final cartController = Get.put(CartController());
      await cartController.addToCart(productId: productId, quantity: quantity);

      onSuccess();
    } catch (e) {
      onError(e.toString());
    } finally {
      productLoadingStates[productId] = false;
      update();
    }
  }

  bool isProductLoading(String productId) {
    return productLoadingStates[productId] == true;
  }

  void filterByGroup(String group) {
    selectedGroup.value = group;
    _applyFilters();
  }

  void filterByCategory(String category) {
    selectedCategory.value = category;
    _applyFilters();
  }

  void clearFilters() {
    selectedGroup.value = 'All';
    selectedCategory.value = 'All';
    searchController.value.clear();
    searchQuery.value = '';
    showShimmer.value = true;
    _loadStockItems(companyID.value, reset: true);
  }

  void clearSearch() {
    searchController.value.clear();
    searchQuery.value = '';
    showShimmer.value = true;
    _loadStockItems(companyID.value, reset: true);
  }

  void toggleFilters() {
    showFilters.value = !showFilters.value;
  }

  double getDiscountPercentage(double mrp, double price) {
    if (mrp <= 0) return 0;
    return ((mrp - price) / mrp * 100).roundToDouble();
  }

  void showCompanySelection() {
    if (companies.isEmpty) {
      return;
    }

    showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(Get.context!).size.width,
      ),
      builder: (context) => SafeArea(
        bottom: false,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Get.theme.colorScheme.background,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(28),
              topRight: Radius.circular(28),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 12, bottom: 8),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Get.theme.colorScheme.onSurface.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Select Company',
                      style: Get.theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold, fontSize: 12.sp),
                    ),
                    IconButton(
                      icon: Icon(Icons.close_rounded,
                          size: 18.sp, color: Get.theme.colorScheme.onSurface),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: companies.length,
                itemBuilder: (context, index) {
                  final company = companies[index];
                  final isSelected = selectedCompany.value.id == company.id;

                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      gradient: isSelected
                          ? LinearGradient(
                              colors: [
                                Get.theme.colorScheme.primary,
                                Get.theme.colorScheme.primary.withOpacity(0.8),
                              ],
                            )
                          : null,
                      color: isSelected ? null : Get.theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: isSelected
                              ? Get.theme.colorScheme.primary.withOpacity(0.3)
                              : Colors.black.withOpacity(0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () {
                          updateSelectedCompany(company);
                          Navigator.pop(context);

                          // if (Get.context != null) {
                          //   Get.context!.showSuccessToast(
                          //       'Switched to ${company.namePrint}');
                          // }
                        },
                        child: Padding(
                          padding: EdgeInsets.all(16.r),
                          child: Row(
                            children: [
                              Container(
                                width: 48.w,
                                height: 48.h,
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? Colors.white.withOpacity(0.2)
                                      : Get.theme.colorScheme.primaryContainer,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  Icons.business_center_rounded,
                                  color: isSelected
                                      ? Colors.white
                                      : Get.theme.colorScheme.primary,
                                  size: 24.sp,
                                ),
                              ),
                              SizedBox(width: 14.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      company.namePrint,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12.sp,
                                        color: isSelected
                                            ? Colors.white
                                            : Get.theme.colorScheme.onSurface,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${company.code} • ${company.id.substring(0, 8)}...',
                                      style: TextStyle(
                                        color: isSelected
                                            ? Colors.white.withOpacity(0.8)
                                            : Get.theme.colorScheme
                                                .onSurfaceVariant,
                                        fontSize: 10.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (isSelected)
                                Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.check_rounded,
                                    color: Get.theme.colorScheme.primary,
                                    size: 20.sp,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  void _listenToCartUpdates() {
    ever(Get.put(CartController()).cartItems, (_) {
      if (companyID.value.isNotEmpty) {
        refreshProducts();
      }
    });
  }

  @override
  void onClose() {
    _debounceTimer?.cancel();
    searchController.value.dispose();
    super.onClose();
  }
}
