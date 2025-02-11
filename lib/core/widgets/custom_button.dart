import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store_app/core/helper/app_colors.dart';

import '../constants/constants.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.buttonText,
    this.buttonTextColor,
    this.onPressed, this.fontSize,
  });
  final String buttonText;
  final Color? buttonTextColor;
  final double? fontSize;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.h,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.r),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: fontSize ?? 18.sp,
            color: buttonTextColor ?? AppColors.primaryColor,
            fontFamily: AppConstants.kFontFamily,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
