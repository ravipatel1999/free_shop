import 'dart:io';
import 'package:dio/dio.dart';
import 'package:eccomerce_app/app/core/data/sharedPre.dart';
import 'package:eccomerce_app/app/core/utils/appString/app_storage_string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/services/api_service.dart';
import '../../../core/utils/logger.dart';
import '../../../services/toast_service.dart';

class PaymentManagementController extends GetxController {
  final ApiService _apiService = ApiService();
  final ImagePicker _imagePicker = ImagePicker();

  // Payment related observables
  var selectedCustomer = ''.obs;
  var selectedPaymentMethod = 'cash'.obs;
  var amountError = ''.obs;
  var canSubmit = false.obs;
  var uploadedFiles = <File>[].obs;
  var isLoading = false.obs;
  var uploadProgress = 0.0.obs;
  var showProgress = false.obs;

  // Payment list observables
  var payments = <Map<String, dynamic>>[].obs;
  var isLoadingPayments = false.obs;
  var selectedPayment = <String, dynamic>{}.obs;

  // Controllers
  final amountController = TextEditingController();
  final remarksController = TextEditingController();

  // Payment methods
  final List<String> paymentMethods = [
    "cash",
    "upi",
    "bank_transfer",
    "cheque",
    "bkash"
  ];

  @override
  void onInit() {
    super.onInit();

    // Set up listeners
    amountController.addListener(() {
      validateAmount(amountController.text);
    });

    ever(selectedPaymentMethod, (_) => updateCanSubmit());
    ever(selectedCustomer, (_) => updateCanSubmit());

    // Load payments on init
    fetchPayments();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    amountController.dispose();
    remarksController.dispose();
    super.onClose();
  }

  // Fetch payments from API
  Future<void> fetchPayments() async {
    try {
      isLoadingPayments.value = true;

      final response = await _apiService.getRequestAuth(
        'payment/company/${SharedpreferenceUtil.getString(AppStorage.selectedCompanyId)}',
      );

      final data = response.data;
      AppLogger.info('Payments Response: $data');

      if (data['success'] == true) {
        // If it's a single payment object, convert to list
        if (data['data'] is Map) {
          payments.value = [data['data']];
        } else if (data['data'] is List) {
          payments.value = List<Map<String, dynamic>>.from(data['data']);
        } else {
          payments.value = [];
        }

        AppLogger.info('Loaded ${payments.length} payments');
      } else {
        throw Exception(data['message'] ?? 'Failed to load payments');
      }
    } catch (e) {
      AppLogger.error('Error loading payments: $e');
      ApptoastUtils.showGetXError(
        'Error',
        'Failed to load payments',
      );
    } finally {
      isLoadingPayments.value = false;
    }
  }

  // Select payment for details view
  void selectPayment(Map<String, dynamic> payment) {
    selectedPayment.value = payment;
  }

  // Clear selected payment
  void clearSelectedPayment() {
    selectedPayment.value = {};
  }

  // Get payment status display
  String getPaymentStatusDisplay(String status) {
    switch (status) {
      case 'initiated':
        return 'Initiated';
      case 'completed':
        return 'Completed';
      case 'failed':
        return 'Failed';
      case 'pending':
        return 'Pending';
      default:
        return status;
    }
  }

  // Get status color
  Color getStatusColor(String status) {
    switch (status) {
      case 'completed':
        return Colors.green;
      case 'failed':
        return Colors.red;
      case 'initiated':
        return Colors.orange;
      case 'pending':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  // Validation
  void validateAmount(String value) {
    if (value.isEmpty) {
      amountError.value = 'Please enter payment amount';
      canSubmit.value = false;
    } else if (double.tryParse(value) == null) {
      amountError.value = 'Please enter a valid amount';
      canSubmit.value = false;
    } else if (double.parse(value) <= 0) {
      amountError.value = 'Amount must be greater than 0';
      canSubmit.value = false;
    } else {
      amountError.value = '';
      updateCanSubmit();
    }
  }

  void updateCanSubmit() {
    canSubmit.value = selectedCustomer.isNotEmpty &&
        selectedPaymentMethod.isNotEmpty &&
        amountError.isEmpty &&
        amountController.text.isNotEmpty;
  }

  // Image upload methods
  Future<void> pickImageFromCamera() async {
    try {
      if (uploadedFiles.length >= 5) {
        ApptoastUtils.showWarning('You can upload up to 5 files only.');
        return;
      }

      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1800,
        maxHeight: 1800,
        imageQuality: 80,
      );
      if (image != null) {
        uploadedFiles.add(File(image.path));
        ApptoastUtils.showSuccess('Image added successfully!');
      }
    } catch (e) {
      AppLogger.error('Failed to capture image: $e');
      ApptoastUtils.showError('Failed to capture image');
    }
  }

  Future<void> pickImageFromGallery() async {
    try {
      if (uploadedFiles.length >= 5) {
        ApptoastUtils.showWarning('You can upload up to 5 files only.');
        return;
      }

      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1800,
        maxHeight: 1800,
        imageQuality: 80,
      );
      if (image != null) {
        uploadedFiles.add(File(image.path));
        ApptoastUtils.showSuccess('Image added successfully!');
      }
    } catch (e) {
      AppLogger.error('Failed to pick image: $e');
      ApptoastUtils.showError('Failed to pick image');
    }
  }

