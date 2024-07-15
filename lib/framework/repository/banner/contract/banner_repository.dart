import 'package:dio/dio.dart';
import 'package:my_flutter_module/framework/repository/banner/model/request_edit_address.dart';
import 'package:my_flutter_module/framework/repository/banner/model/request_edit_poster.dart';
import 'package:my_flutter_module/framework/repository/banner/model/request_offer_text.dart';
import 'package:my_flutter_module/framework/repository/banner/model/request_offers_by_industry.dart';
import 'package:my_flutter_module/framework/repository/banner/model/request_save_banner.dart';
import 'package:my_flutter_module/framework/repository/banner/model/request_save_poster.dart';
import 'package:my_flutter_module/framework/repository/banner/model/request_update_banner.dart';

abstract class BannerRepository {
  Future getOffersByIndustry(RequestOffersByIndustry requestOffersByIndustry);

  Future saveBanner(RequestSaveBanner requestSaveBanner);

  Future getBannerList();

  Future updateUserBanner(RequestUpdateBanner requestUpdateBanner);

  Future getUserIndustry();

  Future getOfferText(RequestOfferText requestOfferText);

  Future getUserImages();

  Future saveSharePoster(RequestSavePoster requestSavePoster);

  Future getPosterList();

  Future editPoster(RequestEditPoster requestEditPoster);

  Future uploadImage(FormData formData);

  Future editAddress(RequestEditAddress requestEditAddress);

  Future deleteBanner(int id);

  Future getFaq();
}
