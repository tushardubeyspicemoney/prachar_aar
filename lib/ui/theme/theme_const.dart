// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:my_flutter_module/ui/theme/const.dart';

/*
  * -- Enum (DO NOT MAKE CHANGES)
  * */

class Constant {
  Constant._();

  static Constant instance = Constant._();

  String appName = "Getsy vendor";
  static const String active_app_language = 'ApplicationLanguage';

/*
  * -- Dimen
  * */
  double infiniteSize = double.infinity;

  /*
  * -- Time Formate
  * */
  String str12Hr = "hh:mm a";
  String str24Hr = "hh:mm:ss";

  ///App Language
  String langAR = "ar";
  String langEN = "en";

  /*
  * ------------------------ Colors ----------------------------------------- *
  * */
  MaterialColor colorPrimary = MaterialColor(0xffF6253B, colorSwathes);

  static Map<int, Color> colorSwathes = {
    50: const Color(0xff293897),
    100: const Color(0xffBFC3E0),
    200: const Color(0xff949CCB),
    300: const Color(0xff6974B6),
    400: const Color(0xff4956A7),
    500: const Color(0xff293897),
    600: const Color(0xff24328F),
    700: const Color(0xff1F2B84),
    800: const Color(0xff19247A),
    900: const Color(0xff0F1769),
  };

  Color clrPrimary = const Color(0xff293897);

  Color clrBlack = const Color(0xff000000);
  Color clrTransparent = const Color(0x00000000);
  Color clrNearWhite = const Color(0xffF2F6FA);
  Color clrWhite = const Color(0xffFFFFFF);
  Color clrBorder = const Color(0xff979797);
  Color clrTextGrey = const Color(0xff6B6B6B);
  Color clrTextGreyLight = const Color(0xff8E8E8E);
  Color clrBGGrey = const Color(0xffBCBCBC);
  Color clrGreyLight = const Color(0xffB1B1B1);
  Color clrOffWhite = const Color(0xffF6F6F6);
  Color clrBGGreyLight = const Color(0xffF9F9F9);
  Color clrBorderGrey = const Color(0xffC7C7C7);
  Color clrGreen = const Color(0xff25AE72);
  Color clrTealGreen = const Color(0xff6AA045);
  Color clrGreenLight = const Color(0xff1FA47B);
  Color clrBGGreenLight = const Color(0xffF2FDFB);
  Color clrRed = const Color(0xffEC1C23);
  Color clrDarkGrey = const Color(0xff4E4E4E);
  Color clrLightGrey = const Color(0xffCFCFCF);
  Color clrDivider = const Color(0xffC9C9C9);
  Color clrOrange = const Color(0xffFFA200);
  Color clrOrangeLight = const Color(0xffFCF8F2);
  Color clrBlue = const Color(0xff0C84C2);
  Color clrBGBlueLight = const Color(0xffF2F9FC);
  Color clrPink = const Color(0xffD2456B);
  Color clrPinkLight = const Color(0xffCF5576);
  Color clrBrown = const Color(0xff76512D);
  Color clrBrownLight = const Color(0xff707070);
  Color clrPurpleLight = const Color(0xff911AEB);
  Color clrPurpleDark = const Color(0xff000B43);
  Color clrBlueDark = const Color(0xff101C63);

  Color clrGreyBg = const Color(0xffEEEEEE);

  Color clrLightBlueGradient = const Color(0xff1DD8FF);
  Color clrBlueGradient = const Color(0xff3CC3DF);
  Color clrDarkBlueGradient = const Color(0xff00BCEC);
  Color clrBoarderBanner = const Color(0xffF7f8fa);

  Color clr0xff91758E = const Color(0xff91758E);
  Color clr0xff293897 = const Color(0xff293897);
  Color clr0xffEEEEF8 = const Color(0xffEEEEF8);
  Color clr0xffE4E4E4 = const Color(0xffE4E4E4);
  Color clr0xffF7F7F7 = const Color(0xffF7F7F7);
  Color clr0xff4050B6 = const Color(0xff4050B6);
  Color clr0xff000089 = const Color(0xff000000);
  Color clr0xff1CC17D = const Color(0xff1CC17D);
  Color clr0xffEBF2F8 = const Color(0xffEBF2F8);
  Color clr0xffF4F4FC = const Color(0xffF4F4FC);
  Color clr0xffF5F5F8 = const Color(0xffF5F5F8);
  Color clrCFCFCF = const Color(0xffCFCFCF);

  ///DarkMode Color
  ///------------- Dark Mode setup Start---------------///
  Color clrTextByTheme() => isDarkMode ? clrWhiteNew : clrBlackNew;

  Color clrTextMainFontByTheme() => isDarkMode ? clrWhiteNew : Color(clrFont);

  Color clrTextGreyByTheme() => isDarkMode ? clrLightGreyNew : Color(clrFontGrey);

  Color clrTextDarkGreyByTheme() => isDarkMode ? clrLightGreyNew : clrDarkGreyNew;

