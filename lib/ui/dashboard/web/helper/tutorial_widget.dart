import 'package:my_flutter_module/ui/theme/theme_const.dart';
import 'package:my_flutter_module/ui/utils/theme/app_strings.dart';
import 'package:my_flutter_module/ui/utils/theme/theme.dart';
import 'package:my_flutter_module/ui/utils/widgets/common_svg.dart';
import 'package:my_flutter_module/ui/utils/widgets/common_text.dart';

class TutorialWidget extends StatelessWidget {
  const TutorialWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 30.h),
        Text(
          LocalizationStrings.keyNotAbleToCreateOffer,
          style: TextStyles.medium.copyWith(fontSize: 24.sp, color: AppColors.black),
        ),
        SizedBox(height: 30.h),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Constant.instance.clr0xffE4E4E4),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Image.asset(
                      AppAssets.getStartedBg,
                      fit: BoxFit.cover,
                      height: 250.h,
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  Expanded(
                    flex: 4,
                    child: Column(
                      children: [
                        const CommonSVG(
                          strIcon: AppAssets.svgPrachar,
                          boxFit: BoxFit.cover,
                        ),
                        SizedBox(height: 25.h),
                        CommonText(
                          title: LocalizationStrings.keyHowToCreateOffer,
                          maxLines: 2,
                          textStyle: TextStyles.bold.copyWith(
                            fontSize: 20.sp,
                            color: AppColors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              CommonSVG(
                strIcon: AppAssets.svgYoutube,
                height: 38.h,
                width: 38.w,
              ),
            ],
          ),
        )
      ],
    );
  }
}
