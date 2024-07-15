import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_flutter_module/ui/poster_details/mobile/poster_details_mobile.dart';
import 'package:my_flutter_module/ui/poster_details/web/poster_details_web.dart';
import 'package:responsive_builder/responsive_builder.dart';

class PosterDetails extends ConsumerStatefulWidget {
  const PosterDetails({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _PosterDetailsState();
}

class _PosterDetailsState extends ConsumerState<PosterDetails> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(mobile: (BuildContext context) {
      return const PosterDetailsMobile();
    }, desktop: (BuildContext context) {
      return const PosterDetailsWeb();
    });
  }
}
