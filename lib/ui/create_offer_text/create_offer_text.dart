import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_flutter_module/ui/create_offer_text/mobile/create_offer_text_mobile.dart';
import 'package:my_flutter_module/ui/create_offer_text/web/create_offer_text_web.dart';
import 'package:responsive_builder/responsive_builder.dart';

class CreateOfferText extends ConsumerStatefulWidget {
  const CreateOfferText({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _CreateOfferTextState();
}

class _CreateOfferTextState extends ConsumerState<CreateOfferText> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(mobile: (BuildContext context) {
      return const CreateOfferTextMobile();
    }, desktop: (BuildContext context) {
      return const CreateOfferTextWeb();
    });
  }
}
