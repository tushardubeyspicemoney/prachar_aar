import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:my_flutter_module/framework/controller/marketing_banner/banner_provider.dart';
import 'package:my_flutter_module/framework/provider/local_storage/hive/hive_provider.dart';
import 'package:my_flutter_module/framework/provider/local_storage/local_const.dart';
import 'package:my_flutter_module/framework/provider/network/api_result.dart';
import 'package:my_flutter_module/framework/provider/network/dio/error_response.dart';
import 'package:my_flutter_module/framework/provider/network/network_exceptions.dart';
import 'package:my_flutter_module/framework/repository/introduction/contract/introduction_repository.dart';
import 'package:my_flutter_module/framework/repository/introduction/model/request_update_industry.dart';
import 'package:my_flutter_module/framework/repository/introduction/model/response_get_campaign.dart';
import 'package:my_flutter_module/framework/repository/introduction/model/response_industry_list.dart';
import 'package:my_flutter_module/framework/repository/introduction/model/response_update_industry.dart' as res;
import 'package:my_flutter_module/framework/utility/app_google_analytics/key_analytics.dart';
import 'package:my_flutter_module/framework/utility/app_google_analytics/user_experior.dart';
import 'package:my_flutter_module/ui/routing/navigation_stack_item.dart';
import 'package:my_flutter_module/ui/theme/theme_const.dart';

import '../../../ui/routing/stack.dart';

@injectable
class IntroductionController extends ChangeNotifier {
  final IntroductionRepository introductionRepository;

  IntroductionController(this.introductionRepository);

  List<BannerModel> bannerList = [];

  TextEditingController shopNameController = TextEditingController();

  bool isLoading = true;
  bool isError = false;
  String errorMsg = "";
  ResponseGetCampaign? responseGetCampaign;
  ResponseIndustryList? responseIndustryList;
  res.ResponseUpdateIndustry? responseUpdateIndustry;

  //List<CampgainsArr> introList =[];
  List<Campgain>? introList;

  //List<IndustriesArr> industriesList=[];
  List<Industry>? industriesList = [];
  String campaignId = "";
  String userId = "";

  //UserIndustryData? userData;
  User? userData;
  List<Video>? videos = [];

  String faqURL = "https://static.spicemoney.com/sm/Banner/faq.html";

/*  List<String>  playList = [
    'tjuTThqPbKk',
    '5DADCSRiE3A'
  ];*/

  List<String> playList = [];

/*  List<String> videoTitle = [
    'What is "Advance balance" facility?',
    'How to take "Advance balance" ?'
  ];*/
  List<String> videoTitle = [];

  ///getindustrylist
  int selectedIndex = 1000;
  String shopName = "";
  bool isValidated = false;

  void setSelectedIndex(int index) {
    selectedIndex = index;
    checkValidation();
    notifyListeners();
  }

  void changeShopName(String value) {
    shopName = value;
    checkValidation();
    notifyListeners();
  }

  void checkValidation() {
    isValidated = (selectedIndex != 1000) && (shopName.isNotEmpty);
  }

  void updateCampaignId(int id) {
    campaignId = id.toString();
  }

  Future<void> learnMoreVideo(String title, String url) async {
    playList.clear();
    videoTitle.clear();
    playList.add(url);
    videoTitle.add(title);
    notifyListeners();
  }

  Future<void> helpVideos() async {
    playList.clear();
    videoTitle.clear();
    for (Video item in videos!) {
      String url = item.url!.split("=").last;
      playList.add(url);
      videoTitle.add(item.title.toString());
    }
    notifyListeners();
  }

  /// Add Banners List
  Future<void> addBannerList(List<Campgain> introList) async {
    bannerList.addAll([
      BannerModel(
          title: introList[0].contentTitle,
          subtitle: introList[0].contentDesc,
          campaignId: introList[0].campaignId,
          image: Constant.instance.icBanner1,
          videoUrl: introList[0].videoLink ?? ""),
      BannerModel(
          title: introList[1].contentTitle,
          subtitle: introList[1].contentDesc,
          campaignId: introList[1].campaignId,
          image: Constant.instance.icBanner2,
          videoUrl: introList[1].videoLink ?? ""),
    ]);
    notifyListeners();
  }

