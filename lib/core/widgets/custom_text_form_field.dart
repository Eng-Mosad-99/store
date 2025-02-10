import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store_app/core/helper/app_colors.dart';
import 'build_border.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.suffixIcon,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.hntText,
    this.maxLines,
    this.prefixIcon,
    this.hintStyle,
    this.validator,
    this.onChanged,
  });
  final Widget? suffixIcon, prefixIcon;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? hntText;
  final TextStyle? hintStyle;
  final int? maxLines;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      obscuringCharacter: '*',
      maxLines: maxLines ?? 1,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hntText,
        hintStyle: hintStyle,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
        focusedBorder: buildBorder(),
        enabledBorder: buildBorder(),
        border: buildBorder(),
      ),
    );
  }
}
