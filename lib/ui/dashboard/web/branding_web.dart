import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_flutter_module/framework/controller/dashboard/dashboard_provider.dart';
import 'package:my_flutter_module/framework/utility/extension/extension.dart';
import 'package:my_flutter_module/framework/utility/extension/string_extension.dart';
import 'package:my_flutter_module/ui/dashboard/helper/navigation_of_app_bar.dart';
import 'package:my_flutter_module/ui/dashboard/shop_type.dart';
import 'package:my_flutter_module/ui/utils/const/app_constants.dart';
import 'package:my_flutter_module/ui/utils/theme/app_strings.dart';
import 'package:my_flutter_module/ui/utils/theme/theme.dart';
import 'package:my_flutter_module/ui/utils/widgets/common_button.dart';
import 'package:my_flutter_module/ui/utils/widgets/common_device_configuration.dart';
import 'package:my_flutter_module/ui/utils/widgets/common_form_field.dart';
import 'package:my_flutter_module/ui/utils/widgets/common_text.dart';

class BrandingWeb extends ConsumerStatefulWidget {
  const BrandingWeb({Key? key}) : super(key: key);

  @override
  ConsumerState<BrandingWeb> createState() => _BrandingWebState();
}

class _BrandingWebState extends ConsumerState<BrandingWeb> with AutomaticKeepAliveClientMixin {
  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      final shopTypeWatch = ref.watch(shopTypeProvider);
      shopTypeWatch.disposeController(isNotify: true);
      await shopTypeWatch.getIndustryList(false);
      final brandingWatch = ref.watch(brandingProvider);
      brandingWatch.disposeController(isNotify: true);
      brandingWatch.companyNameFocus.requestFocus();
    });
  }

  ///Dispose Override
  @override
  void dispose() {
    super.dispose();
  }

  ///Build Override
  @override
  Widget build(BuildContext context) {
    super.build(context);
    webDeviceConfiguration(context);
    return Scaffold(
      body: _bodyWidget(),
      bottomNavigationBar: Material(
        elevation: 5,
        child: SizedBox(
          child: nextButtonWidget(),
        ),
      ),
    );
  }

  ///Body Widget
  Widget _bodyWidget() {
    final brandingWatch = ref.watch(brandingProvider);
    return Row(
      children: [
        const Expanded(flex: 3, child: SizedBox()),
        Expanded(
          flex: 34,
          child: Column(
            children: [
              const Expanded(child: SizedBox()),
              Expanded(
                flex: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(
                      title: LocalizationStrings.keyWhatIsYourShopName.toLowerCase().capsFirstLetterOfSentence,
                      textStyle: TextStyles.bold.copyWith(
                        fontSize: 26.sp,
                        color: AppColors.black,
                      ),
                    ),
                    SizedBox(height: 40.h),
                    CommonInputFormField(
                      textEditingController: brandingWatch.companyNameTextController,
                      validator: null,
                      focusNode: brandingWatch.companyNameFocus,
                      onChanged: (companyName) {
                        if (companyName.toString().isEmpty) {
                          brandingWatch.updateIsButtonEnabled(false);
                        } else {
                          brandingWatch.updateIsButtonEnabled(true);
                        }
                      },
                      borderColor: AppColors.primary,
                      borderWidth: 1.w,
                      fieldTextStyle: TextStyles.regular.copyWith(fontSize: 22.sp, color: AppColors.black),
                      label: CommonText(
                        title: LocalizationStrings.keyEnterShopName,
                        textStyle: TextStyles.regular.copyWith(fontSize: 22.sp),
                      ),
                    ),
                  ],
                ),
              ),
              const Expanded(child: SizedBox()),
            ],
          ),
        ),
        const Expanded(child: SizedBox()),
      ],
    );
  }

  ///Widget Next Button Widget
  Widget nextButtonWidget() {
    final brandingWatch = ref.watch(brandingProvider);
    final shopTypeWatch = ref.watch(shopTypeProvider);
    return Padding(
      padding: EdgeInsets.only(top: 14.h, bottom: 14.h),
      child: Row(
        children: [
          const Expanded(
            flex: 50,
            child: SizedBox(),
          ),
          Expanded(
            flex: 10,
            child: CommonButton(
              height: MediaQuery.of(context).size.height * 0.07,
              buttonText: LocalizationStrings.keyNext,
              fontSize: 24.sp,
              borderRadius: BorderRadius.circular(5.r),
              backgroundColor: brandingWatch.isButtonEnabled ? AppColors.primary : AppColors.primary.withOpacity(0.2),
              onTap: () async {
                hideKeyboard(context);

                //print("....index at Next Button....${dashboardWatch.currentTabIndex}");
                if (brandingWatch.isButtonEnabled) {
                  //print(".....ShopType Called.......");
                  navigateToNextPageWeb(ref, const ShopType());
                } else {
                  // ignore: use_build_context_synchronously
                  showCustomSnackBar(LocalizationStrings.keyPleaseEnterShopName, context);
                }
              },
            ),
          ),
          const Expanded(flex: 2, child: SizedBox()),
        ],
      ).paddingOnly(bottom: 40.h),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
