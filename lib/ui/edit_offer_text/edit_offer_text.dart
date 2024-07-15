import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_flutter_module/ui/edit_offer_text/mobile/edit_offer_text_mobile.dart';
import 'package:my_flutter_module/ui/edit_offer_text/web/edit_offer_text_web.dart';
import 'package:responsive_builder/responsive_builder.dart';

class EditOfferText extends ConsumerStatefulWidget {
  const EditOfferText({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _CreateOfferTextState();
}

class _CreateOfferTextState extends ConsumerState<EditOfferText> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(mobile: (BuildContext context) {
      return const EditOfferTextMobile();
    }, desktop: (BuildContext context) {
      return const EditOfferTextWeb();
    });
  }
}
