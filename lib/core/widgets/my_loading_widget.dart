import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyLoadingWidget extends StatelessWidget {
  const MyLoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 10.w,
        height: 10.h,
        child: CircularProgressIndicator(
          strokeWidth: 1.sp,
          color: Colors.white,
        ),
      ),
    );
  }
}
