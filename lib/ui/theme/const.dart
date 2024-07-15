import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';

///Hive Object
var userBox = Hive.box('userBox');

///Dark Mode setup
bool isDarkMode = false;
//Constant Values
int maxMobileLength = 10;
int maxEmailLength = 40;
int maxTextLength6 = 6;
int minPasswordLength = 8;
int maxPasswordLength = 16;
int maxTextLength30 = 30;
int maxTextLength60 = 40;
int maxAboutUsLength = 200;
int maxPriceLength = 8;
int maxOfferClaimLength = 3;
int maxOfferDiscountLength = 2;
int maxPinCodeLength = 6;

String KEY_APP_THEME_DARK = 'key_app_theme_dark';

bool? getIsAppThemeDark() => (userBox.get(KEY_APP_THEME_DARK));

///Device Details Properties
bool getIsIOSPlatform() => Platform.isIOS;

String getDeviceType() => getIsIOSPlatform() ? "iphone" : "android";

///Get Text Style
TextStyle getTextStyle(
    {required String fontFamily,
    Color txtColor = Colors.black,
    TextDecoration txtDecoration = TextDecoration.none,
    required double fontSize,
    required FontWeight fontWeight}) {
  return TextStyle(
    fontFamily: fontFamily,
    fontSize: fontSize.sp,
    fontWeight: fontWeight,
    color: txtColor,
    decoration: txtDecoration,
  );
}

///Show Log
showLog(String str) {
  print("-> $str");
}

///Get Localize Text
String getLocalValue(String key) {
  return key.tr();
}

///Hide Keyboard
hideKeyboard(BuildContext context) {
  FocusScope.of(context).unfocus();
}

///Save Local Data
saveLocalData(String key, value) {
  userBox.put(key, value);
  showLog("Saved new data into your local Key - $key Value - ${userBox.get(key)}");
}

/// For Height of Keyboard when it is Opened
SizedBox addPaddingWhenKeyboardAppears() {
  final viewInsets = EdgeInsets.fromWindowPadding(
    WidgetsBinding.instance.window.viewInsets,
    WidgetsBinding.instance.window.devicePixelRatio,
  );

  final bottomOffset = viewInsets.bottom;
  const hiddenKeyboard = 0.0; // Always 0 if keyboard is not opened
  final isNeedPadding = bottomOffset != hiddenKeyboard;
  return SizedBox(height: isNeedPadding ? bottomOffset : hiddenKeyboard);
}

///Set Height
double setHeight(var height) {
  return ScreenUtil().setHeight(height);
}

///Set Width
double setWidth(var width) {
  return ScreenUtil().setWidth(width);
}

///Set SP
double setSp(var fontSize) {
  return ScreenUtil().setSp(fontSize);
}
