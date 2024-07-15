import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/material/scaffold.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http_parser/http_parser.dart';
import 'package:injectable/injectable.dart';
import 'package:mime_type/mime_type.dart';
import 'package:my_flutter_module/framework/provider/local_storage/hive/hive_provider.dart';
import 'package:my_flutter_module/framework/provider/local_storage/local_const.dart';
import 'package:my_flutter_module/framework/provider/network/api_result.dart';
import 'package:my_flutter_module/framework/provider/network/dio/error_response.dart';
import 'package:my_flutter_module/framework/provider/network/network_exceptions.dart';
import 'package:my_flutter_module/framework/repository/banner/contract/banner_repository.dart';
import 'package:my_flutter_module/framework/repository/banner/model/request_edit_poster.dart';
import 'package:my_flutter_module/framework/repository/banner/model/request_offer_text.dart';
import 'package:my_flutter_module/framework/repository/banner/model/request_offers_by_industry.dart';
import 'package:my_flutter_module/framework/repository/banner/model/request_save_banner.dart';
import 'package:my_flutter_module/framework/repository/banner/model/request_save_poster.dart';
import 'package:my_flutter_module/framework/repository/banner/model/request_update_banner.dart';
import 'package:my_flutter_module/framework/repository/banner/model/response_banner_list.dart';
import 'package:my_flutter_module/framework/repository/banner/model/response_image_upload.dart';
import 'package:my_flutter_module/framework/repository/banner/model/response_offer_text.dart';
import 'package:my_flutter_module/framework/repository/banner/model/response_offers_by_industry.dart';
import 'package:my_flutter_module/framework/repository/banner/model/response_posters.dart';
import 'package:my_flutter_module/framework/repository/banner/model/response_save_banner.dart';
import 'package:my_flutter_module/framework/repository/banner/model/response_save_poster.dart';
import 'package:my_flutter_module/framework/repository/banner/model/response_update_banner.dart';
import 'package:my_flutter_module/framework/repository/banner/model/response_user_images.dart';
import 'package:my_flutter_module/framework/repository/banner/model/response_user_industry.dart';
import 'package:my_flutter_module/framework/utility/app_google_analytics/key_analytics.dart';
import 'package:my_flutter_module/framework/utility/app_google_analytics/user_experior.dart';
import 'package:my_flutter_module/ui/routing/navigation_stack_item.dart';
import 'package:my_flutter_module/ui/routing/stack.dart';
import 'package:my_flutter_module/ui/theme/theme_const.dart';
import 'package:my_flutter_module/ui/widgets/app_toast.dart';

@injectable
class BannerController extends ChangeNotifier {
  final BannerRepository bannerRepository;

  BannerController(this.bannerRepository);

  int selectedTab = 0;
  Color? color;
  List<Color>? colorList = [];
  String selectedLanguage = "English";

  List<String> languageList = ["English", "हिंदी"];

  DiscountDetails? discountDetails;

  String shopName = "";
  String address = "";
  String phone = "";

  bool isLoading = true;
  bool isError = false;
  String errorMsg = "";

  OfferList? selectedOfferItem;
  BannerItem? userBannerItem;
  Poster? poster;

  ResponseOffersByIndustry? responseOffersByIndustry;
  List<Offer> userOffersTypeList = [];
  ResponseSaveBanner? responseSaveBanner;
  ResponseBannerList? responseBannerList;
  ResponseUpdateBanner? responseUpdateBanner;
  List<BannerItem> userBanners = [];
  ResponseSavePoster? responseSavePoster;
  ResponseSavePoster? resEditPoster;

  ///V2
  ResponseUserIndustry? responseUserIndustry;
  List<Faq?>? faq = [];

  String userId = "";
  String currentIndustryId = "";
  String currentShopName = "";
  String userAddress = "";
  String userPhone = "";

  ResponseOfferText? responseOfferText;
  List<OfferText?>? offers = [];

  ResponseUserImages? responseUserImages;
  List<UserImage?>? userImages = [];

