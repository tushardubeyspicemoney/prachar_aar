import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_flutter_module/ui/faq/mobile/faq_mobile.dart';
import 'package:responsive_builder/responsive_builder.dart';

class Faq extends ConsumerStatefulWidget {
  const Faq({Key? key}) : super(key: key);

  @override
  ConsumerState<Faq> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends ConsumerState<Faq> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) => const FaqMobile(),
      desktop: (BuildContext context) => Container(),
    );
  }
}
