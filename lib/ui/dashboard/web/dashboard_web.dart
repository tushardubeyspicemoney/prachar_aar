import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_flutter_module/framework/controller/dashboard/dashboard_provider.dart';
import 'package:my_flutter_module/framework/controller/home/home_provider.dart';
import 'package:my_flutter_module/framework/utility/extension/extension.dart';
import 'package:my_flutter_module/ui/dashboard/web/helper/dashboard_sub_widget.dart';
import 'package:my_flutter_module/ui/utils/const/app_constants.dart';
import 'package:my_flutter_module/ui/utils/theme/app_strings.dart';
import 'package:my_flutter_module/ui/utils/theme/theme.dart';
import 'package:my_flutter_module/ui/utils/widgets/common_appbar.dart';
import 'package:my_flutter_module/ui/utils/widgets/common_device_configuration.dart';
import 'package:my_flutter_module/ui/utils/widgets/common_svg.dart';
import 'package:my_flutter_module/ui/utils/widgets/common_text.dart';

class DashboardWeb extends ConsumerStatefulWidget {
  const DashboardWeb({Key? key}) : super(key: key);

  @override
  ConsumerState<DashboardWeb> createState() => _DashboardWebState();
}

class _DashboardWebState extends ConsumerState<DashboardWeb> {
  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      final dashboardWatch = ref.watch(dashboardProvider);
      dashboardWatch.disposeController(isNotify: true);
      final homeProviderWatch = ref.watch(homeProvider);
      await homeProviderWatch.getFaq();
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
    webDeviceConfiguration(context);
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
          centerTitle: false,
          backgroundColor: AppColors.transparent,
          iconColor: AppColors.black,
          centerWidget: const CommonSVG(
            strIcon: AppAssets.svgPrachar,
          ).alignAtCenterLeft(),
        ),
        body: Row(
          children: [
            Expanded(
              flex: 2,
              child: _bodyWidget(),
            ),
            const Expanded(
              child: DashboardSubWidget(),
            ),
          ],
        ),
      ),
    );
  }

  ///Navigate to Next page
  _goForward() async {
    final dashboardWatch = ref.watch(dashboardProvider);
    if (dashboardWatch.currentTabIndex < 2 && dashboardWatch.tabBarList[dashboardWatch.currentTabIndex + 1].isEnabled) {
      switch (dashboardWatch.currentTabIndex) {
        case 0:
          ref.watch(offerProvider).updateCompanyName(ref.watch(brandingProvider).companyNameTextController.text);
          ref.watch(offerProvider).updateOfferList();
          break;
        case 1:
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
        case 1:
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
    final screenHeight = MediaQuery.of(context).size.height;
    final dashboardWatch = ref.watch(dashboardProvider);
    return SizedBox(
      height: screenHeight * 0.060,
      child: Row(
        children: [
          const Expanded(
            child: SizedBox(),
          ),
          Expanded(
            flex: 24,
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
                          dashboardWatch
                                  .tabBarList[dashboardWatch.currentTabIndex].globalKey.currentContext?.size!.width ??
                              5,
                        );
                        dashboardWatch.animateToPage();
                      } else {
                        switch (dashboardWatch.currentTabIndex) {
                          case 0:
                            showCustomSnackBar(LocalizationStrings.keyPleaseEnterShopName, context);
                            break;
                          case 1:
                            showCustomSnackBar(LocalizationStrings.keyPleaseEnterOfferText, context);
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
                                fontSize: 24.sp,
                                color: dashboardWatch.tabBarList[index].isEnabled
                                    ? dashboardWatch.currentTabIndex == index
                                        ? AppColors.clrF84E3D
                                        : AppColors.grey
                                    : AppColors.black,
                              ),
                            ),
                            SizedBox(width: 15.w),
                            index != 3
                                ? CommonSVG(
                                    strIcon: AppAssets.svgNext,
                                    height: 25.h,
                                    width: 25.h,
                                  )
                                : Container(),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Container(
                          color: (dashboardWatch.currentTabIndex == index) ? AppColors.red : AppColors.transparent,
                          height: 2.h,
                          width: dashboardWatch.indicatorWidth != null
                              ? (dashboardWatch.indicatorWidth!.w < 0 ? 50.w : dashboardWatch.indicatorWidth?.w)
                              : 0,
                        ).alignAtBottomCenter(),
                      ],
                    ).paddingOnly(top: 15.h),
                  );
                },
              ),
            ),
          ),
          const Expanded(flex: 20, child: SizedBox()),
        ],
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
}
