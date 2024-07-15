import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:my_flutter_module/ui/utils/theme/theme.dart';
import 'package:my_flutter_module/ui/utils/widgets/common_text.dart';

const String appName = 'Prachar UI';

bool getIsIOSPlatform() => Platform.isIOS;

bool getIsAppleSignInSupport() => (iosVersion >= 13);
int iosVersion = 11;

String getDeviceType() => getIsIOSPlatform() ? 'iphone' : 'android';

int maxMobileLength = 10;

double globalPadding = 16.w;

String commonImage =
    'https://images.unsplash.com/photo-1677611998429-1baa4371456b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1932&q=80';

///Debug print
printData(data) {
  if (kDebugMode) {
    print(data);
  }
}

/// Hide Keyboard
hideKeyboard(BuildContext context) {
  FocusScope.of(context).unfocus();
}

///Show SnackBar
showCustomSnackBar(String title, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: AppColors.primary,
      content: CommonText(
        title: title,
        textStyle: TextStyles.semiBold.copyWith(
          fontSize: 24.sp,
          color: AppColors.white,
        ),
      ),
      showCloseIcon: true,
      closeIconColor: AppColors.white,
    ),
  );
}
