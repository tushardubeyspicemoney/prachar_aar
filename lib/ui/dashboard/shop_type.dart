import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'mobile/shop_type_mobile.dart';
import 'web/shop_type_web.dart';

class ShopType extends StatelessWidget {
  const ShopType({Key? key}) : super(key: key);

  ///Build Override
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(mobile: (BuildContext context) {
      return const ShopTypeMobile();
    }, desktop: (BuildContext context) {
      return const ShopTypeWeb();
    });
  }
}
