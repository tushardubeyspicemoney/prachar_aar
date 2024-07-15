import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_flutter_module/framework/utility/extension/extension.dart';
import 'package:my_flutter_module/ui/routing/navigation_stack_item.dart';
import 'package:my_flutter_module/ui/routing/stack.dart';
import 'package:my_flutter_module/ui/utils/const/app_constants.dart';
import 'package:my_flutter_module/ui/utils/theme/app_strings.dart';
import 'package:my_flutter_module/ui/utils/theme/theme.dart';
import 'package:my_flutter_module/ui/utils/widgets/common_button.dart';
import 'package:my_flutter_module/ui/utils/widgets/common_device_configuration.dart';
import 'package:my_flutter_module/ui/utils/widgets/common_svg.dart';
import 'package:my_flutter_module/ui/utils/widgets/common_text.dart';

class GetStartedMobile extends ConsumerStatefulWidget {
  const GetStartedMobile({Key? key}) : super(key: key);

  @override
  ConsumerState<GetStartedMobile> createState() => _GetStartedMobileState();
}

class _GetStartedMobileState extends ConsumerState<GetStartedMobile> {
  ///Init Override
  @override
  void initState() {
    super.initState();
  }

  ///Dispose Override
  @override
  void dispose() {
    super.dispose();
  }

  ///Build Override
  @override
  Widget build(BuildContext context) {
    mobileDeviceConfiguration(context);
    return Scaffold(
      body: _bodyWidget(),
    );
  }

  ///Body Widget
  Widget _bodyWidget() {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        SizedBox(
          height: screenHeight,
          width: screenWidth,
          child: Container(),
        ),
        Image.asset(
          AppAssets.getStartedBg,
          fit: BoxFit.cover,
          //width: screenWidth,
          //height: screenHeight,
        ),
        Positioned(
          top: 30,
          left: 20,
          child: InkWell(
            onTap: () {
              try {
                ref.read(navigationStackProvider).pop();
              } catch (e) {
                printData(e);
              }
            },
            child: const CommonSVG(
              strIcon: AppAssets.svgBackGetStartedScreen,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          //bottom: 20,
          left: 0,
          right: 0,
          child: ClipPath(
            clipper: OvalTopBorderClipper(),
            child: Container(
              width: double.infinity,
              color: AppColors.white,
              child: Column(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CommonSVG(
                        strIcon: AppAssets.svgPrachar,
                      ),
                      SizedBox(height: 25.h),
                      CommonText(
                        title: 'प्रचार द्वारा अपने ऑफर्स खुद बनायें और अपना बिज़नेस बढ़ायें',
                        maxLines: 2,
                        textStyle: TextStyles.bold.copyWith(
                          fontSize: 20.sp,
                          color: AppColors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 15.h),
                      CommonText(
                        title: 'अपने ऑफर्स WhatsApp और Facebook पर शेयर करें और तरक्की की राह पर आगे बढ़ें',
                        maxLines: 2,
                        textStyle: TextStyles.medium.copyWith(
                          fontSize: 16.sp,
                          color: AppColors.black.withOpacity(0.7),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ).paddingSymmetric(horizontal: 70.w, vertical: 20.h),
                  SizedBox(
                    height: 30.h,
                  ),
                  CommonButton(
                    onTap: () {
                      ref.read(navigationStackProvider).push(const NavigationStackItem.dashboard());
                    },
                    buttonText: LocalizationStrings.keyCreateAnOffer,
                    rightImage: AppAssets.svgRightArrow,
                    rightImageHeight: 15.h,
                    rightImageWidth: 15.w,
                  ).paddingSymmetric(horizontal: 10.w, vertical: 10.h),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
