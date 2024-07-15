import 'package:flutter/material.dart';
import 'package:my_flutter_module/ui/utils/theme/app_colors.dart';

class ThemeStyle {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.scaffoldBGByTheme(),

      hintColor: AppColors.textSecondary,
      // buttonColor: Constant.instance.clrTextByTheme(),
      textTheme: Theme.of(context).textTheme.apply(
            bodyColor: AppColors.textByTheme(),
          ),
      appBarTheme: AppBarTheme(
        elevation: 0.0,
        backgroundColor: AppColors.scaffoldBGByTheme(),
      ),
      colorScheme: ColorScheme.fromSwatch(primarySwatch: AppColors.colorPrimary)
          .copyWith(surface: AppColors.scaffoldBGByTheme()),
    );
  }
}
