import 'package:my_flutter_module/framework/utility/extension/string_extension.dart';
import 'package:my_flutter_module/ui/utils/theme/app_strings.dart';

String? validateText(String? value, String error) {
  if (value == null || value.trim().isEmpty /* || value.trim().length < 3*/) {
    return error;
  } else {
    return null;
  }
}

String? validateHourAndMinute(String? value, String error) {
  if (value == null || value.trim().length > 2 || value.trim().isEmpty) {
    return error;
  } else {
    return null;
  }
}

String? validateGstNumber(String? value) {
  if (value == null || value.trim().length < 15) {
    return '';
  } else {
    return null;
  }
}

String? validateLoginPassword(String? value) {
  if (value == null || value.trim().length < 8 || value.trim().length > 16) {
    return LocalizationStrings.keyPasswordRangeValidation;
  } else {
    return null;
  }
}

String? validatePassword(String? value, bool forPass) {
  String removeWhiteSpace = value!.replaceAll(' ', '');

  bool hasUppercase = removeWhiteSpace.contains(RegExp(r'[A-Z]'));
  bool hasDigits = removeWhiteSpace.contains(RegExp(r'[0-9]'));
  bool hasLowercase = removeWhiteSpace.contains(RegExp(r'[a-z]'));
  bool hasSpecialCharacters = removeWhiteSpace.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

  if (value.removeWhiteSpace.isEmpty) {
    return forPass ? LocalizationStrings.keyRequiredPassword : LocalizationStrings.keyRequiredConfirmPassword;
  } else if (value.removeWhiteSpace.length > 16 || value.removeWhiteSpace.length < 8) {
    return forPass
        ? LocalizationStrings.keyPasswordRangeValidation
        : LocalizationStrings.keyConfirmPasswordRangeValidation;
  } else if (!hasUppercase) {
    return forPass
        ? LocalizationStrings.keyRequiredUppercaseChar
        : LocalizationStrings.keyRequiredUppercaseCharForConfirmPass;
  } else if (!hasLowercase) {
    return forPass
        ? LocalizationStrings.keyRequiredLowercaseChar
        : LocalizationStrings.keyRequiredLowercaseCharForConfirmPass;
  } else if (!hasDigits) {
    return forPass
        ? LocalizationStrings.keyRequiredNumberChar
        : LocalizationStrings.keyRequiredNumberCharForConfirmPass;
  } else if (!hasSpecialCharacters) {
    return forPass
        ? LocalizationStrings.keyRequiredSpecialChar
        : LocalizationStrings.keyRequiredSpecialCharForConfirmPass;
  } else {
    return null;
  }
}

String? validateMobile(String? value) {
// Indian Mobile number are of 10 digit only
  if (value == null || value.trim().length < 10) {
    return 'Mobile Number must be of 10 digit.';
  } else {
    return null;
  }
}

String? validateEmail(String? value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = RegExp(pattern.toString());
  if (value == null || value.trim().isEmpty) {
    return LocalizationStrings.keyEmailRequired;
  } else if (!regex.hasMatch(value)) {
    return LocalizationStrings.keyInvalidEmailValidation;
  } else {
    return null;
  }
}
