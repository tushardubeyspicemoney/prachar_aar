import 'package:injectable/injectable.dart';
import 'package:my_flutter_module/framework/repository/dashboard/model/dashboard_model.dart';
import 'package:my_flutter_module/ui/dashboard/branding.dart';
import 'package:my_flutter_module/ui/utils/theme/app_strings.dart';
import 'package:my_flutter_module/ui/utils/theme/theme.dart';

@injectable
class DashboardController extends ChangeNotifier {
  ///Dispose Controller
  void disposeController({bool isNotify = false}) {
    isLoading = false;
    currentTabIndex = 0;
    pageController = PageController(initialPage: 0);
    pageViewList = [
      const Branding(),
    ];
    if (isNotify) {
      notifyListeners();
    }
  }

  PageController pageController = PageController(initialPage: 0);

  int currentTabIndex = 0;
  double? indicatorWidth;

  List<DashboardModel> tabBarList = [
    DashboardModel(
      title: LocalizationStrings.keyBranding,
      isEnabled: true,
      globalKey: GlobalKey(),
    ),
    DashboardModel(
      title: LocalizationStrings.keyShopType,
      isEnabled: false,
      globalKey: GlobalKey(),
    ),
    DashboardModel(
      title: LocalizationStrings.keyOffer,
      isEnabled: false,
      globalKey: GlobalKey(),
    ),
    DashboardModel(
      title: LocalizationStrings.keyDesign,
      isEnabled: false,
      globalKey: GlobalKey(),
    ),
  ];

  ///update current tab index
  updateCurrentTabIndex(int index) {
    currentTabIndex = index;
    print("......currentTabIndex.....in...provider...$currentTabIndex");

    print("...xxxx.....eeeeee.....${pageController.page!.toInt()}");

    notifyListeners();
  }

  ///update current page
  updateCurrentPage() {
    pageController.jumpToPage(currentTabIndex);
    notifyListeners();
  }

  ///update isEnabled
  updateIsEnabled(int index) {
    tabBarList[index].isEnabled = true;
    notifyListeners();
  }

  ///update indicator size
  updateIndicatorSize(double width) {
    indicatorWidth = width - 4.w;
    print('indicatorWidth: $indicatorWidth');
    notifyListeners();
  }

  ///PageView List Widget
  List<Widget> pageViewList = [
    const Branding(),
  ];

  ///Add Pages to List
  addPagesToList(Widget screen) {
    pageViewList.add(screen);
    notifyListeners();
  }

  ///animate to  page
  animateToPage() {
    pageController.animateToPage(
      currentTabIndex,
      duration: const Duration(milliseconds: 200),
      curve: Curves.bounceIn,
    );
  }

  /*
  /// ---------------------------- Api Integration ---------------------------------///
   */

  ///Progress Indicator
  bool isLoading = false;

  void updateLoadingStatus(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
