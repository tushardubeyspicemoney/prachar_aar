import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'mobile/offer_mobile.dart';
import 'web/offer_web.dart';

class Offer extends StatelessWidget {
  const Offer({Key? key}) : super(key: key);

  ///Build Override
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(mobile: (BuildContext context) {
      return const OfferMobile();
    }, desktop: (BuildContext context) {
      return const OfferWeb();
    });
  }
}
