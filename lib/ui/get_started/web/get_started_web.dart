import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_flutter_module/framework/utility/extension/extension.dart';
import 'package:my_flutter_module/ui/routing/navigation_stack_item.dart';
import 'package:my_flutter_module/ui/routing/stack.dart';
import 'package:my_flutter_module/ui/utils/theme/app_strings.dart';
import 'package:my_flutter_module/ui/utils/theme/theme.dart';
import 'package:my_flutter_module/ui/utils/widgets/common_button.dart';
import 'package:my_flutter_module/ui/utils/widgets/common_device_configuration.dart';
import 'package:my_flutter_module/ui/utils/widgets/common_svg.dart';
import 'package:my_flutter_module/ui/utils/widgets/common_text.dart';

class GetStartedWeb extends ConsumerStatefulWidget {
  const GetStartedWeb({Key? key}) : super(key: key);

  @override
  ConsumerState<GetStartedWeb> createState() => _GetStartedWebState();
}

class _GetStartedWebState extends ConsumerState<GetStartedWeb> {
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
    webDeviceConfiguration(context);
    return Scaffold(
      body: _bodyWidget(),
    );
  }

  ///Body Widget
  Widget _bodyWidget() {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Row(
      children: [
        // SizedBox(
        //   height: screenHeight,
        //   width: screenWidth,
        //   child: Container(),
        // ),
        Expanded(
          child: Image.asset(
            AppAssets.getStartedBg,
            fit: BoxFit.cover,
            width: screenWidth * 0.5,
            //height: screenHeight,
          ),
        ),
        // Positioned(
        //   top: 30,
        //   left: 20,
        //   child: InkWell(
        //     onTap: () {
        //       try {
        //         js.context.callMethod("CloseSession");
        //       } catch (e) {
        //         printData(e);
        //       }
        //     },
        //     child: const CommonSVG(
        //       strIcon: AppAssets.svgBackGetStartedScreen,
        //     ),
        //   ),
        // ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              CommonSVG(
                strIcon: AppAssets.svgPrachar,
                height: screenHeight * 0.07,
                width: screenWidth * 0.16,
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
              SizedBox(height: 20.h),
              CommonText(
                title: 'अपने ऑफर्स WhatsApp और Facebook पर शेयर करें और तरक्की की राह पर आगे बढ़ें',
                maxLines: 2,
                textStyle: TextStyles.medium.copyWith(
                  fontSize: 22.sp,
                  color: AppColors.black.withOpacity(0.7),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30.h,
              ),
              createNewOfferButton(),
            ],
          ).paddingSymmetric(horizontal: 70.w, vertical: 20.h),
        ),
      ],
    );
  }

  ///Floating Action Button Widget
  Widget createNewOfferButton() {
    final screenWidth = MediaQuery.of(context).size.width;
    return CommonButton(
      width: screenWidth * 0.2,
      onTap: () {
        ref.read(navigationStackProvider).push(const NavigationStackItem.dashboard());
      },
      buttonText: LocalizationStrings.keyCreateAnOffer,
      rightImage: AppAssets.svgRightArrow,
      buttonTextStyle: TextStyles.txtMedium23.copyWith(color: AppColors.white),
      rightImageHeight: 25.h,

      rightImageWidth: 25.w,
      // borderRadius: BorderRadius.circular(18.r),
    ).paddingSymmetric(horizontal: 10.w, vertical: 10.h);
  }
}
