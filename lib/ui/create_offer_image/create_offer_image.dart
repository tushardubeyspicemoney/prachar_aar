import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_flutter_module/ui/create_offer_image/mobile/create_offer_image_mobile.dart';
import 'package:my_flutter_module/ui/create_offer_image/web/create_offer_image_web.dart';
import 'package:responsive_builder/responsive_builder.dart';

class CreateOfferImage extends ConsumerStatefulWidget {
  const CreateOfferImage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _CreateOfferTextState();
}

class _CreateOfferTextState extends ConsumerState<CreateOfferImage> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(mobile: (BuildContext context) {
      return const CreateOfferImageMobile();
    }, desktop: (BuildContext context) {
      return const CreateOfferImageWeb();
    });
  }
}
