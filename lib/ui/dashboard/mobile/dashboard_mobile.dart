import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_flutter_module/framework/controller/dashboard/dashboard_provider.dart';
import 'package:my_flutter_module/framework/utility/app_google_analytics/key_analytics.dart';
import 'package:my_flutter_module/framework/utility/app_google_analytics/user_experior.dart';
import 'package:my_flutter_module/framework/utility/extension/extension.dart';
import 'package:my_flutter_module/ui/dashboard/design.dart';
import 'package:my_flutter_module/ui/dashboard/offer.dart';
import 'package:my_flutter_module/ui/dashboard/shop_type.dart';
import 'package:my_flutter_module/ui/utils/const/app_constants.dart';
import 'package:my_flutter_module/ui/utils/theme/app_strings.dart';
import 'package:my_flutter_module/ui/utils/theme/theme.dart';
import 'package:my_flutter_module/ui/utils/widgets/common_appbar.dart';
import 'package:my_flutter_module/ui/utils/widgets/common_button.dart';
import 'package:my_flutter_module/ui/utils/widgets/common_device_configuration.dart';
import 'package:my_flutter_module/ui/utils/widgets/common_svg.dart';
import 'package:my_flutter_module/ui/utils/widgets/common_text.dart';

class DashboardMobile extends ConsumerStatefulWidget {
  const DashboardMobile({Key? key}) : super(key: key);

  @override
  ConsumerState<DashboardMobile> createState() => _DashboardMobileState();
}

