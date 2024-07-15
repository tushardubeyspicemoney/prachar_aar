import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http_parser/http_parser.dart';
import 'package:injectable/injectable.dart';
import 'package:mime_type/mime_type.dart';
import 'package:my_flutter_module/framework/controller/home/home_provider.dart';
import 'package:my_flutter_module/framework/provider/network/api_result.dart';
import 'package:my_flutter_module/framework/provider/network/dio/error_response.dart';
import 'package:my_flutter_module/framework/provider/network/network_exceptions.dart';
import 'package:my_flutter_module/framework/repository/banner/contract/banner_repository.dart';
import 'package:my_flutter_module/framework/repository/banner/model/request_edit_poster.dart';
import 'package:my_flutter_module/framework/repository/banner/model/request_save_poster.dart';
import 'package:my_flutter_module/framework/repository/banner/model/response_image_upload.dart';
import 'package:my_flutter_module/framework/repository/banner/model/response_save_poster.dart';
import 'package:my_flutter_module/framework/repository/banner/model/response_user_images.dart';
import 'package:my_flutter_module/framework/repository/banner/model/response_user_industry.dart';
import 'package:my_flutter_module/ui/routing/navigation_stack_item.dart';
import 'package:my_flutter_module/ui/routing/stack.dart';
import 'package:my_flutter_module/ui/utils/const/app_constants.dart';
import 'package:my_flutter_module/ui/utils/theme/app_assets.dart';
import 'package:my_flutter_module/ui/widgets/app_toast.dart';

@injectable
class DesignController extends ChangeNotifier {
  final BannerRepository bannerRepository;

  DesignController(this.bannerRepository);

  ///Dispose Controller
  void disposeController({bool isNotify = false}) {
    isLoading = false;
    selectedImageIndex = 1;
    imageFormDevice = null;
    if (isNotify) {
      notifyListeners();
    }
  }

  ///Text Editing Controller
  TextEditingController bannerTitleTextController = TextEditingController();
  TextEditingController bannerSubTitleTextController = TextEditingController();

  ///Scroll
  final ScrollController imageListController = ScrollController();

  ///Scroll End
  Future<void> scrollEnd() async {
    imageListController.animateTo(
      imageListController.position.maxScrollExtent,
      duration: const Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
    );
  }

  File? imageFormDevice;

  ///Update Image
  updateImageFromDevice(File image) {
    imageFormDevice = image;
    notifyListeners();
  }

  ///Update title and sub title
  updateTitleAndSubTitle(String title, String subTitle) {
    bannerTitleTextController.text = title;
    bannerSubTitleTextController.text = subTitle;
    notifyListeners();
  }

  ///Update Selected Index
  Future<void> updateSelectedImageIndex(int index) async {
    selectedImageIndex = index;
    strDisplayImage = userImages![index]!.signedUrl!;
    strSelectedImage = userImages![index]!.url!;
    notifyListeners();
  }

  List<String> bottomBarWidgetList = [
    AppAssets.svgGallery,
    AppAssets.customImage1,
    AppAssets.customImage2,
    AppAssets.customImage3,
    AppAssets.customImage4
  ];

  ///Update Poster Item for Detail page and Share Page

  Poster? poster;

  Future<void> updateUserPosterItem(Poster item) async {
    poster = item;
    /*offerUpdateController.text=poster!.offerName!;
    strUpdateOfferText=poster!.offerName!;
    addressUpdateController.text=poster!.offerDesc!;
    strUpdateAddressLine=poster!.offerDesc!;
    strUpdateSelectedImage=poster!.imageUrl!;
    strDisplayUpdateImage=poster!.signedUrl!;*/
    notifyListeners();
  }

  /*
  /// ---------------------------- Api Integration ---------------------------------///
   */

  ///Progress Indicator
  bool isLoading = false;
  bool isError = false;
  String errorMsg = "";

  ResponseUserImages? responseUserImages;
  List<UserImage?>? userImages = [];

  int selectedImageIndex = 1;
  String strSelectedImage = "";
  String strDisplayImage = "";

