import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_flutter_module/ui/utils/theme/app_colors.dart';

class TextStyles {
  TextStyles._();

  static String fontFamily = 'Roboto';
  static String secondaryFontFamily = 'Poppins';

  static FontWeight fwThin = FontWeight.w100;
  static FontWeight fwExtraLight = FontWeight.w200;
  static FontWeight fwLight = FontWeight.w300;
  static FontWeight fwRegular = FontWeight.w400;
  static FontWeight fwMedium = FontWeight.w500;
  static FontWeight fwSemiBold = FontWeight.w600;
  static FontWeight fwBold = FontWeight.w700;
  static FontWeight fwExtraBold = FontWeight.w800;

  static TextStyle get regular =>
      TextStyle(color: AppColors.textMainFontByTheme(), fontSize: 14.sp, fontWeight: fwRegular, fontFamily: fontFamily);

  static TextStyle get medium =>
      TextStyle(color: AppColors.textMainFontByTheme(), fontSize: 14.sp, fontWeight: fwMedium, fontFamily: fontFamily);

  static TextStyle get semiBold => TextStyle(
      color: AppColors.textMainFontByTheme(), fontSize: 14.sp, fontWeight: fwSemiBold, fontFamily: fontFamily);

  static TextStyle get bold =>
      TextStyle(color: AppColors.textMainFontByTheme(), fontSize: 14.sp, fontWeight: fwBold, fontFamily: fontFamily);

  static TextStyle get txtMedium12 => TextStyle(
        color: AppColors.textMainFontByTheme(),
        fontSize: 12.sp,
        fontWeight: fwMedium,
        fontFamily: fontFamily,
      );

  static TextStyle get txtMedium14 => TextStyle(
        color: AppColors.textMainFontByTheme(),
        fontSize: 14.sp,
        fontWeight: fwMedium,
        fontFamily: fontFamily,
      );

  static TextStyle get txtMedium16 => TextStyle(
        color: AppColors.textMainFontByTheme(),
        fontSize: 16.sp,
        fontWeight: fwMedium,
        fontFamily: fontFamily,
      );

  static TextStyle get txtMedium18 => TextStyle(
        color: AppColors.textMainFontByTheme(),
        fontSize: 18.sp,
        fontWeight: fwMedium,
        fontFamily: fontFamily,
      );

  static TextStyle get txtRegular7 => TextStyle(
        color: AppColors.textMainFontByTheme(),
        fontSize: 7.sp,
        fontWeight: fwRegular,
        fontFamily: fontFamily,
      );

  static TextStyle get txtRegular23 => TextStyle(
        color: AppColors.textMainFontByTheme(),
        fontSize: 23.sp,
        fontWeight: fwRegular,
        fontFamily: fontFamily,
      );

  static TextStyle get txtMedium23 => TextStyle(
        color: AppColors.textMainFontByTheme(),
        fontSize: 23.sp,
        fontWeight: fwMedium,
        fontFamily: fontFamily,
      );

  static TextStyle get txtRegular10 => TextStyle(
        color: AppColors.textMainFontByTheme(),
        fontSize: 10.sp,
        fontWeight: fwRegular,
        fontFamily: fontFamily,
      );

  static TextStyle get txtRegular14 => TextStyle(
        color: AppColors.textMainFontByTheme(),
        fontSize: 14.sp,
        fontWeight: fwRegular,
        fontFamily: fontFamily,
      );
}
