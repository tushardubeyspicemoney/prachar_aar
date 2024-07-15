import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:my_flutter_module/framework/provider/network/api_end_points.dart';
import 'package:my_flutter_module/framework/provider/network/api_result.dart';
import 'package:my_flutter_module/framework/provider/network/dio/dio_client.dart';
import 'package:my_flutter_module/framework/provider/network/network_exceptions.dart';
import 'package:my_flutter_module/framework/repository/introduction/contract/introduction_repository.dart';
import 'package:my_flutter_module/framework/repository/introduction/model/request_update_industry.dart';
import 'package:my_flutter_module/framework/repository/introduction/model/response_get_campaign.dart';
import 'package:my_flutter_module/framework/repository/introduction/model/response_industry_list.dart';
import 'package:my_flutter_module/framework/repository/introduction/model/response_update_industry.dart';

@LazySingleton(as: IntroductionRepository, env: ['debug', 'production'])
class IntroductionApiRepository implements IntroductionRepository {
  final DioClient apiClient;

  IntroductionApiRepository(this.apiClient);

  @override
  Future getCampaign() async {
    // TODO: implement getProduct
    try {
      final Response res = await apiClient.getData(ApiEndPoints.getCampaign);
      ResponseGetCampaign responseGetCampaign = responseGetCampaignFromJson(res.toString());
      return ApiResult.success(data: responseGetCampaign);
    } catch (e, s) {
      print(".....getCampaign......${e.toString()}");
      print(".....getCampaign......${s.toString()}");
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future getIndustryList() async {
    // TODO: implement getIndustryList
    try {
      final Response res = await apiClient.getData(ApiEndPoints.getIndustrylist);
      ResponseIndustryList responseIndustryList = responseIndustryListFromJson(res.toString());
      return ApiResult.success(data: responseIndustryList);
    } catch (e, s) {
      print(".....getIndustryList......${e.toString()}");
      print(".....getIndustryList......${s.toString()}");
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future getUpdateIndustry(RequestUpdateIndustry requestUpdateIndustry) async {
    // TODO: implement getUpdateIndustry
    try {
      String data = requestUpdateIndustryToJson(requestUpdateIndustry);
      final Response res = await apiClient.postData(ApiEndPoints.updateIndustry, data);
      ResponseUpdateIndustry responseUpdateIndustry = responseUpdateIndustryFromJson(res.toString());
      return ApiResult.success(data: responseUpdateIndustry);
    } catch (e, s) {
      print(".....responseUpdateIndustry......${e.toString()}");
      print(".....responseUpdateIndustry......${s.toString()}");
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }
}
