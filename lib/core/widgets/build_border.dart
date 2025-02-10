import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store_app/core/helper/app_colors.dart';

OutlineInputBorder buildBorder({
  Color? color,
  double? width,
  double? borderRadius,
}) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(borderRadius ?? 8.sp),
    borderSide: BorderSide(
      color: color ?? AppColors.greyColor.withOpacity(.2),
      width: width ?? 1.w,
    ),
  );
}
