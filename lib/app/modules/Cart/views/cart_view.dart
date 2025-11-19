import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';
import '../widgets/cart_content.dart';
import '../widgets/cart_empty_state.dart';
import '../widgets/cart_loading_state.dart';

class CartView extends GetView<CartController> {
  const CartView({super.key});

  void _showClearCartDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.surface,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r), // -4 from 20
          ),
          title: Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w), // -4 from 12
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.error.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.delete_outline,
                  color: Theme.of(context).colorScheme.error,
                  size: 20.w, // -4 from 24
                ),
              ),
              SizedBox(width: 8.w), // -4 from 12
              Text(
                'Clear Cart?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 14.sp, // Adjusted for ScreenUtil
                ),
              ),
            ],
          ),
          content: Text(
            'Are you sure you want to remove all items from your cart? This action cannot be undone.',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              height: 1.4,
              fontSize: 12.sp, // Adjusted for ScreenUtil
            ),
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: OutlinedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(vertical: 8.h), // -4 from 12
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r), // -4 from 12
                      ),
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    ),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.w500,
                        fontSize: 12.sp, // Adjusted for ScreenUtil
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.w), // -4 from 12
                Expanded(
                  child: FilledButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      controller.clearCart();
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.error,
                      padding:
                          EdgeInsets.symmetric(vertical: 8.h), // -4 from 12
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r), // -4 from 12
                      ),
                    ),
                    child: Text(
                      'Clear All',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 12.sp, // Adjusted for ScreenUtil
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          'My Cart',
        ),
        actions: [
          Obx(() {
            if (controller.cartItems.isNotEmpty &&
                !controller.isLoading.value) {
              return Padding(
                padding: EdgeInsets.only(right: 12.w), // -4 from 16
                child: IconButton(
                  onPressed: () => _showClearCartDialog(context),
                  icon: Container(
                    padding: EdgeInsets.all(4.w), // -4 from 8
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onPrimary,
                      borderRadius: BorderRadius.circular(8.r), // -4 from 12
                    ),
                    child: Icon(
                      Icons.delete_outline,
                      color: Theme.of(context).colorScheme.errorContainer,
                    ),
                  ),
                ),
              );
            }
            return const SizedBox();
          }),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const CartLoadingState();
        }

        if (controller.cartItems.isEmpty) {
          return const CartEmptyState();
        }

        return const CartContent();
      }),
    );
  }
}
