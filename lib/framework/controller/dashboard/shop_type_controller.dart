import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:my_flutter_module/framework/controller/dashboard/dashboard_provider.dart';
import 'package:my_flutter_module/framework/provider/local_storage/hive/hive_provider.dart';
import 'package:my_flutter_module/framework/provider/local_storage/local_const.dart';
import 'package:my_flutter_module/framework/provider/network/api_result.dart';
import 'package:my_flutter_module/framework/provider/network/dio/error_response.dart';
import 'package:my_flutter_module/framework/provider/network/network_exceptions.dart';
import 'package:my_flutter_module/framework/repository/introduction/contract/introduction_repository.dart';
import 'package:my_flutter_module/framework/repository/introduction/model/request_update_industry.dart';
import 'package:my_flutter_module/framework/repository/introduction/model/response_industry_list.dart';
import 'package:my_flutter_module/framework/repository/introduction/model/response_update_industry.dart';
import 'package:my_flutter_module/ui/routing/stack.dart';
import 'package:my_flutter_module/ui/utils/theme/app_assets.dart';

@injectable
class ShopTypeController extends ChangeNotifier {
  final IntroductionRepository introductionRepository;

  ShopTypeController(this.introductionRepository);

  ///Dispose Controller
  void disposeController({bool isNotify = false}) {
    isLoading = false;
    isButtonEnabled = false;
    selectedIndex = null;
    shopList = [
      ShopTypeModel(image: AppAssets.svgBanking, title: 'ATM / Banking Point'),
      ShopTypeModel(image: AppAssets.svgCyber, title: 'Cyber Cafe'),
      ShopTypeModel(image: AppAssets.svgMobile, title: 'ATM / Banking Point'),
      ShopTypeModel(image: AppAssets.svgPrinting, title: 'Cyber Cafe'),
      ShopTypeModel(image: AppAssets.svgGrocery, title: 'ATM / Banking Point'),
      ShopTypeModel(image: AppAssets.svgMedical, title: 'Cyber Cafe'),
      ShopTypeModel(image: AppAssets.svgStationary, title: 'ATM / Banking Point'),
      ShopTypeModel(image: AppAssets.svgRestaurant, title: 'Cyber Cafe'),
      ShopTypeModel(image: AppAssets.svgHardware, title: 'ATM / Banking Point'),
      ShopTypeModel(image: AppAssets.svgTravel, title: 'Cyber Cafe'),
      ShopTypeModel(image: AppAssets.svgAgriculture, title: 'ATM / Banking Point'),
      ShopTypeModel(image: AppAssets.svgOther, title: 'Cyber Cafe'),
    ];

    if (isNotify) {
      notifyListeners();
    }
  }

  int? selectedIndex = 0;

  ///Update Selected Index
  updateSelectedIndex(int index) {
    selectedIndex = index;
    updateIsButtonEnabled(true);
    notifyListeners();
  }

  bool isButtonEnabled = false;

  ///Update Is Button Enabled
  updateIsButtonEnabled(bool val) {
    isButtonEnabled = val;
    notifyListeners();
  }

  void updateLoadingStatus(bool value) {
    isLoading = value;
    notifyListeners();
  }

  List<ShopTypeModel> shopList = [];

  /*
  /// ---------------------------- Api Integration ---------------------------------///
   */

  ///Progress Indicator
  bool isLoading = false;
  bool isError = false;
  String errorMsg = "";

  ResponseIndustryList? responseIndustryList;
  List<Industry>? industriesList = [];

  Future<void> getIndustryList(bool update) async {
    isLoading = true;
    notifyListeners();

    ApiResult apiResult = await introductionRepository.getIndustryList();
    apiResult.when(success: (data) async {
      ResponseIndustryList item = data as ResponseIndustryList;
      responseIndustryList = item;
      if (responseIndustryList!.respCode == "200") {
        //  context.setLocale(const Locale('hi'));
        isLoading = false;
        isError = false;
        industriesList = responseIndustryList!.data!.industries;

        if (update) {
          String currentIndId = await HiveProvider.get(LocalConst.userIndustryId) ?? "2";
          int selIndex = 0;

          for (int i = 0; i < industriesList!.length; i++) {
            Industry item = industriesList![i];
            if (item.industryId == int.parse(currentIndId)) {
              selIndex = i;
            }
          }
          updateSelectedIndex(selIndex);
        }
      } else {
        isError = true;
        errorMsg = responseIndustryList!.respDesc!;
      }
    }, failure: (NetworkExceptions error) {
      isLoading = false;
      isError = true;
      errorMsg = "Something Went Wrong";
      error.whenOrNull(notFound: (String reason, Response? response) {
        ErrorResponse errorResponse = errorResponseFromJson(response.toString());
        errorMsg = errorResponse.respDesc!;
      });
    });
    notifyListeners();
  }

  ResponseUpdateIndustry? responseUpdateIndustry;

  Future<void> updateIndustryV2(WidgetRef ref, bool isFromUpdate) async {
    int? industryId = industriesList![selectedIndex ?? 10].industryId;
    String shopName = ref.watch(brandingProvider).companyNameTextController.text;

    RequestUpdateIndustry requestUpdateIndustry = RequestUpdateIndustry(industryId: industryId, shopName: shopName);

    ApiResult apiResult = await introductionRepository.getUpdateIndustry(requestUpdateIndustry);
    apiResult.when(success: (data) async {
      ResponseUpdateIndustry item = data as ResponseUpdateIndustry;
      responseUpdateIndustry = item;
      if (responseUpdateIndustry!.respCode == "200") {
        isLoading = false;
        isError = false;

        String currentIndustryId = "";
        String currentShopName = "";
        String userId = "";
        String userAddress = "";
        String userPhone = "";
        currentIndustryId = responseUpdateIndustry!.data!.user!.industryId.toString();
        currentShopName = responseUpdateIndustry!.data!.user!.shopName.toString();
        userId = responseUpdateIndustry!.data!.user!.clientId.toString();
        userAddress = responseUpdateIndustry!.data!.user!.contactInfo.toString();
        //userPhone=responseUpdateIndustry!.data!.user!.phoneno.toString();

        //await HiveProvider.add(LocalConst.userAddress, strAddressLine);

        await HiveProvider.add(LocalConst.userId, userId);
        await HiveProvider.add(LocalConst.userIndustryId, currentIndustryId);
        await HiveProvider.add(LocalConst.userShopName, currentShopName);

        /// Need To Address From Api
        await HiveProvider.add(LocalConst.userAddress, userAddress);
        await HiveProvider.add(LocalConst.userPhone, userPhone);

        if (isFromUpdate) {
          ref.read(navigationStackProvider).pop();
          ;
        }
      } else {
        isError = true;
        isLoading = false;
        errorMsg = responseUpdateIndustry!.respDesc!;
      }
    }, failure: (NetworkExceptions error) {
      isLoading = false;
      isError = true;
      errorMsg = "Something Went Wrong";
      error.whenOrNull(notFound: (String reason, Response? response) {
        ErrorResponse errorResponse = errorResponseFromJson(response.toString());
        errorMsg = errorResponse.respDesc!;
      });
    });
    notifyListeners();
  }
}

class ShopTypeModel {
  String image;
  String title;

  ShopTypeModel({
    required this.image,
    required this.title,
  });
}
