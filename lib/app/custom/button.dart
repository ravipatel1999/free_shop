import 'package:flutter/material.dart';
import '../core/theme/ summer_colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double height;
  final double width;
  final Color? color; // Allow null, so we can check if it’s provided
  final EdgeInsets padding;
  final BorderRadius borderRadius;
  final TextStyle textStyle;
  final Border? border; // Add a border parameter
  final List<Widget> children; // Add a list of children widgets

  CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.height = 35,
    this.width = double.infinity,
    this.color, // Nullable color to allow default use
    this.padding = EdgeInsets.zero,
    this.borderRadius = const BorderRadius.all(Radius.circular(9)),
    this.textStyle = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: SummerColors.textLight,
      height: 1.4,
      letterSpacing: 0.5,
    ),
    this.border, // Initialize the border parameter
    this.children = const [], // Default empty list for children
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: border, // Apply the border if provided
        borderRadius: borderRadius,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color ??
              SummerColors.color2, // Use default color if color is null
          minimumSize: Size(width, height),
          padding: padding,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius,
            side: border != null
                ? BorderSide(
                    color: border!.top.color,
                    width: border!.top.width,
                    style: border!.top.style,
                  )
                : BorderSide.none, // Conditionally apply border side
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: textStyle,
            ),
            ...children,
          ],
        ),
      ),
    );
  }
}