  void updateLoadingStatus(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<void> getUserImages(bool isFromGalleryCamera, String? galleryCameraUrl) async {
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

        if (isFromGalleryCamera) {
          int updateImageIndex = 2;
          for (int i = 0; i < userImages!.length; i++) {
            if (galleryCameraUrl == userImages![i]!.url) {
              updateImageIndex = i;
            }
          }
          updateSelectedImageIndex(updateImageIndex);

          if (updateImageIndex > 4) {
            Timer(const Duration(seconds: 1), () async {
              await scrollEnd();
            });
          }
        } else {
          int defIndex = 2;
          for (int i = 0; i < userImages!.length; i++) {
            UserImage? item = userImages![i];
            if (item!.isDefault == 1) {
              defIndex = i;
            }
          }
          updateSelectedImageIndex(defIndex);
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

  /// Radio Work

  // Group Value for Radio Button.
  int id = 0;

  Future<void> updateUserRadio(int val) async {
    id = val;
    notifyListeners();
  }

  /// Save Poster Api

  ResponseSavePoster? responseSavePoster;

  Future<void> saveAndShare(WidgetRef ref, ScaffoldMessengerState state, bool isFromDashboard) async {
    isLoading = true;
    notifyListeners();

    RequestSavePoster requestSavePoster = RequestSavePoster(
        offerName: bannerTitleTextController.text,
        offerDesc: bannerSubTitleTextController.text,
        imageUrl: strSelectedImage,
        createFor: id.toString());

    ApiResult apiResult = await bannerRepository.saveSharePoster(requestSavePoster);
    apiResult.when(success: (data) async {
      ResponseSavePoster item = data as ResponseSavePoster;
      responseSavePoster = item;
      if (responseSavePoster!.respCode == "200") {
        isLoading = false;
        isError = false;
        AppToast.showSnackBar("Banner send for approval successfully", state);
        ref.watch(homeProvider).getPosterList();

        Poster item = Poster();
        item.signedUrl = responseSavePoster!.data!.banner!.signedUrl;
        item.imageUrl = responseSavePoster!.data!.banner!.imageUrl;
        item.bannersId = responseSavePoster!.data!.banner!.bannersId;
        item.offerName = responseSavePoster!.data!.banner!.offerName;
        item.offerDesc = responseSavePoster!.data!.banner!.offerDesc;
        item.fileName = responseSavePoster!.data!.banner!.fileName;

        if (isFromDashboard) {
          await ref.read(homeProvider).updateUserPosterItem(item);
          ref.read(navigationStackProvider).pushAndRemoveAll(const NavigationStackItem.home());
          //ref.read(navigationStackProvider).pushAll([const NavigationStackItem.home(),const NavigationStackItem.share()]);
          // ref.read(navigationStackProvider).push(const NavigationStackItem.share());
        } else {
          await ref.read(homeProvider).updateUserPosterItem(item);
          // ref.read(navigationStackProvider).pop();;
          // ref.read(navigationStackProvider).pop();;
          //
          // ref.read(navigationStackProvider).push(const NavigationStackItem.share());
          ref.read(navigationStackProvider).pushAndRemoveAll(const NavigationStackItem.home());
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

  /// Image From Gallery and Camera
  bool isErrorFileGallery = false;
  String errorMsgFileGallery = "";
  String galleryFileName = "";
  MultipartFile? fileUploadGallery;
  ResponseImageUpload? responseImageUpload;

  bool isLoadingFile = false;

  ///Edit

  ResponseSavePoster? resEditPoster;

  Future<void> editPoster(WidgetRef ref, ScaffoldMessengerState state, int? id) async {
    isLoading = true;
    notifyListeners();

    RequestEditPoster requestEditPoster = RequestEditPoster(
        offerName: bannerTitleTextController.text,
        offerDesc: bannerSubTitleTextController.text,
        imageUrl: strSelectedImage,
        bannerId: id.toString());

    ApiResult apiResult = await bannerRepository.editPoster(requestEditPoster);
    apiResult.when(success: (data) async {
      ResponseSavePoster item = data as ResponseSavePoster;
      resEditPoster = item;
      if (resEditPoster!.respCode == "200") {
        isLoading = false;
        isError = false;

        ref.watch(homeProvider).getPosterList();

        Poster item = Poster();
        item.imageUrl = resEditPoster!.data!.banner!.imageUrl;
        item.offerName = resEditPoster!.data!.banner!.offerName;
        item.offerDesc = resEditPoster!.data!.banner!.offerDesc;
        item.signedUrl = resEditPoster!.data!.banner!.signedUrl;

        await ref.read(homeProvider).updateUserPosterItem(item);

        ref.read(navigationStackProvider).pop();
        ;
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
}
