import 'package:eccomerce_app/app/core/data/sharedPre.dart';
import 'package:eccomerce_app/app/core/services/api_service.dart';
import '../../../core/config/api_endpoints.dart';
import '../../../core/services/api_exceptions.dart';
import '../../../core/utils/appString/app_storage_string.dart';
import '../../../services/toast_service.dart';

class CustomerRepository {
  final ApiService _apiService = ApiService();

  Future<List<dynamic>> getCustomerDetailsApi({String search = ''}) async {
    try {
      final companyId =
          SharedpreferenceUtil.getString(AppStorage.selectedCompanyId);

      final endpoint =
          "${ApiEndpoints.getCustomerDetails}$companyId?search=$search";

      final response = await _apiService.getRequestAuth(endpoint);

      if (response.data['statusCode'] != 200) {
        throw Exception("Failed to fetch customer details!");
      }

      final customers =
          response.data['data']?['customers'] as List<dynamic>? ?? [];

      return customers;
    } on ApiException catch (e) {
      ApptoastUtils.showError(e.toString());
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> createCustomerRepo(
      Map<String, dynamic> customerData) async {
    try {
      final response = await _apiService.postRequestAuth(
        ApiEndpoints.createCustomerApi,
        customerData,
      );
      return response.data;
    } on ApiException catch (e) {
      throw Exception('Failed to create customer: ${e.message}');
    } catch (e) {
      throw Exception('Failed to create customer: $e');
    }
  }
}
