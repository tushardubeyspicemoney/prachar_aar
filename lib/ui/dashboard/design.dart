import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'mobile/design_mobile.dart';
import 'web/design_web.dart';

class Design extends StatelessWidget {
  const Design({Key? key}) : super(key: key);

  ///Build Override
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(mobile: (BuildContext context) {
      return const DesignMobile();
    }, desktop: (BuildContext context) {
      return const DesignWeb();
    });
  }
}
