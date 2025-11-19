import 'package:eccomerce_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eccomerce_app/app/core/utils/logger.dart';
import '../../../services/toast_service.dart';
import '../../Cart/controllers/cart_controller.dart';
import '../models/product_details_models.dart';
import '../repositories/product_details_repository.dart';

class ProductDetailsController extends GetxController {
  final ProductDetailsRepository _repository = ProductDetailsRepository();
  final CartController _cartController = Get.find<CartController>();

  final product = ProductDetailsModels().obs;
  final isLoading = false.obs;
  final isLoadingAddToCart = false.obs;
  final isLoadingIncrement = false.obs;
  final isLoadingDecrement = false.obs;
  final currentImageIndex = 0.obs;
  final isProductInCart = false.obs;
  final bulkQuantity = 1.obs;
  final showBulkInput = false.obs;
  final bulkQuantityController = TextEditingController(text: '1');

  @override
  void onInit() {
    super.onInit();
    _loadProductDetails();
  }

  @override
  void onClose() {
    bulkQuantityController.dispose();
    super.onClose();
  }

  void _loadProductDetails() async {
    try {
      isLoading.value = true;

      final arguments = Get.arguments;
      if (arguments == null || arguments['productId'] == null) {
        throw Exception('Product ID not provided');
      }

      final productId = arguments['productId'];
      final response = await _repository.fetchProductDetails(productId);

      if (response['statusCode'] == 200) {
        final productData = response['data'];
        product.value = ProductDetailsModels.fromJson(productData);
        _checkProductInCart();
      } else {
        throw Exception('Failed to load product details');
      }
    } catch (e) {
      AppLogger.error('Error loading product details: $e');
      ApptoastUtils.showGetXError('Error', 'Failed to load product details');
    } finally {
      isLoading.value = false;
    }
  }

  void _checkProductInCart() {
    isProductInCart.value = _cartController.isProductInCart(product.value.id);

    // Set initial bulk quantity based on cart or default to 1
    if (isProductInCart.value) {
      final cartItem = _cartController.cartItems.firstWhere(
        (item) =>
            (item['productId'] ?? item['product']?['_id']) == product.value.id,
        orElse: () => {},
      );
      final quantity = cartItem['quantity'] ?? 1;
      bulkQuantity.value = quantity;
      bulkQuantityController.text = quantity.toString();
    } else {
      bulkQuantity.value = 1;
      bulkQuantityController.text = '1';
    }
  }

  double getDiscountPercentage() {
    final productValue = product.value;
    if (productValue.mrp <= 0) return 0;
    return ((productValue.mrp - productValue.price) / productValue.mrp * 100)
        .roundToDouble();
  }

  void toggleBulkInput() {
    showBulkInput.value = !showBulkInput.value;
    if (!showBulkInput.value) {
      // Reset to current cart quantity when closing bulk input
      _checkProductInCart();
    }
  }

  void updateBulkQuantity(String value) {
    if (value.isEmpty) {
      bulkQuantity.value = 0;
      return;
    }

    final quantity = int.tryParse(value) ?? 0;
    final maxQuantity = product.value.totalQty;

    if (quantity > maxQuantity) {
      bulkQuantity.value = maxQuantity;
      bulkQuantityController.text = maxQuantity.toString();
      ApptoastUtils.showError('Warning: Maximum quantity is $maxQuantity');
    } else if (quantity < 1) {
      bulkQuantity.value = 1;
      bulkQuantityController.text = '1';
    } else {
      bulkQuantity.value = quantity;
    }
  }

  Future<void> addToCart({int? customQuantity}) async {
    try {
      isLoadingAddToCart.value = true;

      final quantity = customQuantity ?? bulkQuantity.value;

      await _cartController.addToCart(
        productId: product.value.id,
        quantity: quantity,
      );

      isProductInCart.value = true;
      showBulkInput.value = false;

      ApptoastUtils.showGetXSuccess(
        'Success',
        '${product.value.name} added to cart',
      );
    } catch (e) {
      AppLogger.error('Error adding to cart: $e');
      ApptoastUtils.showGetXError(
        'Error',
        'Failed to add to cart: $e',
      );
    } finally {
      isLoadingAddToCart.value = false;
    }
  }

  Future<void> updateCartQuantity(int newQuantity) async {
    try {
      if (newQuantity == 0) {
        await removeFromCart();
        return;
      }

      await _cartController.addToCart(
        productId: product.value.id,
        quantity: newQuantity,
      );

      bulkQuantity.value = newQuantity;
      bulkQuantityController.text = newQuantity.toString();

      update();
    } catch (e) {
      AppLogger.error('Error updating quantity: $e');
      ApptoastUtils.showGetXError('Error', 'Failed to update quantity');
    }
  }

  Future<void> removeFromCart() async {
    try {
      await _cartController.removeFromCart(product.value.id);
      isProductInCart.value = false;
      bulkQuantity.value = 1;
      bulkQuantityController.text = '1';
      showBulkInput.value = false;

      update();
    } catch (e) {
      AppLogger.error('Error removing from cart: $e');
      ApptoastUtils.showGetXError('Error', 'Failed to remove from cart');
    }
  }

  Future<void> incrementQuantity() async {
    try {
      isLoadingIncrement.value = true;

      final newQuantity = bulkQuantity.value + 1;
      await updateCartQuantity(newQuantity);
    } catch (e) {
      AppLogger.error('Error incrementing quantity: $e');
      ApptoastUtils.showGetXError('Error', 'Failed to update quantity');
    } finally {
      isLoadingIncrement.value = false;
    }
  }

  Future<void> decrementQuantity() async {
    try {
      isLoadingDecrement.value = true;

      if (bulkQuantity.value > 1) {
        final newQuantity = bulkQuantity.value - 1;
        await updateCartQuantity(newQuantity);
      } else {
        await removeFromCart();
      }
    } catch (e) {
      AppLogger.error('Error decrementing quantity: $e');
      ApptoastUtils.showGetXError('Error', 'Failed to update quantity');
    } finally {
      isLoadingDecrement.value = false;
    }
  }

  void setBulkQuantityManually() {
    final quantity = int.tryParse(bulkQuantityController.text) ?? 1;
    updateCartQuantity(quantity);
    showBulkInput.value = false;
  }

  void navigateToCart() {
    Get.toNamed(Routes.CART);
  }

  bool get isProductAvailable {
    return product.value.totalQty > 0;
  }

  // Check if cart has items (for showing View Cart button)
  bool get shouldShowViewCart {
    return _cartController.hasItems;
  }
}