class _DashboardMobileState extends ConsumerState<DashboardMobile> {
  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      final dashboardWatch = ref.watch(dashboardProvider);
      dashboardWatch.disposeController(isNotify: true);
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        final dashboardWatch = ref.watch(dashboardProvider);
        double? indicatorSize =
            dashboardWatch.tabBarList[dashboardWatch.currentTabIndex].globalKey.currentContext?.size!.width;
        dashboardWatch.updateIndicatorSize(indicatorSize!);
      });
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
    mobileDeviceConfiguration(context);
    return GestureDetector(
      onTap: () {
        hideKeyboard(context);
      },
      // Using the DragEndDetails allows us to only fire once per swipe.
      onHorizontalDragEnd: (dragEndDetails) {
        if (dragEndDetails.primaryVelocity! < 0) {
          // Page forwards
          _goForward();
        } else if (dragEndDetails.primaryVelocity! > 0) {
          // Page backwards
          _goBack();
        }
      },

      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: CommonAppBar(
          isLeadingEnable: true,
          title: LocalizationStrings.keyCreateAnOffer,
        ),
        body: _bodyWidget(),
        bottomNavigationBar: _bottomNavigationWidget(),
      ),
    );
  }

  ///Navigate to Next page
  _goForward() async {
    final dashboardWatch = ref.watch(dashboardProvider);
    if (dashboardWatch.currentTabIndex < 3 && dashboardWatch.tabBarList[dashboardWatch.currentTabIndex + 1].isEnabled) {
      switch (dashboardWatch.currentTabIndex) {
        case 0:
          ref.watch(offerProvider).updateCompanyName(ref.watch(brandingProvider).companyNameTextController.text);
          ref.watch(offerProvider).updateOfferList();
          break;
        case 2:
          ref.watch(designProvider).updateTitleAndSubTitle(
                ref.watch(offerProvider).offerTextController.text,
                ref.watch(offerProvider).contactDetailsTextController.text,
              );
          break;
      }
      await dashboardWatch.updateCurrentTabIndex(dashboardWatch.currentTabIndex + 1);
      dashboardWatch.updateIndicatorSize(
        dashboardWatch.tabBarList[dashboardWatch.currentTabIndex].globalKey.currentContext?.size!.width ?? 0,
      );
      await dashboardWatch.animateToPage();
    }
  }

  ///Navigate to Previous page
  _goBack() async {
    final dashboardWatch = ref.watch(dashboardProvider);
    if (dashboardWatch.currentTabIndex > 0) {
      switch (dashboardWatch.currentTabIndex) {
        case 0:
          ref.watch(offerProvider).updateCompanyName(ref.watch(brandingProvider).companyNameTextController.text);
          ref.watch(offerProvider).updateOfferList();
          break;
        case 2:
          ref.watch(designProvider).updateTitleAndSubTitle(
                ref.watch(offerProvider).offerTextController.text,
                ref.watch(offerProvider).contactDetailsTextController.text,
              );
          break;
      }
      await dashboardWatch.updateCurrentTabIndex(dashboardWatch.currentTabIndex - 1);
      dashboardWatch.updateIndicatorSize(
        dashboardWatch.tabBarList[dashboardWatch.currentTabIndex].globalKey.currentContext?.size!.width ?? 0,
      );
      await dashboardWatch.animateToPage();
    }
  }

  ///Body Widget
  Widget _bodyWidget() {
    return Column(
      children: [
        _tabListWidget(),
        Divider(
          height: 1.w,
          color: AppColors.clrB5B5B5,
        ),
        Expanded(
          child: tabBodyWidget(),
        ),
      ],
    );
  }

  ///Tab list Widget
  Widget _tabListWidget() {
    final dashboardWatch = ref.watch(dashboardProvider);
    return SizedBox(
      height: 46.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          dashboardWatch.tabBarList.length,
          (index) {
            //print("......dashboardWatch.currentTabIndex...${dashboardWatch.currentTabIndex}..index...$index..${dashboardWatch.currentTabIndex == index}");
            return GestureDetector(
              onTap: () async {
                if (dashboardWatch.tabBarList[index].isEnabled) {
                  await dashboardWatch.updateCurrentTabIndex(index);
                  dashboardWatch.updateIndicatorSize(
                    dashboardWatch.tabBarList[dashboardWatch.currentTabIndex].globalKey.currentContext?.size!.width ??
                        0,
                  );
                  dashboardWatch.animateToPage();
                } else {
                  switch (dashboardWatch.currentTabIndex) {
                    case 0:
                      showCustomSnackBar(LocalizationStrings.keyPleaseEnterShopName);
                      break;
                    case 1:
                      showCustomSnackBar(LocalizationStrings.keyPleaseSelectShopType);
                      break;
                    case 2:
                      showCustomSnackBar(LocalizationStrings.keyPleaseEnterOfferText);
                      break;
                  }
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    children: [
                      CommonText(
                        key: dashboardWatch.tabBarList[index].globalKey,
                        title: dashboardWatch.tabBarList[index].title,
                        textStyle: TextStyles.medium.copyWith(
                          color: dashboardWatch.tabBarList[index].isEnabled
                              ? dashboardWatch.currentTabIndex == index
                                  ? AppColors.primary
                                  : AppColors.grey
                              : AppColors.black,
                        ),
                      ),
                      SizedBox(width: 15.w),
                      index != 3
                          ? CommonSVG(
                              strIcon: AppAssets.svgNext,
                              height: 15.h,
                              width: 15.h,
                            )
                          : Container(),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Container(
                    color: (dashboardWatch.currentTabIndex == index) ? AppColors.red : AppColors.transparent,
                    height: 2.h,
                    width: dashboardWatch.indicatorWidth?.w ?? 0,
                  ).alignAtBottomCenter(),
                ],
              ).paddingOnly(top: 15.h),
            );
          },
        ),
      ),
    );
  }

  ///Tab Body Widget
  Widget tabBodyWidget() {
    final dashboardWatch = ref.watch(dashboardProvider);
    return PageView(
      controller: dashboardWatch.pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: dashboardWatch.pageViewList,
    );
  }

  ///bottom navigation widget
  _bottomNavigationWidget() {
    final dashboardWatch = ref.watch(dashboardProvider);
    final brandingWatch = ref.watch(brandingProvider);
    final shopTypeWatch = ref.watch(shopTypeProvider);
    final offerWatch = ref.watch(offerProvider);
    final designWatch = ref.watch(designProvider);
    return Padding(
      padding: EdgeInsets.only(bottom: (MediaQuery.of(context).viewInsets.bottom + 8.h)),
      child: CommonButton(
        buttonText: dashboardWatch.currentTabIndex != 3 ? LocalizationStrings.keyNext : LocalizationStrings.KeyPublish,
        backgroundColor: dashboardWatch.currentTabIndex == 0
            ? brandingWatch.isButtonEnabled
                ? AppColors.primary
                : AppColors.primary.withOpacity(0.2)
            : dashboardWatch.currentTabIndex == 1
                ? shopTypeWatch.isButtonEnabled
                    ? AppColors.primary
                    : AppColors.primary.withOpacity(0.2)
                : dashboardWatch.currentTabIndex == 2
                    ? offerWatch.isButtonEnabled
                        ? AppColors.primary
                        : AppColors.primary.withOpacity(0.2)
                    : AppColors.primary,
        onTap: () async {
          hideKeyboard(context);

          //print("....index at Next Button....${dashboardWatch.currentTabIndex}");

          switch (dashboardWatch.currentTabIndex) {
            case 0:
              if (brandingWatch.isButtonEnabled) {
                //print(".....ShopType Called.......");
                navigateToNextPage(
                  const ShopType(),
                );
              } else {
                showCustomSnackBar(LocalizationStrings.keyPleaseEnterShopName);
              }
              break;
            case 1:
              if (shopTypeWatch.isButtonEnabled) {
                await UserExperior.addEvent(KeyAnalytics.keyGetStartedTwo, "", KeyAnalytics.keyTypeEvent);
                await shopTypeWatch.updateIndustryV2(ref, false);
                if (shopTypeWatch.isError) {
                  showCustomSnackBar(shopTypeWatch.errorMsg);
                } else {
                  navigateToNextPage(
                    const Offer(),
                  );
                }
              } else {
                showCustomSnackBar(LocalizationStrings.keyPleaseSelectShopType);
              }
              break;
            case 2:
              if (offerWatch.isButtonEnabled) {
                //print(".....Design Called.......");
                navigateToNextPage(
                  const Design(),
                );
              } else {
                showCustomSnackBar(LocalizationStrings.keyPleaseEnterOfferText);
              }
              break;
            case 3:
              /*if(designWatch.id==0)
              {
                AppToast.showSnackBar("Yeh offer aap kiske liye bana rahe hei?", ScaffoldMessenger.of(context));
              }
              else
              {
                await designWatch.saveAndShare(ref,ScaffoldMessenger.of(context),false);
              }*/
              await designWatch.saveAndShare(ref, ScaffoldMessenger.of(context), false);

              break;
          }
        },
      ).paddingSymmetric(horizontal: globalPadding, vertical: 10.h),
    );
  }

  ///Show SnackBar
  showCustomSnackBar(String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.primary,
        content: CommonText(
          title: title,
          textStyle: TextStyles.semiBold.copyWith(
            fontSize: 16.sp,
            color: AppColors.white,
          ),
        ),
        showCloseIcon: true,
        closeIconColor: AppColors.white,
      ),
    );
  }

  ///Navigate to Next Page
  navigateToNextPage(Widget screen) async {
    final dashboardWatch = ref.watch(dashboardProvider);
    //print("....navigateToNextPage.....currentTabIndex....${dashboardWatch.currentTabIndex}");

    switch (dashboardWatch.currentTabIndex) {
      case 0:
        ref.watch(offerProvider).updateCompanyName(ref.watch(brandingProvider).companyNameTextController.text);
        ref.watch(offerProvider).updateOfferList();
        break;
      case 2:
        ref.watch(designProvider).updateTitleAndSubTitle(
              ref.watch(offerProvider).offerTextController.text,
              ref.watch(offerProvider).contactDetailsTextController.text,
            );
        break;
    }
    if (!dashboardWatch.tabBarList[dashboardWatch.currentTabIndex + 1].isEnabled) {
      dashboardWatch.addPagesToList(screen);
    }
    await dashboardWatch.updateIsEnabled(dashboardWatch.currentTabIndex + 1);
    await dashboardWatch.updateCurrentTabIndex(dashboardWatch.currentTabIndex + 1);
    await dashboardWatch.updateIndicatorSize(
      dashboardWatch.tabBarList[dashboardWatch.currentTabIndex].globalKey.currentContext?.size!.width ?? 0,
    );
    dashboardWatch.updateCurrentPage();
  }
}
