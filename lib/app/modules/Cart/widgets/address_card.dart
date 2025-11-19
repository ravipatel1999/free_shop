import 'package:eccomerce_app/app/core/data/sharedPre.dart';
import 'package:eccomerce_app/app/core/utils/appString/app_storage_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../services/toast_service.dart';
import '../../customer/controllers/customer_controller.dart';
import '../controllers/cart_controller.dart';

class AddressCard extends GetView<CartController> {
  final Size size;
  final ThemeData theme;

  const AddressCard({
    super.key,
    required this.size,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10.w,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCustomerSection(context),
          SizedBox(height: 16.h),
          _buildAddressSection(context),
        ],
      ),
    );
  }

  Widget _buildCustomerSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(4.w),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Icon(
                    Icons.person_outline,
                    color: theme.colorScheme.primary,
                    size: 16.w,
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  'Customer',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
            InkWell(
              onTap: () => _showCustomerSelection(context),
              borderRadius: BorderRadius.circular(6.r),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.swap_horiz,
                      size: 12.w,
                      color: theme.colorScheme.primary,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      'Change',
                      style: TextStyle(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 11.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Obx(() => _buildCustomerContent()),
      ],
    );
  }

  Widget _buildCustomerContent() {
    if (controller.selectedCustomer.value == null) {
      return InkWell(
        onTap: () => _showCustomerSelection(Get.context!),
        borderRadius: BorderRadius.circular(8.r),
        child: Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.3),
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
              color: theme.colorScheme.outline.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.person_add_outlined,
                color: theme.colorScheme.primary.withOpacity(0.7),
                size: 16.w,
              ),
              SizedBox(width: 8.w),
              Text(
                'Select a customer',
                style: TextStyle(
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                  fontSize: 11.sp,
                ),
              ),
            ],
          ),
        ),
      );
    }

    final customer = controller.selectedCustomer.value!;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: theme.colorScheme.primary.withOpacity(0.2),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 36.w,
            height: 36.h,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                customer['customerName']
                        ?.toString()
                        .substring(0, 1)
                        .toUpperCase() ??
                    'C',
                style: TextStyle(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  customer['customerName'] ?? 'N/A',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 11.sp,
                  ),
                ),
                SizedBox(height: 1.h),
                Text(
                  customer['phoneNumber'] ?? 'N/A',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.6),
                    fontSize: 11.sp,
                  ),
                ),
                if (customer['emailAddress'] != null) ...[
                  SizedBox(height: 1.h),
                  Text(
                    customer['emailAddress'] ?? '',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.6),
                      fontSize: 10.sp,
                    ),
                  ),
                ],
              ],
            ),
          ),
          IconButton(
            onPressed: () => controller.clearSelectedCustomer(),
            icon: Icon(
              Icons.clear,
              size: 14.w,
              color: theme.colorScheme.onSurface.withOpacity(0.4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(4.w),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Icon(
                    Icons.location_on_outlined,
                    color: theme.colorScheme.primary,
                    size: 16.w,
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  'Delivery Address',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
            InkWell(
              onTap: () => _showAddressBottomSheet(context),
              borderRadius: BorderRadius.circular(6.r),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.edit_outlined,
                      size: 12.w,
                      color: theme.colorScheme.primary,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      'Edit',
                      style: TextStyle(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 11.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Obx(() => _buildAddressContent()),
      ],
    );
  }

  Widget _buildAddressContent() {
    if (controller.addressLine1.value.isEmpty) {
      return InkWell(
        onTap: () => _showAddressBottomSheet(Get.context!),
        borderRadius: BorderRadius.circular(8.r),
        child: Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.3),
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
              color: theme.colorScheme.outline.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.add_location_alt_outlined,
                color: theme.colorScheme.primary.withOpacity(0.7),
                size: 16.w,
              ),
              SizedBox(width: 8.w),
              Text(
                'Add delivery address',
                style: TextStyle(
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                  fontSize: 11.sp,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          controller.addressLine1.value,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
            height: 1.5,
            fontSize: 11.sp,
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          '${controller.city.value}, ${controller.state.value} - ${controller.zipCode.value}',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.7),
            height: 1.5,
            fontSize: 14.sp,
          ),
        ),
      ],
    );
  }

  void _showCustomerSelection(BuildContext context) {
    // FIX: Use Get.put instead of Get.find to ensure controller is available
    final customerController = Get.put(CustomerController());
    customerController.fetchCustomers();

    showModalBottomSheet(
      context: context,
      constraints: const BoxConstraints(
        maxWidth: double.infinity,
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: size.height * 0.8,
        width: double.infinity,
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Column(
          children: [
            _buildBottomSheetHandle(),
            _buildBottomSheetHeader(
              icon: Icons.person_outline,
              title: 'Select Customer',
              onRefresh: () => customerController.fetchCustomers(),
            ),
            _buildAddCustomer(customerController),
            _buildSearchField(customerController),
            const Divider(height: 1),
            Expanded(
              child: Obx(() => _buildCustomerList(customerController)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField(CustomerController customerController) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: SizedBox(
        height: 60,
        child: TextFormField(
          onChanged: (value) {
            Future.delayed(const Duration(milliseconds: 500), () {
              customerController.fetchCustomers(search: value);
            });
          },
          decoration: InputDecoration(
            hintText: 'Search by ID, Name or Mobile...',
            prefixIcon: Icon(Icons.search,
                color: theme.colorScheme.primary, size: 18.w),
            filled: true,
            fillColor:
                theme.colorScheme.surfaceContainerHighest.withOpacity(0.3),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(
                color: theme.colorScheme.outline.withOpacity(0.3),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(
                color: theme.colorScheme.primary,
                width: 2,
              ),
            ),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomSheetHandle() {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 8.h, bottom: 4.h),
        width: 36.w,
        height: 3.h,
        decoration: BoxDecoration(
          color: theme.colorScheme.onSurface.withOpacity(0.2),
          borderRadius: BorderRadius.circular(2.r),
        ),
      ),
    );
  }

  Widget _buildBottomSheetHeader({
    required IconData icon,
    required String title,
    required VoidCallback onRefresh,
  }) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(6.w),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  icon,
                  color: theme.colorScheme.primary,
                  size: 18.w,
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                title,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: onRefresh,
            icon: Icon(
              Icons.refresh,
              color: theme.colorScheme.primary,
              size: 20.w,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerList(CustomerController customerController) {
    if (customerController.isLoading.value) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: theme.colorScheme.primary,
            ),
            SizedBox(height: 12.h),
            Text(
              'Loading customers...',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.6),
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
      );
    }

    if (customerController.customers.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.people_outline,
              size: 56.w,
              color: theme.colorScheme.onSurface.withOpacity(0.3),
            ),
            SizedBox(height: 12.h),
            Text(
              customerController.searchQuery.value.isEmpty
                  ? 'No customers available'
                  : 'No customers found',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.5),
                fontSize: 14.sp,
              ),
            ),
            SizedBox(height: 4.h),
            if (customerController.searchQuery.value.isNotEmpty)
              Text(
                'Try different search terms',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.4),
                  fontSize: 11.sp,
                ),
              ),
            SizedBox(height: 16.h),
            FilledButton.icon(
              onPressed: () => customerController.fetchCustomers(),
              icon: Icon(Icons.refresh, size: 16.w),
              label: Text('Try Again', style: TextStyle(fontSize: 14.sp)),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(12.w),
      itemCount: customerController.customers.length,
      itemBuilder: (context, index) {
        final customer = customerController.customers[index];
        return _buildCustomerListItem(customer, context, customerController);
      },
    );
  }

  Widget _buildCustomerListItem(Map<String, dynamic> customer,
      BuildContext context, CustomerController customerController) {
    final isSelected =
        controller.selectedCustomer.value?['_id'] == customer['_id'];

    return Container(
      margin: EdgeInsets.only(bottom: 4.h),
      decoration: BoxDecoration(
        color: isSelected
            ? theme.colorScheme.primary.withOpacity(0.1)
            : theme.colorScheme.surfaceContainerHighest.withOpacity(0.3),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: isSelected ? theme.colorScheme.primary : Colors.transparent,
          width: 2,
        ),
      ),
      child: ListTile(
        leading: Container(
          width: 36.w,
          height: 36.h,
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              (customer['customerName'] ?? 'C')
                  .toString()
                  .substring(0, 1)
                  .toUpperCase(),
              style: TextStyle(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
                fontSize: 11.sp,
              ),
            ),
          ),
        ),
        title: Text(
          customer['customerName'] ?? 'N/A',
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 11.sp,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              customer['code'] ?? 'N/A',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.6),
                fontSize: 11.sp,
              ),
            ),
            Text(
              customer['phoneNumber'] ?? 'N/A',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.6),
                fontSize: 11.sp,
              ),
            ),
            if (customer['emailAddress'] != null) ...[
              Text(
                customer['emailAddress'] ?? '',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                  fontSize: 10.sp,
                ),
              ),
            ]
          ],
        ),
        trailing: isSelected
            ? Icon(
                Icons.check_circle,
                color: theme.colorScheme.primary,
                size: 18.w,
              )
            : null,
        onTap: () {
          controller.selectCustomer(customer);

          // Auto-fill address from customer data
          if (customer['addressLine1'] != null &&
              customer['addressLine1'].toString().isNotEmpty) {
            controller.addressLine1.value = customer['addressLine1'] ?? '';
            controller.city.value = customer['city'] ?? '';
            controller.state.value = customer['state'] ?? '';
            controller.zipCode.value = customer['zipCode'] ?? '';
          }

          Navigator.pop(context);
          ApptoastUtils.showSuccess('Customer selected successfully');
        },
      ),
    );
  }

  void _showAddressBottomSheet(BuildContext context) {
    final addressLine1Controller =
        TextEditingController(text: controller.addressLine1.value);
    final cityController = TextEditingController(text: controller.city.value);
    final stateController = TextEditingController(text: controller.state.value);
    final zipCodeController =
        TextEditingController(text: controller.zipCode.value);

    showModalBottomSheet(
      context: context,
      constraints: BoxConstraints(maxWidth: double.infinity),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildBottomSheetHandle(),
                _buildAddressForm(
                  addressLine1Controller,
                  cityController,
                  stateController,
                  zipCodeController,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAddressForm(
    TextEditingController addressLine1Controller,
    TextEditingController cityController,
    TextEditingController stateController,
    TextEditingController zipCodeController,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(6.w),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(
                    Icons.location_on_outlined,
                    color: theme.colorScheme.primary,
                    size: 20.w,
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  'Delivery Address',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp,
                  ),
                ),
              ],
            ),
            IconButton(
                onPressed: () {
                  Navigator.pop(Get.context!);
                },
                icon: Icon(Icons.close_outlined, size: 20.w))
          ],
        ),
        SizedBox(height: 20.h),
        _buildAddressField(
          controller: addressLine1Controller,
          label: 'Address Line 1',
          hint: 'House No., Building, Street',
          icon: Icons.home_outlined,
        ),
        SizedBox(height: 12.h),
        _buildAddressField(
          controller: cityController,
          label: 'City',
          hint: 'Enter your city',
          icon: Icons.location_city_outlined,
        ),
        SizedBox(height: 12.h),
        _buildAddressField(
          controller: zipCodeController,
          label: 'ZIP Code',
          hint: '000000',
          icon: Icons.pin_outlined,
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: 12.h),
        _buildAddressField(
          controller: stateController,
          label: 'State',
          hint: 'State',
          icon: Icons.map_outlined,
        ),
        SizedBox(height: 20.h),
        SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: () {
              controller.addressLine1.value = addressLine1Controller.text;
              controller.city.value = cityController.text;
              controller.state.value = stateController.text;
              controller.zipCode.value = zipCodeController.text;
              Navigator.pop(Get.context!);
            },
            style: FilledButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text(
              'Save Address',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(height: 4.h),
      ],
    );
  }

  Widget _buildAddressField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: TextStyle(
        fontSize: 14.sp,
      ),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        labelStyle: TextStyle(
          fontSize: 14.sp,
          color: theme.colorScheme.onSurface.withOpacity(0.8),
        ),
        hintStyle: TextStyle(
          fontSize: 14.sp,
          color: theme.colorScheme.onSurface.withOpacity(0.4),
        ),
        filled: true,
        fillColor: theme.colorScheme.surfaceContainerHighest.withOpacity(0.3),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(
            color: theme.colorScheme.primary,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(
            color: theme.colorScheme.primary,
            width: 2,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 12.w,
          vertical: 12.h,
        ),
      ),
    );
  }

  // UPDATED: Accept customerController as parameter
  Widget _buildAddCustomer(CustomerController customerController) {
    // Get AuthRepository instance
    final customerCreatPermission =
        SharedpreferenceUtil.getBool(AppStorage.customerCreatPermission);

    // If permission is false, return empty container (hide button)
    if (customerCreatPermission == false) {
      return const SizedBox.shrink();
    }

    // If permission is true, show the button
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: FilledButton.icon(
        onPressed: () => _showAddCustomerBottomSheet(customerController),
        style: FilledButton.styleFrom(
          backgroundColor: Get.theme.colorScheme.primary,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
        icon: Icon(Icons.person_add, size: 16.w),
        label: Text(
          'Add New Customer',
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  // UPDATED: Accept customerController as parameter
  void _showAddCustomerBottomSheet(CustomerController customerController) {
    final customerNameController = TextEditingController();
    final phoneNumberController = TextEditingController();
    final contactPersonController = TextEditingController();
    final addressLine1Controller = TextEditingController();
    final cityController = TextEditingController();
    final stateController = TextEditingController();
    final zipCodeController = TextEditingController();
    final customerEmailController = TextEditingController();

    final countryController = TextEditingController(text: 'India');

    showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      constraints: BoxConstraints(
        maxWidth: double.infinity,
      ),
      builder: (context) => Container(
        height: size.height * 0.9,
        width: double.infinity,
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildBottomSheetHandle(),
                _buildAddCustomerHeader(),
                SizedBox(height: 20.h),
                _buildCustomerForm(
                  customerNameController: customerNameController,
                  phoneNumberController: phoneNumberController,
                  contactPersonController: contactPersonController,
                  addressLine1Controller: addressLine1Controller,
                  cityController: cityController,
                  stateController: stateController,
                  zipCodeController: zipCodeController,
                  countryController: countryController,
                  customerEmailController: customerEmailController,
                ),
                SizedBox(height: 20.h),
                _buildAddCustomerActions(
                  customerController: customerController,
                  customerNameController: customerNameController,
                  phoneNumberController: phoneNumberController,
                  contactPersonController: contactPersonController,
                  addressLine1Controller: addressLine1Controller,
                  cityController: cityController,
                  stateController: stateController,
                  zipCodeController: zipCodeController,
                  countryController: countryController,
                  emailNameController: customerEmailController,
                ),
                SizedBox(height: 10.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAddCustomerHeader() {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(6.w),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  Icons.person_add_outlined,
                  color: theme.colorScheme.primary,
                  size: 18.w,
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                'Add New Customer',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: () => Navigator.pop(Get.context!),
            icon: Icon(Icons.close, size: 20.w),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerForm({
    required TextEditingController customerNameController,
    required TextEditingController phoneNumberController,
    required TextEditingController contactPersonController,
    required TextEditingController addressLine1Controller,
    required TextEditingController cityController,
    required TextEditingController stateController,
    required TextEditingController zipCodeController,
    required TextEditingController countryController,
    required TextEditingController customerEmailController,
  }) {
    return Column(
      children: [
        _buildCustomerFormField(
          controller: customerNameController,
          label: 'Customer Name *',
          hint: 'Enter customer name',
          icon: Icons.person_outline,
          isRequired: true,
        ),
        SizedBox(height: 12.h),
        _buildCustomerFormField(
          controller: phoneNumberController,
          label: 'Phone Number *',
          hint: 'Enter phone number',
          icon: Icons.phone_outlined,
          keyboardType: TextInputType.phone,
          isRequired: true,
        ),
        SizedBox(height: 12.h),
        _buildCustomerFormField(
          controller: customerEmailController,
          label: 'Email Address *',
          hint: 'Enter Email Address',
          icon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
          isRequired: true,
        ),
        SizedBox(height: 12.h),
        _buildCustomerFormField(
          controller: contactPersonController,
          label: 'Contact Person',
          hint: 'Enter contact person name',
          icon: Icons.contact_phone_outlined,
        ),
        SizedBox(height: 12.h),
        _buildCustomerFormField(
          controller: addressLine1Controller,
          label: 'Address Line 1',
          hint: 'House No., Building, Street',
          icon: Icons.home_outlined,
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Expanded(
              child: _buildCustomerFormField(
                controller: cityController,
                label: 'City',
                hint: 'Enter city',
                icon: Icons.location_city_outlined,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _buildCustomerFormField(
                controller: stateController,
                label: 'State',
                hint: 'Enter state',
                icon: Icons.map_outlined,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Expanded(
              child: _buildCustomerFormField(
                controller: zipCodeController,
                label: 'ZIP Code',
                hint: '000000',
                icon: Icons.pin_outlined,
                keyboardType: TextInputType.number,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _buildCustomerFormField(
                controller: countryController,
                label: 'Country',
                hint: 'Country',
                icon: Icons.public_outlined,
                readOnly: true,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCustomerFormField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    bool isRequired = false,
    TextInputType keyboardType = TextInputType.text,
    bool readOnly = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 12.sp,
              ),
            ),
            if (isRequired)
              Text(
                ' *',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.red,
                  fontSize: 12.sp,
                ),
              ),
          ],
        ),
        SizedBox(height: 4.h),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          readOnly: readOnly,
          style: TextStyle(fontSize: 14.sp),
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon, size: 18.w),
            filled: true,
            fillColor:
                theme.colorScheme.surfaceContainerHighest.withOpacity(0.3),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(
                color: theme.colorScheme.outline.withOpacity(0.3),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(
                color: theme.colorScheme.primary,
                width: 2,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 12.h,
            ),
          ),
        ),
      ],
    );
  }

// Add this method to your AddressCard widget
  Widget _buildAddCustomerActions({
    required CustomerController customerController,
    required TextEditingController customerNameController,
    required TextEditingController phoneNumberController,
    required TextEditingController contactPersonController,
    required TextEditingController addressLine1Controller,
    required TextEditingController cityController,
    required TextEditingController stateController,
    required TextEditingController zipCodeController,
    required TextEditingController countryController,
    required TextEditingController emailNameController,
  }) {
    return Obx(() => Column(
          children: [
            if (customerController.isLoading.value)
              Column(
                children: [
                  CircularProgressIndicator(color: theme.colorScheme.primary),
                  SizedBox(height: 12.h),
                  Text(
                    'Adding customer...',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.6),
                      fontSize: 12.sp,
                    ),
                  ),
                  SizedBox(height: 16.h),
                ],
              ),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: customerController.isLoading.value
                        ? null
                        : () => Get.back(),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r)),
                      side: BorderSide(
                          color: theme.colorScheme.outline.withOpacity(0.5)),
                    ),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: theme.colorScheme.onSurface.withOpacity(0.8),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: FilledButton(
                    onPressed: customerController.isLoading.value
                        ? null
                        : () => _createNewCustomer(
                              customerController: customerController,
                              customerName: customerNameController.text.trim(),
                              phoneNumber: phoneNumberController.text.trim(),
                              customerEmail: emailNameController.text.trim(),
                              contactPerson:
                                  contactPersonController.text.trim(),
                              addressLine1: addressLine1Controller.text.trim(),
                              city: cityController.text.trim(),
                              state: stateController.text.trim(),
                              zipCode: zipCodeController.text.trim(),
                              country: countryController.text.trim(),
                            ),
                    style: FilledButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r)),
                    ),
                    child: Text(
                      'Save Customer',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }

// Updated _createNewCustomer method
  Future<void> _createNewCustomer({
    required CustomerController customerController,
    required String customerName,
    required String phoneNumber,
    required String customerEmail,
    required String contactPerson,
    required String addressLine1,
    required String city,
    required String state,
    required String zipCode,
    required String country,
  }) async {
    await customerController.createCustomer(
      customerName: customerName,
      phoneNumber: phoneNumber,
      emailAddress: customerEmail,
      contactPerson: contactPerson,
      addressLine1: addressLine1,
      city: city,
      state: state,
      zipCode: zipCode,
      country: country,
    );
  }
}
