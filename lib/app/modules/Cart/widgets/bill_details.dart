import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';

class BillDetails extends GetView<CartController> {
  final Size size;
  final ThemeData theme;

  const BillDetails({
    super.key,
    required this.size,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: 12.w, vertical: 4.h), // -4 from 16, 8
      padding: EdgeInsets.all(16.w), // -4 from 20
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r), // -4 from 20
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
          Row(
            children: [
              Icon(
                Icons.receipt_long_outlined,
                size: 16.w, // -4 from 20
                color: theme.colorScheme.primary,
              ),
              SizedBox(width: 4.w), // -4 from 8
              Text(
                'Bill Details',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.sp, // Adjusted
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h), // -4 from 16
          Obx(() => _buildBillRows()),
          SizedBox(height: 8.h), // -4 from 12
          Obx(() => _buildGrandTotal()),
        ],
      ),
    );
  }

  Widget _buildBillRows() {
    return Column(
      children: [
        _buildBillRow(
          'Sub Total',
          '₹${controller.subtotal.value.toStringAsFixed(0)}',
          false,
          false,
        ),
        SizedBox(height: 8.h), // -4 from 12
        _buildBillRow(
          'Discount',
          '-₹${controller.totalDiscount.value.toStringAsFixed(0)}',
          true,
          false,
        ),
        SizedBox(height: 8.h), // -4 from 12
        _buildBillRow(
          'Delivery Charges',
          controller.deliveryCharge.value > 0
              ? '₹${controller.deliveryCharge.value.toStringAsFixed(0)}'
              : 'FREE',
          false,
          controller.deliveryCharge.value == 0,
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h), // -4 from 12
          child: Divider(
            thickness: 1,
            color: theme.colorScheme.primary.withOpacity(0.2),
          ),
        ),
      ],
    );
  }

  Widget _buildBillRow(
      String title, String value, bool isDiscount, bool isFree) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.7),
            fontSize: 12.sp, // Adjusted
          ),
        ),
        Text(
          value,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 12.sp, // Adjusted
            color: isDiscount
                ? Colors.green
                : isFree
                    ? Colors.green
                    : theme.colorScheme.onSurface,
          ),
        ),
      ],
    );
  }

  Widget _buildGrandTotal() {
    return Container(
      padding: EdgeInsets.all(8.w), // -4 from 12
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer.withOpacity(0.3),
        borderRadius: BorderRadius.circular(8.r), // -4 from 12
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Grand Total',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 12.sp, // Adjusted
            ),
          ),
          Text(
            '₹${controller.grandTotal.value.toStringAsFixed(0)}',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
              fontSize: 14.sp, // Adjusted
            ),
          ),
        ],
      ),
    );
  }
}