  Future<void> getCampaign() async {
    isLoading = true;
    notifyListeners();

    ApiResult apiResult = await introductionRepository.getCampaign();
    apiResult.when(success: (data) async {
      ResponseGetCampaign item = data as ResponseGetCampaign;
      responseGetCampaign = item;
      if (responseGetCampaign!.respCode == "200") {
        isLoading = false;
        isError = false;
        introList = responseGetCampaign!.data!.campgains;
        userData = responseGetCampaign!.data!.user;
        userId = userData!.clientId!;
        videos = responseGetCampaign!.data!.videos;

        /// HID this when work done
        // userId="0";
        if (userId != "0") {
          String currentIndustryId = "";
          String currentIndustryName = "";
          String currentShopName = "";
          currentIndustryId = userData!.industryDetails!.industryId.toString();
          currentIndustryName = userData!.industryDetails!.industryName.toString();
          currentShopName = userData!.shopName!;

          dynamic appLanguage = await HiveProvider.get(LocalConst.language);
          if (appLanguage == null) {
            await HiveProvider.add(LocalConst.language, "en");
          } else {
            await HiveProvider.add(LocalConst.language, appLanguage);
          }

          await HiveProvider.add(LocalConst.userId, userId);
          await HiveProvider.add(LocalConst.userIndustryId, currentIndustryId);
          await HiveProvider.add(LocalConst.userIndustryName, currentIndustryName);
          await HiveProvider.add(LocalConst.userShopName, currentShopName);
        }
        await addBannerList(introList!);
      } else {
        isError = true;
        errorMsg = responseGetCampaign!.respDesc!;
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

  Future<void> getIndustryList() async {
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

  Future<void> getIndustryListUpdate() async {
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

        String currentIndId = await HiveProvider.get(LocalConst.userIndustryId);
        String currentShopName = await HiveProvider.get(LocalConst.userShopName);

        shopName = currentShopName;
        //shopName="ABC STORE";

        shopNameController.text = shopName;

        for (int i = 0; i < industriesList!.length; i++) {
          Industry item = industriesList![i];
          if (item.industryId == int.parse(currentIndId)) {
            selectedIndex = i;
          }
        }

        checkValidation();
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

  Future<void> updateIndustry(WidgetRef ref, bool isFromUpdate) async {
    String industryName = industriesList![selectedIndex].industryName.toString();
    int? industryId = industriesList![selectedIndex].industryId;

    RequestUpdateIndustry requestUpdateIndustry = RequestUpdateIndustry(industryId: industryId, shopName: shopName);

    ApiResult apiResult = await introductionRepository.getUpdateIndustry(requestUpdateIndustry);
    apiResult.when(success: (data) async {
      res.ResponseUpdateIndustry item = data as res.ResponseUpdateIndustry;
      responseUpdateIndustry = item;
      if (responseUpdateIndustry!.respCode == "200") {
        isLoading = false;
        isError = false;

        String currentIndustryId = "";
        String currentIndustryName = "";
        String currentShopName = "";
        currentIndustryId = responseUpdateIndustry!.data!.user!.industryId.toString();
        //currentIndustryName=responseUpdateIndustry!.data!.userIndustryObj!.userIndustryName!;
        currentShopName = responseUpdateIndustry!.data!.user!.shopName.toString();

        //print("....currentIndustryId....$currentIndustryId");
        //print("....currentShopName....$currentShopName");

        await HiveProvider.add(LocalConst.userId, userId);
        await HiveProvider.add(LocalConst.userIndustryId, currentIndustryId);
        //await HiveProvider.add(LocalConst.userIndustryName, currentIndustryName);
        await HiveProvider.add(LocalConst.userShopName, currentShopName);

        if (isFromUpdate) {
          final bannerProviderWatch = ref.watch(bannerProvider);
          await bannerProviderWatch.getOffersByIndustry();
          ref.read(navigationStackProvider).pop();
          ;
        } else {
          if (userId == "0") {
            ref.read(navigationStackProvider).push(const NavigationStackItem.notFound());
            //ref.read(navigationStackProvider).push(const NavigationStackItem.dashboard());
          } else {
            ref.read(navigationStackProvider).push(const NavigationStackItem.notFound());
            //ref.read(navigationStackProvider).push(const NavigationStackItem.marketingTool());
          }
        }
      } else {
        isError = true;
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

  Future<void> updateIndustryV2(WidgetRef ref, bool isFromUpdate) async {
    int? industryId = industriesList![selectedIndex].industryId;

    RequestUpdateIndustry requestUpdateIndustry = RequestUpdateIndustry(industryId: industryId, shopName: shopName);

    ApiResult apiResult = await introductionRepository.getUpdateIndustry(requestUpdateIndustry);
    apiResult.when(success: (data) async {
      res.ResponseUpdateIndustry item = data as res.ResponseUpdateIndustry;
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
        userAddress = responseUpdateIndustry!.data!.user!.address.toString();
        userPhone = responseUpdateIndustry!.data!.user!.phoneno.toString();

        await HiveProvider.add(LocalConst.userId, userId);
        await HiveProvider.add(LocalConst.userIndustryId, currentIndustryId);
        await HiveProvider.add(LocalConst.userShopName, currentShopName);
        await HiveProvider.add(LocalConst.userAddress, userAddress);
        await HiveProvider.add(LocalConst.userPhone, userPhone);

        if (isFromUpdate) {
          /// Need To check After Update Redirection
          final bannerProviderWatch = ref.watch(bannerProvider);
          //await bannerProviderWatch.getOffersByIndustry();
          await bannerProviderWatch.getPosterList();
          ref.read(navigationStackProvider).pop();
          ;
        } else {
          await UserExperior.addEvent(KeyAnalytics.keyCreatePosterNew, "", KeyAnalytics.keyTypeEvent);
          ref.read(navigationStackProvider).push(const NavigationStackItem.notFound());
          //ref.read(navigationStackProvider).push(const NavigationStackItem.newPoster());
        }
      } else {
        isError = true;
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

class BannerModel {
  final String? title;
  final String? subtitle;
  final String? image;
  final int? campaignId;
  final String? videoUrl;

  BannerModel({this.title, this.subtitle, this.image, this.campaignId, this.videoUrl});
}
