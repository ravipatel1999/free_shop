import 'dart:developer';
import 'package:eccomerce_app/app/core/services/api_service.dart';
import 'package:eccomerce_app/app/core/services/api_exceptions.dart';

class ProductDetailsRepository {
  final ApiService _apiService = ApiService();

  Future<Map<String, dynamic>> fetchProductDetails(String productId) async {
    try {
      final url = "stock-items/productById/$productId";

      final response = await _apiService.getRequestAuth(url);

      // Debug-only logging
      assert(() {
        log("✅ Product details fetched successfully for: $productId");
        return true;
      }());

      return response.data;
    } on ApiException catch (e) {
      assert(() {
        log("❌ Product details ApiException: ${e.message}");
        return true;
      }());
      rethrow;
    } catch (e) {
      assert(() {
        log("❌ Unexpected error while fetching product details: $e");
        return true;
      }());
      rethrow;
    }
  }
}
