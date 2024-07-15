import 'dart:convert';
import 'dart:ui' as ui;

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:injectable/injectable.dart';
import 'package:my_flutter_module/framework/provider/local_storage/hive/hive_provider.dart';
import 'package:my_flutter_module/framework/provider/local_storage/local_const.dart';
import 'package:my_flutter_module/framework/provider/network/api_result.dart';
import 'package:my_flutter_module/framework/provider/network/dio/error_response.dart';
import 'package:my_flutter_module/framework/provider/network/network_exceptions.dart';
import 'package:my_flutter_module/framework/repository/banner/contract/banner_repository.dart';
import 'package:my_flutter_module/framework/repository/banner/model/response_faq.dart';
import 'package:my_flutter_module/framework/repository/banner/model/response_posters.dart';
import 'package:my_flutter_module/framework/repository/banner/model/response_user_industry.dart';
import 'package:my_flutter_module/ui/widgets/app_toast.dart';

@injectable
class HomeController extends ChangeNotifier {
  final BannerRepository bannerRepository;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  HomeController(this.bannerRepository);

  Poster? poster;

  Future<void> updateUserPosterItem(Poster item) async {
    poster = item;
    notifyListeners();
  }

  /*
  /// ---------------------------- Api Integration ---------------------------------///
   */

  ///Progress Indicator
  bool isLoading = false;
  bool isError = false;
  String errorMsg = "";

  /// Get Poster Api
  ResponsePosters? responsePosters;
  List<Poster>? posters = [];
  List<GlobalKey> globalKeys = [];

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
        //String userShop= await HiveProvider.get(LocalConst.userShopName)??"Demo Sagar";
        //shopName=userShop.toUpperCase();
        isLoading = false;
        isError = false;
        posters = responsePosters!.data!.banners;
        globalKeys.addAll(responsePosters!.data!.banners!.map((e) => GlobalKey()).toList());
      } else {
        isError = true;
        isLoading = false;
        errorMsg = responsePosters!.respDesc!;
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

  ResponseFaq? responseFaq;
  List<FaqItem>? faq = [];

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

    ApiResult apiResult = await bannerRepository.getFaq();
    apiResult.when(success: (data) async {
      ResponseFaq item = data as ResponseFaq;
      responseFaq = item;
      if (responseFaq!.respCode == "200") {
        isLoading = false;
        isError = false;
        if (responseFaq!.data!.faq!.isNotEmpty) {
          faq = responseFaq!.data!.faq;
        }
      } else {
        isError = true;
        errorMsg = responseFaq!.respDesc!;
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

  Future<Uint8List> captureWidget(GlobalKey globalKey) async {
    final RenderRepaintBoundary boundary = globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    final ui.Image image = await boundary.toImage(pixelRatio: 5);
    final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List pngBytes = byteData!.buffer.asUint8List();
    return pngBytes;
  }

  Future<void> downloadImage(int index) async {
    print(globalKeys.length);
    try {
      Uint8List bytes = await captureWidget(this.globalKeys[index]);
      String base64String = base64Encode(bytes);

      String shareType = "download";
      // js.context.callMethod("DownloadBanner", [base64String, posters![index].fileName, shareType]);
      ///todo download functionality
    } catch (e) {
      print("...error at share...$e");
    }

    /*  try{
      final Uint8List byteImage   = await captureWidget(this.globalKeys[index]);
      AppDownloader.downloadImageFromBytesUnknown(byteImage, this.posters![index].fileName!);

    }catch(e){
    print(e);
    }*/
  }

  void onShare(int i) async {
    try {
      Uint8List bytes = await captureWidget(this.globalKeys[i]);
      String base64String = base64Encode(bytes);
      String shareType = "wats";
      // js.context.callMethod("DownloadBanner", [base64String,posters![i].fileName, shareType]);
      ///todo download functionality
      print("we reached share");
    } catch (e) {
      print("...error at share...$e");
    }
  }

  Future<void> deleteOffer(int i, BuildContext context) async {
    ApiResult apiResult = await bannerRepository.deleteBanner(posters![i].bannersId ?? 0);
    isLoading = true;
    notifyListeners();

    apiResult.when(success: (data) async {
      if (responsePosters!.respCode == "200") {
        //String userShop= await HiveProvider.get(LocalConst.userShopName)??"Demo Sagar";
        //shopName=userShop.toUpperCase();
        isLoading = false;
        isError = false;
        AppToast.showSnackBar("Prachar Banner Delete Successfully", ScaffoldMessenger.of(context));
      } else {
        isError = true;
        isLoading = false;
        errorMsg = responsePosters!.respDesc!;
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

    posters!.clear();
    getPosterList();
    notifyListeners();
  }

  void _showErrorSnackbar(String message, BuildContext buildContext) {
    ScaffoldMessenger.of(buildContext).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }
}
