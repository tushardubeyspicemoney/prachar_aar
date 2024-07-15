import 'package:my_flutter_module/framework/utility/extension/extension.dart';
import 'package:my_flutter_module/ui/utils/theme/theme.dart';
import 'package:my_flutter_module/ui/utils/widgets/common_svg.dart';

class CommonButton extends StatelessWidget {
  final double? height;
  final double? width;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderWidth;
  final BorderRadius? borderRadius;
  final String? leftImage;
  final double? leftImageHeight;
  final double? leftImageWidth;
  final double? leftImageHorizontalPadding;
  final String? rightImage;
  final double? rightImageHeight;
  final double? rightImageWidth;
  final double? rightImageHorizontalPadding;
  final double? fontSize;
  final String? buttonText;
  final int? buttonMaxLine;
  final TextStyle? buttonTextStyle;
  final double? buttonHorizontalPadding;
  final GestureTapCallback? onTap;
  final TextAlign? buttonTextAlignment;
  final Color? buttonTextColor;
  final bool? isGradient;
  final bool? isPrefixEnable;

  const CommonButton({
    Key? key,
    this.height,
    this.width,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.leftImage,
    this.leftImageHeight,
    this.leftImageWidth,
    this.leftImageHorizontalPadding,
    this.rightImage,
    this.rightImageHeight,
    this.rightImageWidth,
    this.rightImageHorizontalPadding,
    this.buttonText,
    this.buttonMaxLine,
    this.buttonTextStyle,
    this.buttonHorizontalPadding,
    this.onTap,
    this.buttonTextAlignment,
    this.buttonTextColor,
    this.isGradient = true,
    this.isPrefixEnable,
    this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap?.call();
      },
      child: Container(
        height: height ?? 49.h,
        width: width ?? double.infinity,
        decoration: BoxDecoration(
            color: backgroundColor ?? AppColors.primary,
            borderRadius: borderRadius ?? BorderRadius.circular(5.r),
            border: Border.all(color: borderColor ?? AppColors.transparent, width: borderWidth ?? 0)),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: buttonHorizontalPadding ?? 0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  (isPrefixEnable ?? false)
                      ? const Icon(
                          Icons.edit,
                          color: AppColors.white,
                          size: 15,
                        )
                      : Container(),
                  (isPrefixEnable ?? false) ? SizedBox(width: 5.w) : Container(),
                  Text(
                    buttonText ?? '',
                    textAlign: buttonTextAlignment ?? TextAlign.center,
                    maxLines: buttonMaxLine ?? 1,
                    style: buttonTextStyle ??
                        TextStyles.medium.copyWith(
                          fontSize: fontSize ?? 17.sp,
                          color: buttonTextColor ?? AppColors.white,
                        ),
                  ),
                ],
              ),
            ).alignAtCenter(),
            if ((rightImage ?? '').isNotEmpty)
              Positioned(
                right: 0,
                top: 0,
                bottom: 0,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: rightImageHorizontalPadding ?? 12.w, vertical: 15.h),
                  child: CommonSVG(
                    strIcon: rightImage!,
                    height: rightImageHeight,
                    width: rightImageWidth,
                  ),
                ),
              ),
            if ((leftImage ?? '').isNotEmpty)
              Positioned(
                left: 0,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: leftImageHorizontalPadding ?? 12.w, vertical: 12.h),
                  child: CommonSVG(
                    strIcon: leftImage!,
                    height: leftImageHeight,
                    width: leftImageWidth,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/*
Widget Usage
CommonButton(
          buttonText: "Login",
          onTap: () {

          },
        )
* */
