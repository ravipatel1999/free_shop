import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';

class ConfirmButton extends GetView<CartController> {
  final Size size;
  final ThemeData theme;

  const ConfirmButton({
    super.key,
    required this.size,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w), // -4 from 16
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20.w,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: FilledButton(
          onPressed: controller.confirmOrder,
          style: FilledButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 14.h), // -4 from 18
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r), // -4 from 16
            ),
            elevation: 0,
          ),
          child: Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle_outline, size: 18.w), // -4 from 22
                  SizedBox(width: 8.w), // -4 from 12
                  Text(
                    'Confirm Order • ₹${controller.grandTotal.value.toStringAsFixed(0)}',
                    style: TextStyle(
                      fontSize: 12.sp, // -4 from 16
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