  List<Poster>? posters = [];

  ResponsePosters? responsePosters;

  List<String> arrPosterImageNew = [
    "https://picsum.photos/id/237/200/300",
    "https://picsum.photos/id/58/200/300",
    "https://picsum.photos/id/9/200/300",
    "https://picsum.photos/id/61/200/300",
    "https://picsum.photos/id/21/200/300",
    "https://picsum.photos/id/63/200/300",
    "https://picsum.photos/id/23/200/300",
    "https://picsum.photos/id/77/200/300",
    "https://picsum.photos/id/25/200/300",
    "https://picsum.photos/id/85/200/300",
    "https://picsum.photos/id/27/200/300",
    "https://picsum.photos/id/102/200/300",
    "https://picsum.photos/id/30/200/300",
    "https://picsum.photos/id/113/200/300",
    "https://picsum.photos/id/53/200/300",
    "https://picsum.photos/id/121/200/300",
    "https://picsum.photos/id/130/200/300",
  ];

  /* List<String> arrPosterImage = [];*/

  int displayImageIndex = 0;
  int selectedImageIndex = 0;

  int updateDisplayImageIndex = 0;
  int updateImageIndex = 0;

  String strOfferText = "New collection of mobile covers available at ₹199";
  String strAddressLine = "Raju Mobile Shop | Contact: 9876543210 117D, Prem Colony, Near Gayatri Mandir, Ambala Cantt";
  String strSelectedImage = "";
  String strDisplayImage = "";

  String strUpdateOfferText = "";
  String strUpdateAddressLine = "";
  String strUpdateSelectedImage = "";
  String strDisplayUpdateImage = "";

  ///First Time
  /*bool isShowChangePosterBackground = false;
  bool isShowChangePosterText = true;*/

  ///When shop created
  bool isShowChangePosterBackground = false;
  bool isShowChangePosterText = false;

  /*TextEditingController offerController = TextEditingController();
  TextEditingController addressController = TextEditingController();
*/
  TextEditingController offerUpdateController = TextEditingController();
  TextEditingController addressUpdateController = TextEditingController();

  bool isCreatePosterFromHome = false;

  ///File Upload
  bool isErrorFileGallery = false;
  String errorMsgFileGallery = "";
  String galleryFileName = "";
  MultipartFile? fileUploadGallery;
  ResponseImageUpload? responseImageUpload;

  bool isLoadingFile = false;
  bool isShowHindiButton = false;

  List<String> playList = [];

  bool isLoadingShare = false;

  bool isShowSaveShare = false;

  bool isChangeText = false;
  bool isChangeAddress = false;
  bool isChangeImage = false;

  /// Update Loading Share
  Future<void> updateIsLoadShare(bool val) async {
    isLoadingShare = val;
    notifyListeners();
  }

  Future<void> updateShareButton() async {
    if (isChangeText || isChangeImage || isChangeImage) {
      isShowSaveShare = true;
    }

    notifyListeners();
  }

  Future<void> updateIsChangeImage(bool val) async {
    isChangeImage = val;
    notifyListeners();
  }

  ///updateIsCreatePosterFromHome
  updateIsCreatePosterFromHome(bool isUpdate) {
    isCreatePosterFromHome = isUpdate;
    notifyListeners();
  }

  ///PosterBackground Info Popup
  setShowChangePosterBackground(bool status) {
    isShowChangePosterBackground = status;
    notifyListeners();
  }

  ///PosterText Info Popup
  setShowChangePosterText(bool status) {
    isShowChangePosterText = status;
    notifyListeners();
  }

  /// Set Display Index
  setDisplayImageIndex(int index, bool isUpdate) async {
    if (isUpdate) {
      updateDisplayImageIndex = index;
    } else {
      displayImageIndex = index;
    }
    await updateShareButton();

    notifyListeners();
  }

