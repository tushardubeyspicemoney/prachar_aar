import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:my_flutter_module/framework/provider/local_storage/hive/hive_provider.dart';
import 'package:my_flutter_module/framework/provider/local_storage/local_const.dart';
import 'package:my_flutter_module/framework/provider/network/api_result.dart';
import 'package:my_flutter_module/framework/provider/network/dio/error_response.dart';
import 'package:my_flutter_module/framework/provider/network/network_exceptions.dart';
import 'package:my_flutter_module/framework/repository/banner/contract/banner_repository.dart';
import 'package:my_flutter_module/framework/repository/banner/model/request_edit_address.dart';
import 'package:my_flutter_module/framework/repository/banner/model/request_offer_text.dart';
import 'package:my_flutter_module/framework/repository/banner/model/response_edit_address.dart';
import 'package:my_flutter_module/framework/repository/banner/model/response_offer_text.dart';
import 'package:my_flutter_module/framework/repository/banner/model/response_user_industry.dart';
import 'package:my_flutter_module/ui/widgets/app_toast.dart';

@injectable
class OfferController extends ChangeNotifier {
  final BannerRepository bannerRepository;

  OfferController(this.bannerRepository);

  ///Dispose Controller
  void disposeController({bool isNotify = false}) {
    isLoading = false;
    currentRadioIndex = null;
    isButtonEnabled = false;
    isContactUsFieldEditable = false;
    offerTextController.text = '';
    //updateOfferList();
    /*contactDetailsTextController.text =
        'Call 9876543210 | Shop No. 17D, Prem Colony, Near Gayatri Mandir, Ambala Cantt';*/
    if (isNotify) {
      notifyListeners();
    }
  }

  ///Text Editing Controller
  TextEditingController offerTextController = TextEditingController();
  TextEditingController contactDetailsTextController = TextEditingController();

  ///Focus Node
  FocusNode offerFocusNode = FocusNode();
  FocusNode contactDetailsFocusNode = FocusNode();

  ///Offer Text String List
  List<String> offerTextList = [
    'companyName ki taraf se sabko Holi ki hardik shubhkamnayei',
    'companyName par ab Axis Bank Acocunt kholne ki suvidha uplabdh hai',
    'companyName par sabhi banking sevao ka labh uhtayei behad kam shulko mei',
  ];

  String? companyName;
  int? currentRadioIndex;

  bool isButtonEnabled = false;

  bool isContactUsFieldEditable = false;

  ///Update Radio Value
  updateRadioValue(int index) {
    currentRadioIndex = index;
    // offerTextController.text = "$shopName ${offers![currentRadioIndex!]!.offerDesc!}";
    offerTextController.text = offers![currentRadioIndex!]!.offerDesc!.trim();
    updateIsButtonEnabled(true);
    //offerFocusNode.requestFocus();
    notifyListeners();
  }

  ///update offer list
  updateOfferList() {
    offerTextList = [
      '$companyName ki taraf se sabko Holi ki hardik shubhkamnayei',
      '$companyName par ab Axis Bank Acocunt kholne ki suvidha uplabdh hai',
      '$companyName par sabhi banking sevao ka labh uhtayei behad kam shulko mei',
    ];
    if (currentRadioIndex != null) {
      offerTextController.text = offerTextList[currentRadioIndex!];
    }
    notifyListeners();
  }

  ///Update Company Name
  updateCompanyName(String name) {
    companyName = name;
    notifyListeners();
  }

  ///Update Is Button Enabled
  updateIsButtonEnabled(bool val) {
    isButtonEnabled = val;
    notifyListeners();
  }

  ///Update Is Contact Us Field Editable
  updateIsContactUsFieldEditable(bool val) {
    isContactUsFieldEditable = val;
    notifyListeners();
  }

  /*
  /// ---------------------------- Api Integration ---------------------------------///
   */

  ///Progress Indicator
  bool isLoading = false;
  bool isError = false;
  String errorMsg = "";

  void updateLoadingStatus(bool value) {
    isLoading = value;
    notifyListeners();
  }

  ///getOfferTexts

  ResponseOfferText? responseOfferText;
  List<OfferText?>? offers = [];

  String shopName = "";
  String address = "";
  String phone = "";
  String strAddressLine = "";

  Future<void> getOfferTexts(ScaffoldMessengerState state) async {
    isLoading = true;
    notifyListeners();

    String currentIndId = await HiveProvider.get(LocalConst.userIndustryId) ?? "1";

    RequestOfferText requestOfferText = RequestOfferText();
    requestOfferText.industryId = int.parse(currentIndId);

    ApiResult apiResult = await bannerRepository.getOfferText(requestOfferText);
    apiResult.when(success: (data) async {
      ResponseOfferText item = data as ResponseOfferText;
      responseOfferText = item;
      if (responseOfferText!.respCode == "200") {
        isLoading = false;
        isError = false;
        offers = responseOfferText!.data!.offers;
        String userShop = await HiveProvider.get(LocalConst.userShopName) ?? "Demo Shope";
        String userAddress = await HiveProvider.get(LocalConst.userAddress) ?? "-";
        shopName = userShop;
        address = userAddress;
        contactDetailsTextController.text = address;
        if (offers!.isNotEmpty) {
          updateRadioValue(0);
        }
      } else {
        isLoading = false;
        isError = true;
        errorMsg = responseOfferText!.respDesc!;
        //AppToast.showSnackBar(errorMsg,state);
      }
    }, failure: (NetworkExceptions error) {
      isLoading = false;
      isError = true;
      errorMsg = "Something Went Wrong";
      error.whenOrNull(notFound: (String reason, Response? response) {
        ErrorResponse errorResponse = errorResponseFromJson(response.toString());
        errorMsg = errorResponse.respDesc!;
      });
      //AppToast.showSnackBar(errorMsg,state);
    });
    notifyListeners();
  }

  ///Edit

  Poster? editPosterItem;

  Future<void> updateTextEdit(Poster item) async {
    editPosterItem = item;
    offerTextController.text = item.offerName!;
    contactDetailsTextController.text = item.offerDesc!;
    notifyListeners();
  }

  ///Edit Address

  ResponseEditAddress? responseEditAddress;

  Future<void> editAddress(ScaffoldMessengerState state) async {
    isLoading = true;
    notifyListeners();

    RequestEditAddress requestEditAddress =
        RequestEditAddress(contactInfo: contactDetailsTextController.text.toString());

    ApiResult apiResult = await bannerRepository.editAddress(requestEditAddress);
    apiResult.when(success: (data) async {
      ResponseEditAddress item = data as ResponseEditAddress;
      responseEditAddress = item;
      if (responseEditAddress!.respCode == "200") {
        isLoading = false;
        isError = false;
      } else {
        isLoading = false;
        //isError=true;
        errorMsg = responseEditAddress!.respDesc!;
        //AppToast.showSnackBar(errorMsg,state);
      }
    }, failure: (NetworkExceptions error) {
      isLoading = false;
      //isError = true;
      errorMsg = "Something Went Wrong";
      error.whenOrNull(notFound: (String reason, Response? response) {
        ErrorResponse errorResponse = errorResponseFromJson(response.toString());
        errorMsg = errorResponse.respDesc!;
      });
      AppToast.showSnackBar(errorMsg, state);
    });
    notifyListeners();
  }
}
