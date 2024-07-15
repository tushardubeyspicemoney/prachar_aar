import 'package:dio/dio.dart';
import 'package:my_flutter_module/framework/provider/local_storage/hive/hive_provider.dart';
import 'package:my_flutter_module/framework/provider/local_storage/local_const.dart';

class DioClient {
  final Dio _dio;

  DioClient(this._dio);

  /*
  * ----Get Method
  * */
  Future<dynamic> getData(String endpoint) async {
    try {
      String token = await HiveProvider.get(LocalConst.tokenData) ??
          "d22b8f665f9f1146e9ee8807d6b769769beca42decf53e1765aca96beb3fe304";
      String txtClientID = await HiveProvider.get(LocalConst.clientID) ?? "825";
      String aggId = await HiveProvider.get(LocalConst.agentID) ?? "109";
      String appLanguage = await HiveProvider.get(LocalConst.language) ?? "en";

      Response response = await _dio.get(
        endpoint,
        options: Options(
          headers: {"clientid": txtClientID, "aggid": aggId, "lang": appLanguage, "sessionid": token, "reqmode": "APP"},
        ),
      );

      /*Response response = await _dio.get(endpoint,options: Options(
        headers: {
          "clientid": "825",
          "aggid": "109",
          "lang": "en",
          "sessionid": "6929239aecf22ded128f95eea69486e7192dde57345c7f348bc84cf5223cd1a6",
          "reqmode": "APP"
        },
      ),);*/

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getDataInit(
      String endpoint, String tempToken, String aggId, String clientID, String appLanguage) async {
    try {
      Response response = await _dio.get(
        endpoint,
        options: Options(
          headers: {
            "clientid": clientID,
            "aggid": aggId,
            "lang": appLanguage,
            "sessionid": tempToken,
            "reqmode": "APP"
          },
        ),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /*
  * ----Post Method
  * */

  Future<dynamic> postJsonData({required String endpoint, required Map<String, dynamic> data}) async {
    try {
      String token = await HiveProvider.get(LocalConst.tokenData) ??
          "d22b8f665f9f1146e9ee8807d6b769769beca42decf53e1765aca96beb3fe304";
      String txtClientID = await HiveProvider.get(LocalConst.clientID) ?? "825";
      String aggId = await HiveProvider.get(LocalConst.agentID) ?? "109";
      String appLanguage = await HiveProvider.get(LocalConst.language) ?? "en";

      Response response = await _dio.post(endpoint,
          data: data,
          options: Options(
            headers: {
              "clientid": txtClientID,
              "aggid": aggId,
              "lang": appLanguage,
              "sessionid": token,
              "reqmode": "APP"
            },
          ));

      /*Response response = await _dio.post(endpoint,data: data,options: Options(
        headers: {
          "clientid": "825",
          "aggid": "109",
          "lang": "en",
          "sessionid": "6929239aecf22ded128f95eea69486e7192dde57345c7f348bc84cf5223cd1a6",
          "reqmode": "APP"
        },
      ));*/
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> postData(String endpoint, String data) async {
    try {
      String token = await HiveProvider.get(LocalConst.tokenData) ??
          "d22b8f665f9f1146e9ee8807d6b769769beca42decf53e1765aca96beb3fe304";
      String txtClientID = await HiveProvider.get(LocalConst.clientID) ?? "825";
      String aggId = await HiveProvider.get(LocalConst.agentID) ?? "109";
      String appLanguage = await HiveProvider.get(LocalConst.language) ?? "en";

      Response response = await _dio.post(endpoint,
          data: data,
          options: Options(
            headers: {
              "clientid": txtClientID,
              "aggid": aggId,
              "lang": appLanguage,
              "sessionid": token,
              "reqmode": "APP"
            },
          ));

      /*Response response = await _dio.post(endpoint,data: data,options: Options(
        headers: {
          "clientid": "825",
          "aggid": "109",
          "lang": "en",
          "sessionid": "6929239aecf22ded128f95eea69486e7192dde57345c7f348bc84cf5223cd1a6",
          "reqmode": "APP"
        },
      ));*/
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /*
  * ----Post without Header
  * */
  Future<dynamic> postDataVerifySession(String endpoint, String data) async {
    try {
      Response response = await _dio.post(endpoint, data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /*
  * ----Post Form Data
  * */
  Future<dynamic> postFormData(String endpoint, dynamic data) async {
    try {
      String token = await HiveProvider.get(LocalConst.tokenData) ??
          "d22b8f665f9f1146e9ee8807d6b769769beca42decf53e1765aca96beb3fe304";
      String txtClientID = await HiveProvider.get(LocalConst.clientID) ?? "825";
      String aggId = await HiveProvider.get(LocalConst.agentID) ?? "109";
      String appLanguage = await HiveProvider.get(LocalConst.language) ?? "en";

      Response response = await _dio.post(endpoint,
          data: data,
          options: Options(
            headers: {
              "clientid": txtClientID,
              "aggid": aggId,
              "lang": appLanguage,
              "sessionid": token,
              "reqmode": "APP"
            },
          ));
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
