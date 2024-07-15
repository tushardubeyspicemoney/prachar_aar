import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_flutter_module/framework/controller/dashboard/dashboard_provider.dart';
import 'package:my_flutter_module/framework/repository/introduction/model/response_industry_list.dart';
import 'package:my_flutter_module/framework/utility/app_google_analytics/key_analytics.dart';
import 'package:my_flutter_module/framework/utility/app_google_analytics/user_experior.dart';
import 'package:my_flutter_module/framework/utility/extension/extension.dart';
import 'package:my_flutter_module/framework/utility/extension/string_extension.dart';
import 'package:my_flutter_module/ui/dashboard/helper/navigation_of_app_bar.dart';
import 'package:my_flutter_module/ui/dashboard/offer.dart';
import 'package:my_flutter_module/ui/utils/const/app_constants.dart';
import 'package:my_flutter_module/ui/utils/theme/app_strings.dart';
import 'package:my_flutter_module/ui/utils/theme/theme.dart';
import 'package:my_flutter_module/ui/utils/widgets/common_button.dart';
import 'package:my_flutter_module/ui/utils/widgets/common_device_configuration.dart';
import 'package:my_flutter_module/ui/utils/widgets/common_text.dart';
import 'package:my_flutter_module/ui/widgets/loader.dart';

class ShopTypeWeb extends ConsumerStatefulWidget {
  const ShopTypeWeb({Key? key}) : super(key: key);

  @override
  ConsumerState<ShopTypeWeb> createState() => _ShopTypeWebState();
}

class _ShopTypeWebState extends ConsumerState<ShopTypeWeb> with AutomaticKeepAliveClientMixin {
  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      final shopTypeWatch = ref.watch(shopTypeProvider);
      shopTypeWatch.disposeController(isNotify: true);
      await shopTypeWatch.getIndustryList(false);
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
    final shopTypeWatch = ref.watch(shopTypeProvider);
    return Scaffold(
      body: shopTypeWatch.isLoading
          ? const Loader()
          : shopTypeWatch.isError
              ? Center(
                  child: Text(shopTypeWatch.errorMsg),
                )
              : _bodyWidget(),
      floatingActionButton: nextButtonWidget(),
    );
  }

  ///Body Widget
  Widget _bodyWidget() {
    return Row(
      children: [
        const Expanded(child: SizedBox()),
        Expanded(
          flex: 13,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(flex: 1, child: SizedBox()),
              Expanded(
                flex: 1,
                child: CommonText(
                  title: LocalizationStrings.keySelectShopType.toLowerCase().capsFirstLetterOfSentence,
                  textStyle: TextStyles.bold.copyWith(
                    fontSize: 26.sp,
                    color: AppColors.black,
                  ),
                ),
              ),
              const Expanded(flex: 1, child: SizedBox()),
              Expanded(
                flex: 13,
                child: GridView.builder(
                  itemCount: ref.watch(shopTypeProvider).industriesList!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return gridListWidget(index);
                  },
                  physics: const AlwaysScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4, mainAxisExtent: 190.h, mainAxisSpacing: 20.h, crossAxisSpacing: 20.w),
                ),
              ),
              const Expanded(flex: 1, child: SizedBox()),
            ],
          ),
        ),
        const Expanded(child: SizedBox()),
      ],
    );
  }

  ///Grid List Widget
  Widget gridListWidget(int index) {
    final shopTypeWatch = ref.watch(shopTypeProvider);
    //ShopTypeModel shopTypeModel = shopTypeWatch.shopList[index];
    Industry item = shopTypeWatch.industriesList![index];
    return GestureDetector(
      onTap: () {
        shopTypeWatch.updateSelectedIndex(index);
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: shopTypeWatch.selectedIndex != null
                    ? shopTypeWatch.selectedIndex == index
                        ? AppColors.green
                        : AppColors.clrB5B5B5
                    : AppColors.clrB5B5B5,
                width: shopTypeWatch.selectedIndex != null
                    ? shopTypeWatch.selectedIndex == index
                        ? 2.w
                        : 1.w
                    : 1.w,
              ),
            ),
            height: 190.h,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.network(
                    item.industryImage.toString(),
                    height: 80.h,
                    width: 80.w,
                    fit: BoxFit.cover,
                    errorBuilder: (context, url, error) => Container(
                      height: 80.h,
                      width: 80.w,
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.error,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  CommonText(
                    title: item.industryName.toString(),
                    textStyle: TextStyles.regular.copyWith(
                      fontSize: 24.sp,
                      color: AppColors.black,
                    ),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          ),
          shopTypeWatch.selectedIndex != null
              ? shopTypeWatch.selectedIndex == index
                  ? Positioned(
                      right: 20,
                      top: 10,
                      child: Container(
                        height: 20.w,
                        width: 20.h,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.green),
                          borderRadius: BorderRadius.circular(20.r),
                          color: AppColors.green,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.done,
                            color: AppColors.white,
                            size: 15.r,
                          ),
                        ),
                      ),
                    )
                  : Container()
              : Container()
        ],
      ),
    );
  }

  ///Widget Next Button Widget
  Widget nextButtonWidget() {
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
              fontSize: 24.sp,
              borderRadius: BorderRadius.circular(5.r),
              buttonText: LocalizationStrings.keyNext,
              backgroundColor: shopTypeWatch.isButtonEnabled ? AppColors.primary : AppColors.primary.withOpacity(0.2),
              onTap: () async {
                hideKeyboard(context);

                //print("....index at Next Button....${dashboardWatch.currentTabIndex}");

                if (shopTypeWatch.isButtonEnabled) {
                  await UserExperior.addEvent(KeyAnalytics.keyGetStartedTwo, "", KeyAnalytics.keyTypeEvent);
                  await shopTypeWatch.updateIndustryV2(ref, false);
                  if (shopTypeWatch.isError) {
                    // ignore: use_build_context_synchronously
                    showCustomSnackBar(shopTypeWatch.errorMsg, context);
                  } else {
                    navigateToNextPage(
                      ref,
                      const Offer(),
                    );
                  }
                } else {
                  showCustomSnackBar(LocalizationStrings.keyPleaseSelectShopType, context);
                }
              },
            ),
          ),
          const Expanded(
            flex: 2,
            child: SizedBox(),
          )
        ],
      ).paddingOnly(bottom: 40.h),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
