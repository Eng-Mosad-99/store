import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store_app/core/helper/app_colors.dart';

import '../locale/app_translations.dart';

void showLanguageDialog(
  BuildContext context, {
  required String selectedLanguage,
  required void Function(String?)? onChanged,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          kChangeLanguage.tr(),
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.blackColor,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<String>(
              title: const Text('English'),
              value: 'en',
              groupValue: selectedLanguage,
              onChanged: onChanged,
            ),
            RadioListTile<String>(
              title: Text(
                kArabic.tr(),
              ),
              value: 'ar',
              groupValue: selectedLanguage,
              onChanged: onChanged,
            ),
          ],
        ),
      );
    },
  );
}