  /// Set Display Index
  setSelectedImageIndex(int index, bool isUpdate) async {
    if (isUpdate) {
      updateImageIndex = index;
      strUpdateSelectedImage = userImages![index]!.url!;
      strDisplayUpdateImage = userImages![index]!.signedUrl!;
    } else {
      selectedImageIndex = index;
      strSelectedImage = userImages![index]!.url!;
      strDisplayImage = userImages![index]!.signedUrl!;
    }
    await updateShareButton();
    notifyListeners();
  }

  updateOfferText(String offerText, bool isUpdate) async {
    if (isUpdate) {
      strUpdateOfferText = offerText;
    } else {
      strOfferText = offerText;
      isChangeText = true;
    }
    await updateShareButton();

    notifyListeners();
  }

  updateAddressLine(String addressLine, bool isUpdate) async {
    if (isUpdate) {
      strUpdateAddressLine = addressLine;
    } else {
      strAddressLine = addressLine;
      isChangeText = true;
    }
    await updateShareButton();
    notifyListeners();
  }

  /// Display Hindi Switch if lan is english
  Future<void> setLang() async {
    dynamic appLanguage = await HiveProvider.get(LocalConst.language);

    if (appLanguage == "en") {
      isShowHindiButton = true;
    } else {
      isShowHindiButton = false;
    }
    notifyListeners();
  }

  /// Create Poster
  Future<void> changeLangHindi(BuildContext context, String lang) async {
    if (lang == "en") {
      await HiveProvider.add(LocalConst.language, "en");
      await context.setLocale(const Locale('en'));
      isShowHindiButton = true;
      notifyListeners();
    } else if (lang == "hi") {
      await HiveProvider.add(LocalConst.language, "hi");
      await context.setLocale(const Locale('hi'));
      isShowHindiButton = false;
      notifyListeners();
    } else {
      await HiveProvider.add(LocalConst.language, "en");
      await context.setLocale(const Locale('en'));
      isShowHindiButton = true;
      notifyListeners();
    }
  }

  Future<void> changeLangHindiOnBoarding(BuildContext context, WidgetRef ref, String lang) async {
    if (lang == "en") {
      await HiveProvider.add(LocalConst.language, "en");
      await context.setLocale(const Locale('en'));
      isShowHindiButton = true;
      notifyListeners();
      await getUserIndustry(ref, true);
    } else if (lang == "hi") {
      await HiveProvider.add(LocalConst.language, "hi");
      await context.setLocale(const Locale('hi'));
      isShowHindiButton = false;
      notifyListeners();
      await getUserIndustry(ref, true);
    } else {
      await HiveProvider.add(LocalConst.language, "en");
      await context.setLocale(const Locale('en'));
      isShowHindiButton = true;
      notifyListeners();
      await getUserIndustry(ref, true);
    }
  }

