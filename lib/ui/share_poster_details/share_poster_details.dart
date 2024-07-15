import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_flutter_module/ui/share_poster_details/mobile/share_poster_details_mobile.dart';
import 'package:my_flutter_module/ui/share_poster_details/web/share_poster_details_web.dart';
import 'package:responsive_builder/responsive_builder.dart';

class SharePosterDetails extends ConsumerStatefulWidget {
  const SharePosterDetails({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _PosterDetailsState();
}

class _PosterDetailsState extends ConsumerState<SharePosterDetails> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(mobile: (BuildContext context) {
      return const SharePosterDetailsMobile();
    }, desktop: (BuildContext context) {
      return const SharePosterDetailsWeb();
    });
  }
}
