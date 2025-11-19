import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeliveryMessage extends StatelessWidget {
  final Size size;
  final ThemeData theme;

  const DeliveryMessage({
    super.key,
    required this.size,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: 12.w, vertical: 4.h), // -4 from 16, 8
      padding: EdgeInsets.all(12.w), // -4 from 16
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.primaryContainer.withOpacity(0.3),
            theme.colorScheme.secondaryContainer.withOpacity(0.3),
          ],
        ),
        borderRadius: BorderRadius.circular(12.r), // -4 from 16
        border: Border.all(
          color: theme.colorScheme.primary.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(6.w), // -4 from 10
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8.r), // -4 from 12
            ),
            child: Icon(
              Icons.local_shipping_outlined,
              color: theme.colorScheme.primary,
              size: 20.w, // -4 from 24
            ),
          ),
          SizedBox(width: 8.w), // -4 from 12
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Free Delivery!',
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                    fontSize: 14.sp, // Adjusted
                  ),
                ),
                SizedBox(height: 1.h), // -4 from 2
                Text(
                  'On orders above ₹200',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.6),
                    fontSize: 11.sp, // Adjusted
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
