import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:my_flutter_module/framework/provider/network/api_end_points.dart';
import 'package:my_flutter_module/framework/provider/network/api_result.dart';
import 'package:my_flutter_module/framework/provider/network/dio/dio_client.dart';
import 'package:my_flutter_module/framework/provider/network/network_exceptions.dart';
import 'package:my_flutter_module/framework/repository/auth/contract/auth_repository.dart';
import 'package:my_flutter_module/framework/repository/auth/model/response_session_verify.dart';

@LazySingleton(as: AuthRepository, env: ['debug', 'production'])
class CreditApiRepository implements AuthRepository {
  final DioClient apiClient;

  CreditApiRepository(this.apiClient);

  @override
  Future verifySession(String tempToken, String aggId, String clientID, String appLanguage) async {
    try {
      final Response res =
          await apiClient.getDataInit(ApiEndPoints.apiVerifySession, tempToken, aggId, clientID, appLanguage);
      ResponseSessionVerify responseSession = responseSessionVerifyFromJson(res.toString());
      return ApiResult.success(data: responseSession);
    } catch (e, s) {
      print(".....e...verifySession..$e");
      print(".....s...verifySession..$s");
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }
}
