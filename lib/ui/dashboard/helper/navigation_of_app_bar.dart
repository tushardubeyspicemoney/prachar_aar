import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_flutter_module/framework/controller/dashboard/dashboard_provider.dart';
import 'package:my_flutter_module/ui/utils/theme/theme.dart';

///Navigate to Next Page
navigateToNextPage(WidgetRef ref, Widget screen) async {
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

navigateToNextPageWeb(WidgetRef ref, Widget screen) async {
  final dashboardWatch = ref.watch(dashboardProvider);
  //print("....navigateToNextPage.....currentTabIndex....${dashboardWatch.currentTabIndex}");

  switch (dashboardWatch.currentTabIndex) {
    case 0:
      ref.watch(offerProvider).updateCompanyName(ref.watch(brandingProvider).companyNameTextController.text);
      break;
    case 1:
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
