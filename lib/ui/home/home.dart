import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'mobile/home_mobile.dart';
import 'web/home_web.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  ///Build Override
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(mobile: (BuildContext context) {
      return const HomeMobile();
    }, desktop: (BuildContext context) {
      return const HomeWeb();
    });
  }
}
