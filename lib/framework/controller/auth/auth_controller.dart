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
import 'package:my_flutter_module/framework/repository/auth/contract/auth_repository.dart';
import 'package:my_flutter_module/framework/repository/auth/model/response_session_verify.dart';
import 'package:my_flutter_module/ui/routing/params/product_params.dart';

@injectable
class AuthController extends ChangeNotifier {
  final AuthRepository authRepository;

  AuthController(this.authRepository);

  bool isLoading = false;
  bool isError = false;
  ResponseSessionVerify? responseSessionVerify;
  String errorMsg = "";
  String appLanguage = "";
  String tempToken = "";
  String udf1 = "";
  String clientID = "";
  String aggId = "";

  ProductParams? productParams = ProductParams(token: "");

  Future<void> updateProductParams({ProductParams? productParameters}) async {
    productParams = productParameters;
    appLanguage = productParameters!.lang;
    tempToken = productParameters.token;
    udf1 = productParameters.udf1;
    clientID = productParameters.clientId;
    aggId = productParameters.aggId;
    await HiveProvider.add(LocalConst.clientID, productParameters.clientId);
    await HiveProvider.add(LocalConst.agentID, productParameters.aggId);
    //await HiveProvider.add(LocalConst.language, "en");
    await HiveProvider.add(LocalConst.udf1, productParameters.udf1);
  }

  ///Verify Session Api
  Future<void> verifySession(WidgetRef ref, BuildContext context) async {
    isLoading = true;
    notifyListeners();

    ApiResult apiResult = await authRepository.verifySession(tempToken, aggId, clientID, "en");
    apiResult.when(success: (data) async {
      ResponseSessionVerify item = data as ResponseSessionVerify;
      responseSessionVerify = item;

      if (responseSessionVerify!.respStatus == "success" && responseSessionVerify!.respCode == "200") {
        await HiveProvider.add(LocalConst.tokenData, responseSessionVerify!.data!.sessionId);
        await ref.read(bannerProvider).getUserIndustry(ref, false);
        isLoading = false;
        isError = false;
      } else {
        isError = true;
        errorMsg = responseSessionVerify!.respDesc!;
      }
    }, failure: (NetworkExceptions error) {
      isLoading = false;
      isError = true;
      errorMsg = NetworkExceptions.getErrorMessage(error);
      error.whenOrNull(notFound: (String reason, Response? response) {
        ErrorResponse errorResponse = errorResponseFromJson(response.toString());
        errorMsg = errorResponse.respDesc!;
      });
    });
    notifyListeners();
  }
}
