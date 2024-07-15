import 'package:my_flutter_module/ui/utils/theme/theme.dart';

class CommonText extends StatelessWidget {
  final String title;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final double? fontSize;
  final Color? clrFont;
  final int? maxLines;
  final TextAlign? textAlign;
  final TextDecoration? textDecoration;
  final TextStyle? textStyle;
  final TextOverflow? overflow;

  const CommonText(
      {Key? key,
      this.title = '',
      this.fontWeight,
      this.fontStyle,
      this.fontSize,
      this.clrFont,
      this.maxLines,
      this.textAlign,
      this.textDecoration,
      this.textStyle,
      this.overflow})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textScaleFactor: 1.0,
      //-- will not change if system fonts size changed
      maxLines: maxLines ?? 1,
      textAlign: textAlign ?? TextAlign.start,
      // overflow: overflow??TextOverflow.ellipsis,
      style: textStyle ??
          TextStyle(
              fontFamily: TextStyles.fontFamily,
              fontWeight: fontWeight ?? TextStyles.fwRegular,
              fontSize: fontSize ?? 14.sp,
              color: clrFont ?? AppColors.black,
              fontStyle: fontStyle ?? FontStyle.normal,
              decoration: textDecoration ?? TextDecoration.none),
    );
  }
}
