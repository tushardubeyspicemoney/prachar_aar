import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'mobile/branding_mobile.dart';
import 'web/branding_web.dart';

class Branding extends StatelessWidget {
  const Branding({Key? key}) : super(key: key);

  ///Build Override
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(mobile: (BuildContext context) {
      return const BrandingMobile();
    }, desktop: (BuildContext context) {
      return const BrandingWeb();
    });
  }
}
