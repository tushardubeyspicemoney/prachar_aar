import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'mobile/get_started_mobile.dart';
import 'web/get_started_web.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({Key? key}) : super(key: key);

  ///Build Override
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(mobile: (BuildContext context) {
      return const GetStartedMobile();
    }, desktop: (BuildContext context) {
      return const GetStartedWeb();
    });
  }
}
