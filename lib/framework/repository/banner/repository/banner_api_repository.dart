import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:my_flutter_module/framework/provider/network/api_end_points.dart';
import 'package:my_flutter_module/framework/provider/network/api_result.dart';
import 'package:my_flutter_module/framework/provider/network/dio/dio_client.dart';
import 'package:my_flutter_module/framework/provider/network/network_exceptions.dart';
import 'package:my_flutter_module/framework/repository/banner/contract/banner_repository.dart';
import 'package:my_flutter_module/framework/repository/banner/model/request_edit_address.dart';
import 'package:my_flutter_module/framework/repository/banner/model/request_edit_poster.dart';
import 'package:my_flutter_module/framework/repository/banner/model/request_offer_text.dart';
import 'package:my_flutter_module/framework/repository/banner/model/request_offers_by_industry.dart';
import 'package:my_flutter_module/framework/repository/banner/model/request_save_banner.dart';
import 'package:my_flutter_module/framework/repository/banner/model/request_save_poster.dart';
import 'package:my_flutter_module/framework/repository/banner/model/request_update_banner.dart';
import 'package:my_flutter_module/framework/repository/banner/model/response_banner_list.dart';
import 'package:my_flutter_module/framework/repository/banner/model/response_edit_address.dart';
import 'package:my_flutter_module/framework/repository/banner/model/response_faq.dart';
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
import 'package:my_flutter_module/framework/utility/app_google_analytics/user_experior_analytics.dart';

@LazySingleton(as: BannerRepository, env: ['debug', 'production'])
class BannerApiRepository implements BannerRepository {
  final DioClient apiClient;

  BannerApiRepository(this.apiClient);

