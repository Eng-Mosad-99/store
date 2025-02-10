
import 'package:easy_localization/easy_localization.dart';

import '../locale/app_translations.dart';

class MyValidators {
  static String? displayNamevalidator(String? displayName,
      {int minLenth = 3, int maxLenth = 20}) {
    if (displayName == null || displayName.isEmpty) {
      return kDisplayNameEmpty.tr();
    }
    if (displayName.length < minLenth || displayName.length > maxLenth) {
      return kDisplayNameLength.tr();
    }

    return null; // Return null if display name is valid
  }



  static String? emailValidator(String? value) {
    if (value!.isEmpty) {
      return kEmailEmpty.tr();
    }
    if (!RegExp(r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b')
        .hasMatch(value)) {
      return kEmailInvalid.tr();
    }
    return null;
  }

  static String? phoneValidator(String? value) {
    if (value == null || value.isEmpty) {
      return kPhoneEmpty.tr();
    }
    if (!RegExp(r'^\+?[0-9]{9,15}$').hasMatch(value)) {
      return kPhoneInvalid.tr();
    }
    return null;
  }


  static String? passwordValidator(String? value) {
    if (value!.isEmpty) {
      return kPasswordEmpty.tr();
    }
    if (value.length < 6) {
      return kPasswordLength.tr();
    }
    return null;
  }

  static String? confirmPasswordValidator({String? value, String? password}) {
    if (value != password) {
      return kPasswordMismatch.tr();
    }
    return null;
  }


}
