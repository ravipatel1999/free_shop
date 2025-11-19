import 'package:eccomerce_app/app/modules/Cart/controllers/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../shopping/controllers/shopping_controller.dart';

class CartEmptyState extends StatelessWidget {
  const CartEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: EdgeInsets.all(20.w), // -4 from 24
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: size.width * 0.4,
              height: size.width * 0.4,
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.shopping_cart_outlined,
                size: size.width * 0.2,
                color: theme.colorScheme.primary.withOpacity(0.5),
              ),
            ),
            SizedBox(height: size.height * 0.04),
            Text(
              'Your cart is empty',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 20.sp, // Adjusted
              ),
            ),
            SizedBox(height: size.height * 0.015),
            Text(
              'Add some amazing items to get started!',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.6),
                fontSize: 14.sp, // Adjusted
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: size.height * 0.04),
            FilledButton.icon(
              onPressed: () {
                if (Get.isRegistered<ShoppingController>()) {
                  final shoppingController = Get.put(ShoppingController());
                  final cartController = Get.put(CartController());
                  shoppingController.refreshProducts();
                  cartController.fetchCartItems();
                }
                Navigator.pop(context);
              },
              icon: Icon(Icons.shopping_bag_outlined, size: 18.w), // Adjusted
              label: Text('Start Shopping',
                  style: TextStyle(fontSize: 14.sp)), // Adjusted
              style: FilledButton.styleFrom(
                padding: EdgeInsets.symmetric(
                    horizontal: 28.w, vertical: 12.h), // -4 from 32, 16
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r), // -4 from 16
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
