import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

mobileDeviceConfiguration(BuildContext context) {
  return ScreenUtil.init(
    context,
    designSize: const Size(375, 812),
    minTextAdapt: true,
  );
}

webDeviceConfiguration(BuildContext context) {
  return ScreenUtil.init(
    context,
    designSize: const Size(1920, 1080),
    minTextAdapt: true,
  );
}
