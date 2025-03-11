import 'package:path/path.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';





class CustomTextField extends HookWidget {
  final AutovalidateMode? autovalidateMode;
  final TextEditingController? controller;
  final String? initialValue;
  final TextInputType? keyboardType;
  final bool obscureText;
  void Function(String)? onChanged;
  void Function()? onTab;
  final bool readOnly;
  final String? Function(String?)? validator;
  final int? maxlines;
  final String hintText;
  final String? helperText;
  final bool? isCollapsed;
  final bool isDense;
  final Widget? label;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextInputAction? textInputAction;
  final EdgeInsetsGeometry? contendPadding;
  Color? fillColor;
  CustomTextField({
    required this.controller,
    required this.hintText,
    this.contendPadding,
    this.fillColor,
    this.textInputAction,
    this.suffixIcon,
    this.prefixIcon,
    this.label,
    this.isDense = false,
    this.isCollapsed,
    this.helperText,
    this.readOnly = false,
    this.maxlines,
    this.validator,
    this.obscureText = false,
    this.onTab,
    this.onChanged,
    this.keyboardType,
    this.initialValue,
    this.autovalidateMode, required Null Function() onTap,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: autovalidateMode,
      controller: controller,
      cursorColor: Colors.blue.withOpacity(0.7),
      textInputAction: textInputAction,
      initialValue: initialValue,
      keyboardType: keyboardType,
      maxLines: maxlines ?? 1,
      obscureText: obscureText,
      obscuringCharacter: '•',
      onChanged: onChanged,
      onTap: onTab,
      readOnly: readOnly,
      style:TextStyle(),
      textAlign: TextAlign.left,
      validator: validator,
      decoration: InputDecoration(
        filled: true,
        fillColor: fillColor ?? Colors.grey.withOpacity(0.2),
        hintText: hintText,
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(18.sp),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color:Colors.blue.withOpacity(0.7), width: 2.0),
          borderRadius: BorderRadius.circular(18.sp),
        ),
        hintStyle:TextStyle(),
        contentPadding: EdgeInsets.only(left: 5.w, top: 2.3.h),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(18.sp),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color:Colors.red),
          borderRadius: BorderRadius.circular(18.sp),
        ),
        errorStyle: TextStyle(),
        helperStyle: TextStyle(),
        helperText: helperText,
        isCollapsed: isCollapsed,
        isDense: isDense,
        label: label,
        labelStyle:TextStyle(),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
      ),
    );
  }
}
