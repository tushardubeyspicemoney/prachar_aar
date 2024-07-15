import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'mobile/dashboard_mobile.dart';
import 'web/dashboard_web.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  ///Build Override
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(mobile: (BuildContext context) {
      return const DashboardMobile();
    }, desktop: (BuildContext context) {
      return const DashboardWeb();
    });
  }
}
