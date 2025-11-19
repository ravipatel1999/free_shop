import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';

class SpecialInstructions extends GetView<CartController> {
  final Size size;
  final ThemeData theme;
  final bool isInContainer;

  const SpecialInstructions({
    super.key,
    required this.size,
    required this.theme,
    required this.isInContainer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: isInContainer
          ? EdgeInsets.zero
          : EdgeInsets.symmetric(
              horizontal: 12.w, vertical: 4.h), // -4 from 16, 8
      padding: EdgeInsets.all(16.w), // -4 from 20
      decoration: isInContainer
          ? null
          : BoxDecoration(
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
                Icons.note_alt_outlined,
                size: 16.w, // -4 from 20
                color: theme.colorScheme.primary,
              ),
              SizedBox(width: 4.w), // -4 from 8
              Text(
                'Special Instructions',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.sp, // Adjusted
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h), // -4 from 12
          TextField(
            onChanged: (value) => controller.specialInstructions.value = value,
            maxLines: 2,
            decoration: InputDecoration(
              hintText: 'Any special requests? Let us know...',
              hintStyle: TextStyle(
                color: theme.colorScheme.onSurface.withOpacity(0.4),
                fontSize: 12.sp, // Adjusted
              ),
              filled: true,
              fillColor:
                  theme.colorScheme.surfaceContainerHighest.withOpacity(0.3),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r), // -4 from 12
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.all(12.w), // -4 from 16
            ),
          ),
        ],
      ),
    );
  }
}