  Future<void> getOffersByIndustry() async {
    isLoading = true;

    dynamic appLanguage = await HiveProvider.get(LocalConst.language);
    if (appLanguage == null) {
      selectedLanguage = "English";
      selectedLanguage = "हिंदी";
    }
    if (appLanguage == "en") {
      selectedLanguage = "English";
    }
    if (appLanguage == "hi") {
      selectedLanguage = "हिंदी";
    }

    //await context.setLocale(Locale(langStr));

    notifyListeners();

    String currentIndustryId = await HiveProvider.get(LocalConst.userIndustryId);

    RequestOffersByIndustry requestOffersByIndustry = RequestOffersByIndustry();
    requestOffersByIndustry.industryId = int.parse(currentIndustryId);

    ApiResult apiResult = await bannerRepository.getOffersByIndustry(requestOffersByIndustry);
    apiResult.when(success: (data) async {
      ResponseOffersByIndustry item = data as ResponseOffersByIndustry;
      responseOffersByIndustry = item;
      if (responseOffersByIndustry!.respCode == "200") {
        isLoading = false;
        isError = false;

        //shopName="ABC Store";

        String userShop = await HiveProvider.get(LocalConst.userShopName);
        shopName = userShop.toUpperCase();

        userOffersTypeList = responseOffersByIndustry!.data!.offers!;
      } else {
        isError = true;
        errorMsg = responseOffersByIndustry!.respDesc!;
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

  Future<void> saveBanner(WidgetRef ref, ScaffoldMessengerState state) async {
    isLoading = true;
    notifyListeners();

    RequestSaveBanner requestSaveBanner = RequestSaveBanner();
    requestSaveBanner.offerId = selectedOfferItem!.offerId;
    requestSaveBanner.offerName = txtOfferName;
    requestSaveBanner.offerDesc = txtOfferDesc;

    ApiResult apiResult = await bannerRepository.saveBanner(requestSaveBanner);
    apiResult.when(success: (data) async {
      ResponseSaveBanner item = data as ResponseSaveBanner;
      responseSaveBanner = item;
      if (responseSaveBanner!.respCode == "200") {
        isLoading = false;
        isError = false;
        await getBannerList();
        ref.read(navigationStackProvider).pushRemove(const NavigationStackItem.notFound());
        //ref.read(navigationStackProvider).pushRemove(const NavigationStackItem.shareBanner());
      } else {
        //isError = true;
        errorMsg = responseSaveBanner!.respDesc!;
        AppToast.showSnackBar(errorMsg, state);
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

  Future<void> editBanner(WidgetRef ref, ScaffoldMessengerState state) async {
    isLoading = true;
    notifyListeners();

    RequestUpdateBanner requestUpdateBanner = RequestUpdateBanner();
    requestUpdateBanner.offerId = int.parse(userBannerItem!.originalOffer!.offerId.toString());
    requestUpdateBanner.offerName = txtOfferNameEdit;
    requestUpdateBanner.offerDesc = txtOfferDescEdit;
    requestUpdateBanner.bannerId = int.parse(userBannerItem!.bannersId.toString());

    ApiResult apiResult = await bannerRepository.updateUserBanner(requestUpdateBanner);
    apiResult.when(success: (data) async {
      ResponseUpdateBanner item = data as ResponseUpdateBanner;
      responseUpdateBanner = item;
      if (responseUpdateBanner!.respCode == "200") {
        isLoading = false;
        isError = false;
        userBannerItem!.offerName = txtOfferNameEdit;
        userBannerItem!.offerDesc = txtOfferDescEdit;
        //await getBannerList();
        await getPosterList();

        ref.read(navigationStackProvider).pop();
        ;
      } else {
        //isError = true;
        errorMsg = responseUpdateBanner!.respDesc!;
        AppToast.showSnackBar(errorMsg, state);
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

  Future<void> updateOfferItem(OfferList offerItem) async {
    selectedOfferItem = offerItem;
    notifyListeners();
  }

  Future<void> updateUserBannerItem(BannerItem item) async {
    userBannerItem = item;
    notifyListeners();
  }

  Future<void> updateUserPosterItem(Poster item) async {
    poster = item;
    offerUpdateController.text = poster!.offerName!;
    strUpdateOfferText = poster!.offerName!;
    addressUpdateController.text = poster!.offerDesc!;
    strUpdateAddressLine = poster!.offerDesc!;
    strUpdateSelectedImage = poster!.imageUrl!;
    strDisplayUpdateImage = poster!.signedUrl!;

    notifyListeners();
  }

  Future<void> getBannerList() async {
    isLoading = true;
    notifyListeners();

    ApiResult apiResult = await bannerRepository.getBannerList();
    apiResult.when(success: (data) async {
      ResponseBannerList item = data as ResponseBannerList;
      responseBannerList = item;
      if (responseBannerList!.respCode == "200") {
        isLoading = false;
        isError = false;
        String userShop = await HiveProvider.get(LocalConst.userShopName);
        shopName = userShop.toUpperCase();
        userBanners = responseBannerList!.data!.banners!;
      } else {
        isError = true;
        errorMsg = responseBannerList!.respDesc!;
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

  ///V2

  Future<void> saveAndShare(WidgetRef ref, ScaffoldMessengerState state, bool isFromHome) async {
    isLoading = true;
    notifyListeners();

    RequestSavePoster requestSavePoster = RequestSavePoster(
        offerName: strOfferText, offerDesc: strAddressLine, imageUrl: strSelectedImage, createFor: '');

    ApiResult apiResult = await bannerRepository.saveSharePoster(requestSavePoster);
    apiResult.when(success: (data) async {
      ResponseSavePoster item = data as ResponseSavePoster;
      responseSavePoster = item;
      if (responseSavePoster!.respCode == "200") {
        isLoading = false;
        isError = false;

        if (isFromHome) {
          await getPosterList();
          Poster item = Poster();
          item.signedUrl = responseSavePoster!.data!.banner!.signedUrl;
          item.imageUrl = responseSavePoster!.data!.banner!.imageUrl;
          item.bannersId = responseSavePoster!.data!.banner!.bannersId;
          item.offerName = responseSavePoster!.data!.banner!.offerName;
          item.offerDesc = responseSavePoster!.data!.banner!.offerDesc;
          await updateUserPosterItem(item);
          await UserExperior.addEvent(KeyAnalytics.keyPosterDetails, "", KeyAnalytics.keyTypeEvent);
          ref.read(navigationStackProvider).pushRemove(const NavigationStackItem.notFound());
          //ref.read(navigationStackProvider).pushRemove(const NavigationStackItem.posterDetails());
        } else {
          await getPosterList();
          Poster item = Poster();
          item.signedUrl = responseSavePoster!.data!.banner!.signedUrl;
          item.imageUrl = responseSavePoster!.data!.banner!.imageUrl;
          item.bannersId = responseSavePoster!.data!.banner!.bannersId;
          item.offerName = responseSavePoster!.data!.banner!.offerName;
          item.offerDesc = responseSavePoster!.data!.banner!.offerDesc;
          await updateUserPosterItem(item);

          await UserExperior.addEvent(KeyAnalytics.keyHome, "", KeyAnalytics.keyTypeEvent);
          ref.read(navigationStackProvider).push(const NavigationStackItem.notFound());
          /*ref.read(navigationStackProvider).pushAll([const NavigationStackItem.marketingToolHome(),
              const NavigationStackItem.posterDetails()]);*/
        }
      } else {
        //isError = true;
        errorMsg = responseSavePoster!.respDesc!;
        AppToast.showSnackBar(errorMsg, state);
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

  Future<void> editPoster(WidgetRef ref, ScaffoldMessengerState state) async {
    isLoading = true;
    notifyListeners();

    RequestEditPoster requestEditPoster = RequestEditPoster(
        offerName: strUpdateOfferText,
        offerDesc: strUpdateAddressLine,
        imageUrl: strUpdateSelectedImage,
        bannerId: poster!.bannersId.toString());

    ApiResult apiResult = await bannerRepository.editPoster(requestEditPoster);
    apiResult.when(success: (data) async {
      ResponseSavePoster item = data as ResponseSavePoster;
      resEditPoster = item;
      if (resEditPoster!.respCode == "200") {
        isLoading = false;
        isError = false;

        poster!.imageUrl = resEditPoster!.data!.banner!.imageUrl;
        poster!.offerName = resEditPoster!.data!.banner!.offerName;
        poster!.offerDesc = resEditPoster!.data!.banner!.offerDesc;
        poster!.signedUrl = resEditPoster!.data!.banner!.signedUrl;

        ///Need to add create var with condation

        strUpdateOfferText = resEditPoster!.data!.banner!.offerName!;
        strUpdateAddressLine = resEditPoster!.data!.banner!.offerDesc!;
        strUpdateSelectedImage = resEditPoster!.data!.banner!.imageUrl!;
        strDisplayUpdateImage = resEditPoster!.data!.banner!.signedUrl!;

        await getPosterList();
        ref.read(navigationStackProvider).pop();
        ;
      } else {
        //isError = true;
        errorMsg = resEditPoster!.respDesc!;
        AppToast.showSnackBar(errorMsg, state);
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

  Future<void> getUserIndustry(WidgetRef ref, bool isChangeLang) async {
    isLoading = true;
    notifyListeners();

    ///Set Language for Api
    dynamic appLanguage = await HiveProvider.get(LocalConst.language);
    if (appLanguage == null) {
      await HiveProvider.add(LocalConst.language, "en");
    } else {
      await HiveProvider.add(LocalConst.language, appLanguage);
    }

    ApiResult apiResult = await bannerRepository.getUserIndustry();
    apiResult.when(success: (data) async {
      ResponseUserIndustry item = data as ResponseUserIndustry;
      responseUserIndustry = item;
      if (responseUserIndustry!.respCode == "200") {
        isLoading = false;
        isError = false;
        User? user = responseUserIndustry!.data!.user;

        if (responseUserIndustry!.data!.video.toString().isNotEmpty) {
          playList.add(responseUserIndustry!.data!.video.toString().split("=").last);
        }

        if (responseUserIndustry!.data!.faq!.isNotEmpty) {
          faq = responseUserIndustry!.data!.faq;
        }

        if (isChangeLang) {
          //faq=responseUserIndustry!.data!.faq;
        } else {
          /// Check if Shop is created or not
          if (user!.clientId == "null") {
            /// Remove Now will update latter on
            ///Show Info window flags
            isShowChangePosterBackground = false;
            isShowChangePosterText = true;

            //faq=responseUserIndustry!.data!.faq;
            await UserExperior.addEvent(KeyAnalytics.keyIntroduction, "", KeyAnalytics.keyTypeEvent);
            ref.read(navigationStackProvider).push(const NavigationStackItem.getStarted());
          } else {
            userId = user.clientId.toString();
            currentIndustryId = user.industryDetails!.industryId.toString();
            shopName = user.shopName.toString();
            strAddressLine = user.contactInfo.toString();

            posters = user.banners;

            await HiveProvider.add(LocalConst.userId, userId);
            await HiveProvider.add(LocalConst.userIndustryId, currentIndustryId);
            await HiveProvider.add(LocalConst.userShopName, shopName);
            await HiveProvider.add(LocalConst.userAddress, strAddressLine);
            await HiveProvider.add(LocalConst.userPhone, phone);

            if (posters!.isNotEmpty) {
              await UserExperior.addEvent(KeyAnalytics.keyHome, "", KeyAnalytics.keyTypeEvent);
              ref.read(navigationStackProvider).push(const NavigationStackItem.home());
            } else {
              await UserExperior.addEvent(KeyAnalytics.keyCreatePosterNew, "", KeyAnalytics.keyTypeEvent);
              /*ref
                  .read(navigationStackProvider)
                  .push(const NavigationStackItem.home());*/
              ref.read(navigationStackProvider).push(const NavigationStackItem.offerText());
            }
          }
        }
      } else {
        isError = true;
        errorMsg = responseUserIndustry!.respDesc!;
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

  Future<void> getFaq() async {
    isLoading = true;
    notifyListeners();

    ///Set Language for Api
    dynamic appLanguage = await HiveProvider.get(LocalConst.language);
    if (appLanguage == null) {
      await HiveProvider.add(LocalConst.language, "en");
    } else {
      await HiveProvider.add(LocalConst.language, appLanguage);
    }

    ApiResult apiResult = await bannerRepository.getUserIndustry();
    apiResult.when(success: (data) async {
      ResponseUserIndustry item = data as ResponseUserIndustry;
      responseUserIndustry = item;
      if (responseUserIndustry!.respCode == "200") {
        isLoading = false;
        isError = false;
        if (responseUserIndustry!.data!.faq!.isNotEmpty) {
          faq = responseUserIndustry!.data!.faq;
        }
      } else {
        isError = true;
        errorMsg = responseUserIndustry!.respDesc!;
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

  Future<void> getOfferTexts(ScaffoldMessengerState state, bool isNew) async {
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
        String userShop = await HiveProvider.get(LocalConst.userShopName) ?? "-";
        String userAddress = await HiveProvider.get(LocalConst.userAddress) ?? "-";
        String userPhone = await HiveProvider.get(LocalConst.userPhone) ?? "-";
        shopName = userShop.toUpperCase();
        address = userAddress;
        phone = userPhone;
        strAddressLine = "$shopName | Contact: $phone , $address";
        if (isNew) {
          strOfferText = offers![0]!.offerDesc!;
        }
      } else {
        isLoading = false;
        errorMsg = responseOfferText!.respDesc!;
        AppToast.showSnackBar(errorMsg, state);
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

  Future<void> getUserImages(ScaffoldMessengerState state, bool isFromUpdate, bool isNew, String? url,
      BuildContext buildContext, bool doNotBack) async {
    isLoading = true;
    notifyListeners();

    ApiResult apiResult = await bannerRepository.getUserImages();
    apiResult.when(success: (data) async {
      ResponseUserImages item = data as ResponseUserImages;
      responseUserImages = item;
      if (responseUserImages!.respCode == "200") {
        isLoading = false;
        isError = false;
        userImages = responseUserImages!.data!.userImages;

        /*for (var element in arrPosterImageNew) {
          userImages!.add(UserImage(url: element,isActive: 1,signedUrl: element));
        }*/

        if (isFromUpdate) {
          String comUrl = "";
          if (url!.isEmpty) {
            comUrl = poster!.imageUrl!;
          } else {
            comUrl = url;
          }

          String posterMainUrl = poster!.imageUrl!;

          for (int i = 0; i < userImages!.length; i++) {
            if (comUrl == userImages![i]!.url) {
              updateImageIndex = i;
              strDisplayUpdateImage = userImages![i]!.signedUrl!;
              strUpdateSelectedImage = userImages![i]!.url!;

              print("...updateImageIndex....$updateImageIndex");
              print("...strDisplayUpdateImage....$strDisplayUpdateImage");
              print("...strUpdateSelectedImage....$strUpdateSelectedImage");
              print("...doNotBack....$doNotBack");

              if (doNotBack) {
              } else {
                Navigator.of(buildContext).pop();
              }
            }
          }
        } else {
          int defIndex = 2;
          for (int i = 0; i < userImages!.length; i++) {
            UserImage? item = userImages![i];
            if (item!.isDefault == 1) {
              defIndex = i;
            }
          }
          strSelectedImage = userImages![defIndex]!.url!;
          strDisplayImage = userImages![defIndex]!.signedUrl!;
          await setSelectedImageIndex(defIndex, false);
        }

        if (isNew) {
          if (isFromUpdate) {
            Navigator.of(buildContext).pop();
          } else {
            int index = 0;

            for (int i = 0; i < userImages!.length; i++) {
              if (url == userImages![i]!.url) {
                index = i;
                strDisplayImage = userImages![i]!.signedUrl!;
                strSelectedImage = userImages![i]!.url!;
                isChangeImage = true;
                await setSelectedImageIndex(i, false);
                Navigator.of(buildContext).pop();
              }
            }

            await setDisplayImageIndex(index, false);
          }
        }
      } else {
        isLoading = false;
        errorMsg = responseUserImages!.respDesc!;
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

  Future<void> getPosterList() async {
    isLoading = true;
    notifyListeners();

    /*dynamic appLanguage= await HiveProvider.get(LocalConst.language);
    if(appLanguage==null)
    {
      await HiveProvider.add(LocalConst.language, "en");
      appLanguage="en";
      print("......xxxxxx.....eng.........$appLanguage");
    }
    else
    {
      await HiveProvider.add(LocalConst.language, appLanguage);
      print("......xxxxxx.....hi.........$appLanguage");
    }

    print("......xxxxxx.....getBannerList......appLanguage...$appLanguage");*/

    ApiResult apiResult = await bannerRepository.getPosterList();
    apiResult.when(success: (data) async {
      ResponsePosters item = data as ResponsePosters;
      responsePosters = item;
      if (responsePosters!.respCode == "200") {
        String userShop = await HiveProvider.get(LocalConst.userShopName) ?? "Demo Sagar";
        shopName = userShop.toUpperCase();
        isLoading = false;
        isError = false;
        posters = responsePosters!.data!.banners;
      } else {
        isError = true;
        isLoading = false;
        errorMsg = responseBannerList!.respDesc!;
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

  Future<String> getRandomString(int length) async {
    const chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random rnd = Random();
    return String.fromCharCodes(Iterable.generate(length, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
  }

  ///Extra

  Future<void> updateDropDownValue(String? value, BuildContext context) async {
    selectedLanguage = value!;

    if (selectedLanguage == "हिंदी") {
      await HiveProvider.add(LocalConst.language, "hi");
      await context.setLocale(const Locale('hi'));
    }

    if (selectedLanguage == "English") {
      await HiveProvider.add(LocalConst.language, "en");
      await context.setLocale(const Locale('en'));
    }

    notifyListeners();
  }

  /// This is called when home screen create button
  clearProvider() {
    colorList!.clear();
    discountDetails = null;

    isChangeText = false;
    isChangeAddress = false;
    isChangeImage = false;
    isShowSaveShare = false;

    displayImageIndex = 3;
    strOfferText = "New collection of mobile covers available at ₹199";
    strAddressLine = "Raju Mobile Shop | Contact: 9876543210 117D, Prem Colony, Near Gayatri Mandir, Ambala Cantt";

    notifyListeners();
  }

  Future<void> setDiscountDetails(DiscountDetails value) async {
    discountDetails = value;
    notifyListeners();
  }

  /// Add List of colors
  addColorsList() {
    colorList!.add(Constant.instance.clrBlack);
    colorList!.add(Constant.instance.clrTextGrey);
    colorList!.add(Constant.instance.clrWhite);
    colorList!.add(Constant.instance.clrNearWhite);
    colorList!.add(Constant.instance.clrBlue);
    colorList!.add(Constant.instance.clrGreyLight);
    colorList!.add(Constant.instance.clrTransparent);
    colorList!.add(Constant.instance.clrBGBlueLight);
    colorList!.add(Constant.instance.clrBrown);
    colorList!.add(Constant.instance.clrGreen);
    notifyListeners();
  }

  /// Update picked color
  updateColor(Color colors) {
    color = colors;
    notifyListeners();
  }

  /// Update Selected Tab index
  updateSelectedTab(int value) {
    selectedTab = value;
    notifyListeners();
  }

  /// List Of Tabs
  List<String> tabList = ["Key_DiscountOffer", "Key_NewItemService", "Key_FestiveOffer"];

  String txtShopName = "";
  String txtOfferName = "";
  String txtOfferDesc = "";

  String txtOfferNameEdit = "";
  String txtOfferDescEdit = "";

  String errShopname = "";
  String errDiscount = "";
  bool isValidate = false;

  /// --------------offerName--------------
  Future<void> changeOfferName(String strDiscount) async {
    txtOfferName = strDiscount;
    notifyListeners();
  }

  /// --------------Discount--------------
  Future<void> changeOfferDesc(String txtDesc) async {
    txtOfferDesc = txtDesc;
    notifyListeners();
  }

  /// --------------offerName----Edit----------
  Future<void> changeOfferNameEdit(String strDiscount) async {
    txtOfferNameEdit = strDiscount;
    notifyListeners();
  }

  /// --------------Discount-------Edit-------
  Future<void> changeOfferDescEdit(String txtDesc) async {
    txtOfferDescEdit = txtDesc;
    notifyListeners();
  }
}

class DiscountDetails {
  final String? shopName;
  final String? discount;
  final String? discountDesc;

  DiscountDetails({this.shopName, this.discountDesc, this.discount});
}