  Color clrTabBGByTheme() => isDarkMode ? clrTextGrey : clrLightGreyNew;

  Color clrTextByScaffoldTheme() => isDarkMode ? clrBlackNew : clrWhiteNew;

  Color clrScaffoldBGByTheme() => isDarkMode ? clrScaffoldBGNew : clrWhiteNew;

  Color clrONBoardingScaffoldBGByTheme() => isDarkMode ? clrScaffoldBGNew : clrBGGreyLight;

  Color clrCardBGByTheme() => isDarkMode ? clrDarkGreyNew : clrWhiteNew;

  Color clrSnackBarBGByTheme() => isDarkMode ? clrDarkGreyNew : clrBlackNew;

  Color clrBlurByTheme() => isDarkMode ? clrBlack.withOpacity(0.9) : clrGreyBg.withOpacity(0.9);

  Color clrBGGreyDarkByTheme() => isDarkMode ? clrWhite : clrGreyBg;

  Color clrDialogBGByTheme() => (isDarkMode ? clrWhite : clrBlack).withOpacity(0.3);

  // Color clrTextBlueByTheme() => isDarkMode ? clrWhiteNew : clr;
  // Color clrIconByTheme() => isDarkMode ? clrWhiteNew : clrTextBlue;
  // Color clrDialogBGByTheme() => (isDarkMode ? clrWhiteNew : clrBlackNew).withOpacity(0.3);
  // Color clrDialogBGByTheme() => (isDarkMode ? clrDarkDialog :clrWhite);

  Color clrBlackNew = const Color(0xff000000);
  Color clrWhiteNew = const Color(0xffFFFFFF);
  Color clrDarkPink = const Color(0xffFF385C);
  Color clrMainFontNew = const Color(0xff010101);
  Color clrLightGreyNew = const Color(0xff8A8A8A);
  Color clrDarkGreyNew = const Color(0xff292929);
  Color clrScaffoldBGNew = const Color(0xff191919);

  int clrFont = 0xff333333;
  int clrFontGrey = 0xff989898;

/*
  * ------------------------ FontStyle ----------------------------------------- *
  * */
  String fontFamily = "Roboto";

  // FontWeight fwThin = FontWeight.w100;
  //FontWeight fwExtraLight = FontWeight.w200;
  //FontWeight fwLight = FontWeight.w300;
  FontWeight fwRegular = FontWeight.normal;
  FontWeight fwMedium = FontWeight.w500;

  //FontWeight fwSemiBold = FontWeight.w600;
  FontWeight fwBold = FontWeight.bold;

  //FontWeight fwExtraBold = FontWeight.w800;

/*
  * ------------------------ Texts ----------------------------------------- *
  * */

/*
 * ----------------------------- Images---------------------------------------- *
 */

  static String assets = 'assets/images/';

  //splash
  String icSplash = '${assets}report_card.png';

  /// Banner
  String icBanner1 = '${assets}banner1.png';
  String icBanner2 = '${assets}banner2.png';

  /// Share
  String icWhatsApp = "${assets}ic_whatsapp.png";
  String icFacebook = "${assets}ic_facebook.png";
  String icShare = "${assets}ic_share.png";

  /// Check
  String icCheck = "${assets}ic_check.png";

  String icBackArrowShare = '${assets}back-arrow.png';

  //login
  String icBackArrow = '${assets}ic_back.png';
  String icShop = '${assets}ic_shop.png';
  String icOffer = '${assets}ic_offer.png';
  String icBannerBg = '${assets}banner_bg.png';
  String icGreenTick = '${assets}ic_green_tick.png';

  String icVideoCamera = '${assets}ic_video_camera.png';
  String icHindi = '${assets}ic_hindi.png';
  String icPoster = '${assets}ic_poster.png';
  String icShopNameBG = '${assets}ic_shopname_bg.png';
  String icPoster2 = '${assets}ic_poster2.png';
  String icCloseGrey = '${assets}ic_close_grey.png';
  String icSelectRight = '${assets}ic_select_right.png';
  String icGallery = '${assets}ic_gallery.png';
  String icCamera = '${assets}ic_camera.png';
  String icSpiceMoneyPrachar = '${assets}ic_spicemoney_prachar.png';
  String icVideoBg = '${assets}ic_videobg.png';
  String icDownArrow = '${assets}ic_down_arrow.png';
  String icStep1 = '${assets}ic_step1.png';
  String icStep2 = '${assets}ic_step2.png';
  String icStep3 = '${assets}ic_step3.png';
  String icArrow = '${assets}ic_arrow.png';
  String icEn = '${assets}ic_en.jpeg';
}

enum enum_AddressSaveAS { Home, Office, Custom }

const Map<enum_AddressSaveAS, String> enum_AddressSaveASNames = {
  enum_AddressSaveAS.Home: "Home",
  enum_AddressSaveAS.Office: "Office",
  enum_AddressSaveAS.Custom: "Custom",
};

///enum for  filter
enum enumOfferDetail { fromStoreSalonArtist, fromAll }
