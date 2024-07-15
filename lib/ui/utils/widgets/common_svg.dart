import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CommonSVG extends StatelessWidget {
  final String strIcon;
  final ColorFilter? colorFilter;
  final double? height;
  final double? width;
  final BoxFit boxFit;

  const CommonSVG({Key? key, this.strIcon = '', this.height, this.width, this.boxFit = BoxFit.fill, this.colorFilter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      strIcon,
      colorFilter: colorFilter,
      height: height,
      width: width,
      fit: boxFit,
    );
  }
}
