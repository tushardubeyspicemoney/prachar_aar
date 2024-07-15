import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:my_flutter_module/framework/provider/local_storage/hive/hive_provider.dart';
import 'package:my_flutter_module/framework/provider/local_storage/local_const.dart';

@injectable
class BrandingController extends ChangeNotifier {
  ///Dispose Controller
  void disposeController({bool isNotify = false}) {
    isLoading = false;
    isButtonEnabled = false;
    companyNameTextController.text = '';
    if (isNotify) {
      notifyListeners();
    }
  }

  ///Text Editing Controller
  TextEditingController companyNameTextController = TextEditingController();

  ///Focus Node
  FocusNode companyNameFocus = FocusNode();

  bool isButtonEnabled = false;

  ///Update Is Button Enabled
  updateIsButtonEnabled(bool val) {
    isButtonEnabled = val;
    notifyListeners();
  }

  Future<void> updateShopName() async {
    String userShop = await HiveProvider.get(LocalConst.userShopName) ?? "Demo Shope";
    companyNameTextController.text = userShop;
    notifyListeners();
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