  @override
  Future getOffersByIndustry(RequestOffersByIndustry requestOffersByIndustry) async {
    // TODO: implement getOffersByIndustry
    try {
      String data = requestOffersByIndustryToJson(requestOffersByIndustry);
      final Response res = await apiClient.postData(ApiEndPoints.getOffersByIndustry, data);
      ResponseOffersByIndustry responseOffersByIndustry = responseOffersByIndustryFromJson(res.toString());
      return ApiResult.success(data: responseOffersByIndustry);
    } catch (e, s) {
      print(".....getOffersByIndustry......${e.toString()}");
      print(".....getOffersByIndustry......${s.toString()}");
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future saveBanner(RequestSaveBanner requestSaveBanner) async {
    // TODO: implement saveBanner
    try {
      String data = requestSaveBannerToJson(requestSaveBanner);
      final Response res = await apiClient.postData(ApiEndPoints.savebanner, data);
      ResponseSaveBanner responseSaveBanner = responseSaveBannerFromJson(res.toString());
      return ApiResult.success(data: responseSaveBanner);
    } catch (e, s) {
      print(".....saveBanner......${e.toString()}");
      print(".....saveBanner......${s.toString()}");
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future getBannerList() async {
    try {
      final Response res = await apiClient.getData(ApiEndPoints.getBannerList);
      ResponseBannerList responseBannerList = responseBannerListFromJson(res.toString());
      return ApiResult.success(data: responseBannerList);
    } catch (e, s) {
      print(".....getBannerList......${e.toString()}");
      print(".....getBannerList......${s.toString()}");
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future updateUserBanner(RequestUpdateBanner requestUpdateBanner) async {
    try {
      String data = requestUpdateBannerToJson(requestUpdateBanner);
      final Response res = await apiClient.postData(ApiEndPoints.updateUserBanner, data);
      ResponseUpdateBanner responseUpdateBanner = responseUpdateBannerFromJson(res.toString());
      return ApiResult.success(data: responseUpdateBanner);
    } catch (e, s) {
      print(".....updateUserBanner......${e.toString()}");
      print(".....updateUserBanner......${s.toString()}");
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future getUserIndustry() async {
    try {
      String eventDataStart = const JsonEncoder().convert(UserExpAnalytics.createExpReq(
        url: ApiEndPoints.getUserIndustry,
        mainProcess: "Prachar",
        subProcess: "getUserIndustry",
        method: "Get",
        body: "",
      ));
      await UserExperior.addEvent(ApiEndPoints.getUserIndustry, eventDataStart, KeyAnalytics.keyTypeRequest);

      final Response res = await apiClient.getData(ApiEndPoints.getUserIndustry);
      ResponseUserIndustry? responseUserIndustry = responseUserIndustryFromJson(res.toString());

      String eventDataEnd = const JsonEncoder().convert(UserExpAnalytics.createExpRes(
        response: res.toString(),
        responseCode: responseUserIndustry.respCode,
        responseStatus: responseUserIndustry.respStatus,
        responseDes: responseUserIndustry.respDesc,
      ));

      await UserExperior.addEvent(ApiEndPoints.getUserIndustry, eventDataEnd, KeyAnalytics.keyTypeResponse);

      return ApiResult.success(data: responseUserIndustry);
    } catch (e, s) {
      print(".....getUserIndustry......${e.toString()}");
      print(".....getUserIndustry......${s.toString()}");
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future getOfferText(RequestOfferText requestOfferText) async {
    // TODO: implement getOfferText
    try {
      String data = requestOfferTextToJson(requestOfferText);
      String eventDataStart = const JsonEncoder().convert(UserExpAnalytics.createExpReq(
        url: ApiEndPoints.getOfferText,
        mainProcess: "Prachar",
        subProcess: "getOfferText",
        method: "Post",
        body: data,
      ));
      await UserExperior.addEvent(ApiEndPoints.getOfferText, eventDataStart, KeyAnalytics.keyTypeRequest);
      final Response res = await apiClient.postData(ApiEndPoints.getOfferText, data);
      ResponseOfferText? responseOfferText = responseOfferTextFromJson(res.toString());

      String eventDataEnd = const JsonEncoder().convert(UserExpAnalytics.createExpRes(
        response: res.toString(),
        responseCode: responseOfferText!.respCode,
        responseStatus: responseOfferText.respStatus,
        responseDes: responseOfferText.respDesc,
      ));
      await UserExperior.addEvent(ApiEndPoints.getOfferText, eventDataEnd, KeyAnalytics.keyTypeResponse);

      return ApiResult.success(data: responseOfferText);
    } catch (e, s) {
      print(".....getOfferText......${e.toString()}");
      print(".....getOfferText......${s.toString()}");
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future getUserImages() async {
    // TODO: implement getUserImages
    try {
      String eventDataStart = const JsonEncoder().convert(UserExpAnalytics.createExpReq(
        url: ApiEndPoints.getUserImages,
        mainProcess: "Prachar",
        subProcess: "getUserImages",
        method: "Get",
        body: "",
      ));
      await UserExperior.addEvent(ApiEndPoints.getUserImages, eventDataStart, KeyAnalytics.keyTypeRequest);
      final Response res = await apiClient.getData(ApiEndPoints.getUserImages);
      ResponseUserImages? responseUserImages = responseUserImagesFromJson(res.toString());

      String eventDataEnd = const JsonEncoder().convert(UserExpAnalytics.createExpRes(
        response: res.toString(),
        responseCode: responseUserImages.respCode,
        responseStatus: responseUserImages.respStatus,
        responseDes: responseUserImages.respDesc,
      ));
      await UserExperior.addEvent(ApiEndPoints.getUserImages, eventDataEnd, KeyAnalytics.keyTypeResponse);

      return ApiResult.success(data: responseUserImages);
    } catch (e, s) {
      print(".....getUserImages......${e.toString()}");
      print(".....getUserImages......${s.toString()}");
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future saveSharePoster(RequestSavePoster requestSavePoster) async {
    // TODO: implement saveSharePoster
    try {
      String data = requestSavePosterToJson(requestSavePoster);
      String eventDataStart = const JsonEncoder().convert(UserExpAnalytics.createExpReq(
        url: ApiEndPoints.savePoster,
        mainProcess: "Prachar",
        subProcess: "saveSharePoster",
        method: "Post",
        body: data,
      ));
      await UserExperior.addEvent(ApiEndPoints.savePoster, eventDataStart, KeyAnalytics.keyTypeRequest);
      final Response res = await apiClient.postData(ApiEndPoints.savePoster, data);

      ResponseSavePoster responseSavePoster = responseSavePosterFromJson(res.toString());
      String eventDataEnd = const JsonEncoder().convert(UserExpAnalytics.createExpRes(
        response: res.toString(),
        responseCode: responseSavePoster.respCode,
        responseStatus: responseSavePoster.respStatus,
        responseDes: responseSavePoster.respDesc,
      ));

      await UserExperior.addEvent(ApiEndPoints.savePoster, eventDataEnd, KeyAnalytics.keyTypeResponse);

      return ApiResult.success(data: responseSavePoster);
    } catch (e, s) {
      print(".....saveSharePoster......${e.toString()}");
      print(".....saveSharePoster......${s.toString()}");
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future getPosterList() async {
    // TODO: implement getPosterList
    try {
      String eventDataStart = const JsonEncoder().convert(UserExpAnalytics.createExpReq(
        url: ApiEndPoints.getUserPosters,
        mainProcess: "Prachar",
        subProcess: "getPosterList",
        method: "Get",
        body: "",
      ));
      await UserExperior.addEvent(ApiEndPoints.getUserPosters, eventDataStart, KeyAnalytics.keyTypeRequest);
      final Response res = await apiClient.getData(ApiEndPoints.getUserPosters);

      ResponsePosters responsePosters = responsePostersFromJson(res.toString());

      String eventDataEnd = const JsonEncoder().convert(UserExpAnalytics.createExpRes(
        response: res.toString(),
        responseCode: responsePosters.respCode,
        responseStatus: responsePosters.respStatus,
        responseDes: responsePosters.respDesc,
      ));

      await UserExperior.addEvent(ApiEndPoints.getUserPosters, eventDataEnd, KeyAnalytics.keyTypeResponse);

      return ApiResult.success(data: responsePosters);
    } catch (e, s) {
      print(".....getPosterList......${e.toString()}");
      print(".....getPosterList......${s.toString()}");
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future editPoster(RequestEditPoster requestEditPoster) async {
    // TODO: implement editPoster
    try {
      String data = requestEditPosterToJson(requestEditPoster);
      String eventDataStart = const JsonEncoder().convert(UserExpAnalytics.createExpReq(
        url: ApiEndPoints.savePoster,
        mainProcess: "Prachar",
        subProcess: "editPoster",
        method: "Post",
        body: data,
      ));
      await UserExperior.addEvent(ApiEndPoints.savePoster, eventDataStart, KeyAnalytics.keyTypeRequest);
      final Response res = await apiClient.postData(ApiEndPoints.savePoster, data);

      ResponseSavePoster responseSavePoster = responseSavePosterFromJson(res.toString());

      String eventDataEnd = const JsonEncoder().convert(UserExpAnalytics.createExpRes(
        response: res.toString(),
        responseCode: responseSavePoster.respCode,
        responseStatus: responseSavePoster.respStatus,
        responseDes: responseSavePoster.respDesc,
      ));
      await UserExperior.addEvent(ApiEndPoints.savePoster, eventDataEnd, KeyAnalytics.keyTypeResponse);

      return ApiResult.success(data: responseSavePoster);
    } catch (e, s) {
      print(".....editPoster......${e.toString()}");
      print(".....editPoster......${s.toString()}");
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future uploadImage(FormData formData) async {
    try {
      await UserExperior.addEvent(ApiEndPoints.uploadImage, "", KeyAnalytics.keyTypeRequest);
      final Response res = await apiClient.postFormData(ApiEndPoints.uploadImage, formData);
      ResponseImageUpload responseImageUpload = responseImageUploadFromJson(res.toString());
      await UserExperior.addEvent(ApiEndPoints.uploadImage, res.toString(), KeyAnalytics.keyTypeResponse);
      return ApiResult.success(data: responseImageUpload);
    } catch (e, s) {
      print("....uploadImage.e.....$e");
      print("....uploadImage.s.....$s");
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future editAddress(RequestEditAddress requestEditAddress) async {
    // TODO: implement editAddress
    try {
      String data = requestEditAddressToJson(requestEditAddress);
      String eventDataStart = const JsonEncoder().convert(UserExpAnalytics.createExpReq(
        url: ApiEndPoints.savePoster,
        mainProcess: "Prachar",
        subProcess: "editAddress",
        method: "Post",
        body: data,
      ));
      await UserExperior.addEvent(ApiEndPoints.editAddress, eventDataStart, KeyAnalytics.keyTypeRequest);
      final Response res = await apiClient.postData(ApiEndPoints.editAddress, data);

      ResponseEditAddress responseEditAddress = responseEditAddressFromJson(res.toString());
      String eventDataEnd = const JsonEncoder().convert(UserExpAnalytics.createExpRes(
        response: res.toString(),
        responseCode: responseEditAddress.respCode,
        responseStatus: responseEditAddress.respStatus,
        responseDes: responseEditAddress.respDesc,
      ));

      await UserExperior.addEvent(ApiEndPoints.editAddress, eventDataEnd, KeyAnalytics.keyTypeResponse);

      return ApiResult.success(data: responseEditAddress);
    } catch (e, s) {
      print(".....editAddress......${e.toString()}");
      print(".....editAddress......${s.toString()}");
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future getFaq() async {
    try {
      String eventDataStart = const JsonEncoder().convert(UserExpAnalytics.createExpReq(
        url: ApiEndPoints.getUserPosters,
        mainProcess: "Prachar",
        subProcess: "FAQ",
        method: "Get",
        body: "",
      ));
      await UserExperior.addEvent(ApiEndPoints.getFaq, eventDataStart, KeyAnalytics.keyTypeRequest);
      final Response res = await apiClient.getData(ApiEndPoints.getFaq);

      ResponseFaq responseFaq = responseFaqFromJson(res.toString());

      String eventDataEnd = const JsonEncoder().convert(UserExpAnalytics.createExpRes(
        response: res.toString(),
        responseCode: responseFaq.respCode,
        responseStatus: responseFaq.respStatus,
        responseDes: responseFaq.respDesc,
      ));

      await UserExperior.addEvent(ApiEndPoints.getUserPosters, eventDataEnd, KeyAnalytics.keyTypeResponse);

      return ApiResult.success(data: responseFaq);
    } catch (e, s) {
      print(".....getFaq......${e.toString()}");
      print(".....getFaq......${s.toString()}");
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future deleteBanner(int id) async {
    try {
      String eventDataStart = const JsonEncoder().convert(UserExpAnalytics.createExpReq(
        url: ApiEndPoints.deleteBanner,
        mainProcess: "Prachar",
        subProcess: "DELETE_BANNER",
        method: "POST",
        body: "",
      ));
      final Response res = await apiClient.postJsonData(endpoint: ApiEndPoints.deleteBanner, data: {"bannerId": id});
      ResponseOfferText? responseOfferText = responseOfferTextFromJson(res.toString());

      String eventDataEnd = const JsonEncoder().convert(UserExpAnalytics.createExpRes(
        response: res.toString(),
        responseCode: responseOfferText!.respCode,
        responseStatus: responseOfferText.respStatus,
        responseDes: responseOfferText.respDesc,
      ));

      return ApiResult.success(data: responseOfferText);
    } catch (e, s) {
      print(".....getOfferText......${e.toString()}");
      print(".....getOfferText......${s.toString()}");
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }
}
