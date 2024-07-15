import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static bool isDarkMode = false;

  static const Color primary = Color(0xff293897);
  static const Color primaryEEF0FA = Color(0xffEEF0FA);
  static const Color borderPrimary = Color(0xff4B58A8);
  static const Color textPrimary = Color(0xff39479F);
  static const Color textSecondary = Color(0xff4C4C4C);
  static const Color disabledBorder = Color(0xffDEDCDB);
  static const Color black343434 = Color(0xff343434);
  static const Color white = Color(0xffFFFFFF);
  static const Color clrB5B5B5 = Color(0xffB5B5B5);
  static const Color black = Color(0xff000000);
  static const Color lightGrey = Color(0xffE8E8EC);
  static const Color grey = Color(0xff808080);
  static const Color darkGreen = Color(0xff5B6F70);
  static const Color scaffoldBG = Color(0xffFFFFFF);
  static const Color pinch = Color(0xffDAA16A);
  static const Color yellow = Color(0xffFFB156);
  static const Color transparent = Color(0x00000000);
  static const Color red = Color(0xffEC1C23);
  static const Color lightRed = Color(0xffFA6063);
  static const Color blue = Color(0xff007AFF);
  static const Color green = Color(0xff5CAE6D);
  static const Color gradient1 = Color(0xff2B3D97);
  static const Color gradient2 = Color(0xFFdb4232);
  static const Color gradient3 = Color(0xFF7e3365);
  static const Color clrCFCFCF = Color(0xffCFCFCF);
  static Color clr0xffF5F5F8 = const Color(0xffF5F5F8);
  static Color clr409DB9 = const Color(0xff409DB9);
  static Color clrF84E3D = const Color(0xffF84E3D);
  static Color clrBgCheckBox = const Color(0xffEEF0FA);

  /// APP COLORS
  static MaterialColor colorPrimary = MaterialColor(0xffFEC34D, colorSwathes);

  static Map<int, Color> colorSwathes = {
    50: const Color.fromRGBO(254, 195, 77, .1),
    100: const Color.fromRGBO(254, 195, 77, .2),
    200: const Color.fromRGBO(254, 195, 77, .3),
    300: const Color.fromRGBO(254, 195, 77, .4),
    400: const Color.fromRGBO(254, 195, 77, .5),
    500: const Color.fromRGBO(254, 195, 77, .6),
    600: const Color.fromRGBO(254, 195, 77, .7),
    700: const Color.fromRGBO(254, 195, 77, .8),
    800: const Color.fromRGBO(254, 195, 77, .9),
    900: const Color.fromRGBO(254, 195, 77, .1),
  };

  static Color textByTheme() => isDarkMode ? white : primary;

  static Color textMainFontByTheme() => isDarkMode ? white : textPrimary;

  static Color scaffoldBGByTheme() => isDarkMode ? black : scaffoldBG;

// static Color textByTheme() => isDarkMode ? white : primary;
}
