import 'package:get/get.dart';
import '../../../core/data/sharedPre.dart';
import '../../../core/utils/appString/app_storage_string.dart';
import '../../../core/utils/logger.dart';
import '../../../services/toast_service.dart';
import '../../Cart/controllers/cart_controller.dart';
import '../../SignUp/repositories/auth_repository.dart';
import '../repository/CustomerRepository.dart';

class CustomerController extends GetxController {
  final CustomerRepository _customerRepo = CustomerRepository();
  final AuthRepository authRepo = Get.put(AuthRepository());

  // Observable variables
  final customers = <Map<String, dynamic>>[].obs;
  final isLoading = false.obs;
  final searchQuery = ''.obs;
  final totalCustomers = 0.obs;
  final activeCustomers = 0.obs;

  var canCreateCustomer = false.obs;

  Future<void> createCustomer({
    required String customerName,
    required String phoneNumber,
    required String emailAddress,
    String? contactPerson,
    String? addressLine1,
    String? city,
    String? state,
    String? zipCode,
    String? country,
  }) async {
    try {
      // Validate required fields BEFORE setting isLoading
      if (customerName.isEmpty || phoneNumber.isEmpty || emailAddress.isEmpty) {
        ApptoastUtils.showWarning('Please fill all required fields');
        return;
      }

      // Email validation
      if (!GetUtils.isEmail(emailAddress)) {
        ApptoastUtils.showWarning('Please enter a valid email address');
        return;
      }

      // Phone validation (basic)
      if (phoneNumber.length < 10) {
        ApptoastUtils.showWarning('Please enter a valid phone number');
        return;
      }

      isLoading.value = true;

      final customerData = {
        "customerName": customerName,
        "phoneNumber": phoneNumber,
        "emailAddress": emailAddress,
        "contactPerson": contactPerson ?? "",
        "city": city ?? "",
        "state": state ?? "",
        "zipCode": zipCode ?? "",
        "country": country ?? "",
        "addressLine1": addressLine1 ?? "",
        "companyID":
            SharedpreferenceUtil.getString(AppStorage.selectedCompanyId),
        "source": "mobile_app"
      };

      // Remove empty fields
      customerData.removeWhere((key, value) => value.toString().isEmpty);

      AppLogger.info("Creating customer: $customerData");

      final response = await _customerRepo.createCustomerRepo(customerData);

      if (response['success'] == true || response['statusCode'] == 201) {
        // Get the CartController and select the newly created customer
        final cartController = Get.find<CartController>();
        final newCustomer = response['data'] ?? customerData;

        // Add to local list
        customers.add(newCustomer);
        totalCustomers.value = customers.length;

        // Auto-select the newly created customer
        cartController.selectCustomer(newCustomer);

        // Auto-fill address if available
        if (addressLine1?.isNotEmpty == true) {
          cartController.addressLine1.value = addressLine1!;
          cartController.city.value = city ?? '';
          cartController.state.value = state ?? '';
          cartController.zipCode.value = zipCode ?? '';
        }

        ApptoastUtils.showSuccess('Customer created successfully!');

        // Close all bottom sheets and return to main screen
        Get.back(closeOverlays: true);

        // Refresh customers list
        await fetchCustomers();
      } else {
        final errorMessage = response['message'] ?? 'Failed to create customer';
        throw Exception(errorMessage);
      }
    } catch (e) {
      AppLogger.error("Customer creation error: $e");
      ApptoastUtils.showError(
          'Failed to create customer: ${e.toString().replaceAll('Exception: ', '')}');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchCustomers({String search = ''}) async {
    try {
      isLoading.value = true;
      searchQuery.value = search;

      final customerList =
          await _customerRepo.getCustomerDetailsApi(search: search);

      customers.value =
          customerList.map((c) => c as Map<String, dynamic>).toList();
      totalCustomers.value = customers.length;

      // Count active customers
      activeCustomers.value =
          customers.where((c) => c['customerStatus'] == 'active').length;

      AppLogger.info("👥 Total Customers → ${customers.length}");
      AppLogger.info("✅ Active Customers → ${activeCustomers.value}");
    } catch (e) {
      AppLogger.error("Error loading customers: $e");
      ApptoastUtils.showError('Failed to load customers');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
  }
}
