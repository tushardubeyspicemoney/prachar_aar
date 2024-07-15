import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_flutter_module/ui/edit_offer_image/mobile/edit_offer_image_mobile.dart';
import 'package:my_flutter_module/ui/edit_offer_image/web/edit_offer_image_web.dart';
import 'package:responsive_builder/responsive_builder.dart';

class EditOfferImage extends ConsumerStatefulWidget {
  const EditOfferImage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _CreateOfferTextState();
}

class _CreateOfferTextState extends ConsumerState<EditOfferImage> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(mobile: (BuildContext context) {
      return const EditOfferImageMobile();
    }, desktop: (BuildContext context) {
      return const EditOfferImageWeb();
    });
  }
}
