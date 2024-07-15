import 'package:flutter/services.dart';
import 'package:my_flutter_module/ui/utils/theme/theme.dart';
import 'package:my_flutter_module/ui/utils/widgets/common_svg.dart';

class CommonInputFormField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String? Function(String?)? validator;

  final String? placeholderImage;
  final double? placeholderImageHeight;
  final double? placeholderImageWidth;
  final double? placeholderImageHorizontalPadding;
  final String? placeholderText;
  final TextStyle? placeholderTextStyle;
  final String? hintText;
  final TextStyle? hintTextStyle;
  final double? fieldWidth;
  final double? fieldHeight;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderWidth;
  final BorderRadius? borderRadius;
  final TextStyle? fieldTextStyle;
  final int? maxLines;
  final int? maxLength;
  final List<TextInputFormatter>? textInputFormatter;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final TextCapitalization? textCapitalization;
  final bool? isEnable;
  final Widget? prefixWidget;
  final Widget? suffixWidget;
  final InputDecoration? inputDecoration;
  final bool? obscureText;
  final double? bottomFieldMargin;
  final double? leftPadding;
  final double? rightPadding;
  final double? topPadding;
  final double? bottomPadding;
  final Function(dynamic text)? onChanged;
  final Widget? suffixLabel;
  final Color? cursorColor;
  final bool? enableInteractiveSelection;
  final bool? readOnly;
  final FocusNode? focusNode;
  final Widget? label;
  final TextAlign? textAlign;

  const CommonInputFormField({
    Key? key,
    required this.textEditingController,
    required this.validator,
    this.placeholderImage,
    this.placeholderImageHeight,
    this.placeholderImageWidth,
    this.placeholderImageHorizontalPadding,
    this.placeholderText,
    this.placeholderTextStyle,
    this.hintText,
    this.hintTextStyle,
    this.fieldWidth,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.fieldTextStyle,
    this.maxLines,
    this.maxLength,
    this.textInputFormatter,
    this.textInputAction,
    this.textInputType,
    this.textCapitalization,
    this.isEnable,
    this.prefixWidget,
    this.suffixWidget,
    this.inputDecoration,
    this.obscureText,
    this.bottomFieldMargin,
    this.onChanged,
    this.suffixLabel,
    this.cursorColor,
    this.enableInteractiveSelection,
    this.readOnly,
    this.fieldHeight,
    this.leftPadding,
    this.rightPadding,
    this.focusNode,
    this.topPadding,
    this.bottomPadding,
    this.label,
    this.textAlign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (((placeholderImage ?? '').isNotEmpty) || ((placeholderText ?? '').isNotEmpty))
          Padding(
            padding: EdgeInsets.only(bottom: 0.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if ((placeholderImage ?? '').isNotEmpty)
                  Padding(
                    padding: EdgeInsets.only(right: placeholderImageHorizontalPadding ?? 0.w),
                    child: CommonSVG(
                      strIcon: placeholderImage!,
                      height: placeholderImageHeight ?? 32,
                      width: placeholderImageWidth ?? 32,
                    ),
                  ),
                if ((placeholderText ?? '').isNotEmpty)
                  Text(
                    placeholderText!,
                    style:
                        placeholderTextStyle ?? TextStyles.regular.copyWith(fontSize: 14.sp, color: AppColors.primary),
                  ),
                if (suffixLabel != null) suffixLabel!
              ],
            ),
          ),
        SizedBox(
          width: fieldWidth ?? double.infinity,
          height: fieldHeight,
          child: Padding(
            padding: EdgeInsets.only(bottom: bottomFieldMargin ?? 0),
            child: TextFormField(
              focusNode: focusNode,
              readOnly: readOnly ?? false,
              cursorColor: cursorColor ?? AppColors.primary,
              controller: textEditingController,
              style: fieldTextStyle ?? TextStyles.regular.copyWith(color: AppColors.black),
              textAlign: textAlign ?? TextAlign.start,
              textAlignVertical: TextAlignVertical.center,
              maxLines: maxLines ?? 1,
              maxLength: maxLength ?? 1000,
              enableInteractiveSelection: enableInteractiveSelection ?? true,
              obscureText: obscureText ?? false,
              inputFormatters: textInputFormatter,
              onChanged: onChanged,
              textInputAction: textInputAction ?? TextInputAction.next,
              keyboardType: textInputType ?? TextInputType.text,
              textCapitalization: textCapitalization ?? TextCapitalization.none,
              decoration: InputDecoration(
                  errorMaxLines: 3,
                  enabled: isEnable ?? true,
                  counterText: '',
                  filled: true,
                  label: label,
                  fillColor: backgroundColor ?? AppColors.transparent,
                  suffixIcon:
                      suffixWidget != null ? Padding(padding: const EdgeInsets.all(2), child: suffixWidget) : null,
                  prefixIcon: prefixWidget,
                  contentPadding: EdgeInsets.only(
                    left: leftPadding ?? 12.w,
                    right: rightPadding ?? 12.w,
                    top: topPadding ?? 12.h,
                    bottom: bottomPadding ?? 12.h,
                  ),
                  enabledBorder: borderColor != null
                      ? OutlineInputBorder(
                          borderSide: BorderSide(
                            color: borderColor ?? AppColors.clrB5B5B5,
                            width: borderWidth ?? 0.5,
                            style: BorderStyle.solid,
                          ),
                          borderRadius: borderRadius ?? BorderRadius.circular(7.r),
                        )
                      : InputBorder.none,
                  focusedBorder: borderColor != null
                      ? OutlineInputBorder(
                          borderSide: BorderSide(
                            color: borderColor ?? AppColors.clrB5B5B5,
                            width: borderWidth ?? 0.5,
                            style: BorderStyle.solid,
                          ),
                          borderRadius: borderRadius ?? BorderRadius.circular(7.r),
                        )
                      : InputBorder.none,
                  border: InputBorder.none,
                  hintText: hintText,
                  alignLabelWithHint: true,
                  hintStyle: hintTextStyle),
              onFieldSubmitted: (text) {
                textEditingController.text = text;
              },
              validator: validator,
            ),
          ),
        )
      ],
    );
  }
}
/*
Widget Usage

CommonInputFormField(
  textEditingController: _mobileController,
  suffixWidget: Image.asset(Assets.imagesIcApple),
  validator: validateEmail,
  backgroundColor: AppColors.pinch,
  prefixWidget: Image.asset(Assets.imagesIcApple),
  placeholderImage: Assets.imagesIcApple,
  placeholderText: 'Mobile Number',
)
*/