  Future<void> pickMultipleFiles() async {
    try {
      final List<XFile> images = await _imagePicker.pickMultiImage(
        maxWidth: 1800,
        maxHeight: 1800,
        imageQuality: 85,
      );

      for (final img in images) {
        if (uploadedFiles.length < 5) {
          uploadedFiles.add(File(img.path));
        }
      }

      if (images.isNotEmpty) {
        ApptoastUtils.showSuccess('${images.length} image(s) added');
      }
    } catch (e) {
      AppLogger.error('Failed to pick images: $e');
      ApptoastUtils.showError('Failed to pick images');
    }
  }

  void removeFile(int index) {
    uploadedFiles.removeAt(index);
  }

  // Get payment method display name
  String getPaymentMethodDisplayName(String method) {
    switch (method) {
      case 'cash':
        return 'Cash';
      case 'upi':
        return 'UPI';
      case 'bank_transfer':
        return 'Bank Transfer';
      case 'cheque':
        return 'Cheque';
      case 'bkash':
        return 'Bkash';
      default:
        return method;
    }
  }

  // Submit payment method
  Future<void> submitPayment(Map<String, dynamic> customerData) async {
    if (!canSubmit.value) return;

    isLoading.value = true;
    uploadProgress.value = 0.0;
    showProgress.value = true;

    try {
      // Create payment fields exactly as requested
      final paymentFields = {
        'companyId': customerData['companyId'],
        'customerId': customerData['customerId'],
        'mode': selectedPaymentMethod.value,
        'amount': double.parse(amountController.text),
        'remarks': remarksController.text.isNotEmpty
            ? remarksController.text
            : 'Payment for customer ${customerData['customerName']}',
      };

      AppLogger.info('Payment Fields: $paymentFields');

      final response = await _apiService.uploadFilesAuth(
        'payment',
        fields: paymentFields,
        files: uploadedFiles,
        fileFieldName: 'documents',
        onProgress: (sent, total) {
          if (total > 0) {
            final progress = sent / total;
            uploadProgress.value = progress;

            if (sent % 50000 == 0 || sent == total) {
              final sentKB = (sent / 1024).toStringAsFixed(1);
              final totalKB = (total / 1024).toStringAsFixed(1);
              AppLogger.debug(
                  '📤 Upload: ${sentKB}KB / ${totalKB}KB (${(progress * 100).toStringAsFixed(1)}%)');
            }
          }
        },
      );

      final data = response.data;
      AppLogger.info('Payment Response: $data');

      if (data['success'] == true) {
        showProgress.value = false;

        // Reset form
        resetForm();

        // Refresh payments list
        fetchPayments();

        Navigator.pop(Get.context!);
        ApptoastUtils.showGetXSuccess(
          'Payment Successful 🎉',
          'Your payment of ₹${amountController.text} has been processed.',
        );
      } else {
        throw Exception(data['message'] ?? 'Payment failed');
      }
    } catch (e) {
      showProgress.value = false;
      String errorMessage = 'Please try again';

      if (e is DioException) {
        if (e.response != null) {
          errorMessage =
              'HTTP ${e.response!.statusCode}: ${e.response!.data?['message'] ?? e.response!.statusMessage}';
          AppLogger.error('Dio Error Response: ${e.response!.data}');
        } else {
          errorMessage = 'Network error: ${e.message}';
          AppLogger.error('Network error: ${e.message}');
        }
      } else {
        errorMessage = e.toString();
        AppLogger.error('Payment submission error: $e');
      }

      ApptoastUtils.showGetXError('Payment Failed ❌', errorMessage);
    } finally {
      isLoading.value = false;
      uploadProgress.value = 0.0;
    }
  }

  // Reset form after successful submission
  void resetForm() {
    selectedCustomer.value = '';
    selectedPaymentMethod.value = 'cash';
    amountController.clear();
    remarksController.clear();
    uploadedFiles.clear();
    amountError.value = '';
    canSubmit.value = false;
  }
}
