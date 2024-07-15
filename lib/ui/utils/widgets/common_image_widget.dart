import 'dart:html';
import 'dart:ui_web' as ui;

import 'package:my_flutter_module/ui/utils/theme/theme.dart';

class CommonImageWidget extends StatefulWidget {
  final String image;
  final double? width;
  final double? height;

  const CommonImageWidget({super.key, required this.image, this.width, this.height});

  @override
  State<CommonImageWidget> createState() => _CommonImageWidgetState();
}

class _CommonImageWidgetState extends State<CommonImageWidget> {
  @override
  void initState() {
    image();
    super.initState();
  }

  void image() {
    try {
      ui.platformViewRegistry.registerViewFactory(
        widget.image,
        (int viewId) {
          var image = ImageElement();
          image.src = widget.image;
          image.width = (widget.width ?? 250.w).toInt();
          image.height = (widget.height ?? 250.h).toInt();
          return image;
        },
      );
    } catch (E) {
      print("error --> $E");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? 250.w,
      height: widget.height ?? 250.h,
      child: HtmlElementView(viewType: widget.image),
    );
  }
}
