import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'constant/app_color.dart';
import 'constant/input_Style.dart';

// ignore: must_be_immutable
class CustomTextFormField extends StatelessWidget {
  final Alignment? alignment;
  final double? width;
  final bool? readOnly;
  final EdgeInsetsGeometry? margin;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final VoidCallback? onPressed;
  final VoidCallback? onButtonTap;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;
  final TextCapitalization? textCapitalization;
  final bool? autofocus;
  final TextStyle? textStyle;
  final bool? obscureText;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final int? maxLines;
  final int? maxLength;
  final String? hintText;
  final String? labelText;
  final TextStyle? labelTextStyle;
  final TextStyle? hintStyle;
  final Widget? prefix;
  final BoxConstraints? prefixConstraints;
  final Widget? suffix;
  final BoxConstraints? suffixConstraints;
  final EdgeInsets? contentPadding;
  final InputBorder? borderDecoration;
  final Color? fillColor;
  final bool? filled;
  final FormFieldValidator<String>? validator;

  CustomTextFormField({
    super.key,
    this.alignment,
    this.width,
    this.margin,
    this.maxLength,
    this.controller,
    this.focusNode,
    this.autofocus = false,
    this.textStyle,
    this.obscureText = false,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
    this.maxLines,
    this.hintText,
    this.hintStyle,
    this.prefix,
    this.prefixConstraints,
    this.suffix,
    this.textCapitalization,
    this.suffixConstraints,
    this.contentPadding,
    this.borderDecoration,
    this.fillColor,
    this.filled = false,
    this.readOnly,
    this.labelText,
    this.labelTextStyle,
    this.validator,
    this.onButtonTap,
    this.onChanged,
    this.onPressed,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    print('Building CustomTextFormField with alignment: $alignment');
    return alignment != null
        ? Align(
            alignment: alignment!,
            child: textFormFieldWidget,
          )
        : textFormFieldWidget;
  }

  Widget get textFormFieldWidget => Container(
        decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(8)),
        width: width ?? double.infinity,
        margin: margin ?? const EdgeInsets.only(top: 5),
        child: TextFormField(
          textCapitalization:
              textCapitalization ?? TextCapitalization.sentences,
          controller: controller,
          focusNode: focusNode ?? FocusNode(),
          autofocus: autofocus!,
          style: textStyle ?? AppStyles.inputStyle,
          readOnly: readOnly ?? false,
          maxLength: maxLength,
          obscureText: obscureText!,
          textInputAction: textInputAction,
          keyboardType: textInputType,
          maxLines: maxLines,
          decoration: decoration,
          validator: validator,
          inputFormatters: inputFormatters,
          onChanged: onChanged,
        ),
      );

  InputDecoration get decoration => InputDecoration(
        labelText: labelText ?? "",
        labelStyle: labelTextStyle ?? AppStyles.inputFloatingStyle,
        hintText: hintText ?? "",
        hintStyle: hintStyle,
        counterText: '',
        prefixIcon: prefix,
        prefixIconConstraints: prefixConstraints,
        suffixIcon: suffix,
        suffixIconConstraints: suffixConstraints,
        isDense: true,
        contentPadding: contentPadding ?? const EdgeInsets.all(13),
        fillColor: fillColor,
        filled: filled,
        border: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: AppColors.hintColor,
                width: 0,
              ),
            ),
        enabledBorder: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: AppColors.hintColor,
                width: 0,
              ),
            ),
        focusedBorder: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: AppColors.hintColor,
                width: 0,
              ),
            ),
      );
}

// ignore: must_be_immutable
class MultilineInputBox extends StatelessWidget {
  String hintTabel, labelText;
  TextEditingController ctr;
  List<TextInputFormatter>? inputFormatters;
  ValueChanged<String>? onChanged;
  VoidCallback? onInputTap;
  TextInputType? keyboardType;
  bool isReadOnly;

  MultilineInputBox(
      {super.key,
      required this.hintTabel,
      required this.labelText,
      required this.ctr,
      this.inputFormatters,
      this.keyboardType,
      this.onInputTap,
      this.isReadOnly = false,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: AppColors.whiteColor),
      margin: const EdgeInsets.only(top: 20),
      child: TextField(
        onChanged: onChanged,
        controller: ctr,
        onTap: onInputTap,
        readOnly: isReadOnly,
        inputFormatters: inputFormatters,
        style: const TextStyle(color: AppColors.primaryColor),
        minLines: 3,
        maxLines: 3,
        textAlign: TextAlign.start,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          fillColor: AppColors.whiteColor,
          contentPadding: const EdgeInsets.only(left: 8, top: 8),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.hintColor, width: 1.0),
              borderRadius: BorderRadius.all(Radius.circular(6))),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.hintColor, width: 1.0),
              borderRadius: BorderRadius.all(Radius.circular(6))),
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.hintColor, width: 1.0),
              borderRadius: BorderRadius.all(Radius.circular(6))),
          labelText: labelText,
          hintText: hintTabel,
          labelStyle: AppStyles.inputFloatingStyle,
        ),
      ),
    );
  }
}
