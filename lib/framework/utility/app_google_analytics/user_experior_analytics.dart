//@dart=2.16

// import 'package:user_experior/user_experior.dart';
import 'dart:convert';

class UserExpAnalytics {
  static void expLogEvent({required String event}) {
    try {
      // js.context.callMethod("experierCalled", [event, "", "1"]);
      //todo user experier
    } catch (e) {
      print(e);
    }
  }

  static void expLogStartTimerEvent({
    required String event,
    required String apiUrl,
    required String mainProcess,
    required String subProcess,
    required String method,
    required String body,
  }) {
    String eventDataStart = const JsonEncoder().convert(UserExpAnalytics.createExpReq(
      url: apiUrl,
      mainProcess: mainProcess,
      subProcess: subProcess,
      method: method,
      body: body,
    ));

    try {
      // js.context.callMethod("experierCalled", [event, eventDataStart, "2"]);
    } catch (e) {
      print(e);
    }
  }

  static void expLogEndTimerEvent({
    required String event,
    required String response,
    required String responseCode,
    required String responseStatus,
    required String responseDes,
  }) {
    String eventDataEnd = const JsonEncoder().convert(UserExpAnalytics.createExpRes(
      response: response,
      responseCode: responseCode,
      responseStatus: responseStatus,
      responseDes: responseDes,
    ));

    try {
      // js.context.callMethod("experierCalled", [event, eventDataEnd, "3"]);
    } catch (e) {
      print(e);
    }
  }

  static void expLogFailureEvent({
    required String event,
    required String response,
    required String errorCode,
    required String errorMessage,
  }) {
    String eventDataEnd = const JsonEncoder().convert(
        UserExpAnalytics.createExpFailed(response: response, errorCode: errorCode, errorMessage: errorMessage));

    try {
      // js.context.callMethod("experierCalled", [event, eventDataEnd, "3"]);
    } catch (e) {
      print(e);
    }
  }

  static Map<String, String> createExpReq({
    required String url,
    required String mainProcess,
    required String subProcess,
    required String method,
    required String body,
    String? headers,
  }) {
    return <String, String>{
      "request_url": url,
      "ue_process": mainProcess,
      "ue_sub_process": subProcess,
      "request_method": method,
      "request_body": method.toUpperCase() == "GET" ? "" : handleReqExp(body),
      "headers": headers ?? "",
    };
  }

  //
  static Map<String, String> createExpRes({
    required String response,
    String? responseDes,
    String? responseStatus,
    String? responseCode,
  }) {
    return <String, String>{
      "response": handleReqExp(response),
      "ue_api_status": responseStatus ?? "Success",
      "ue_response_code": responseCode ?? "200",
      "ue_response_code_desc": responseDes ?? "Fetch Response Successfully",
    };
  }

  //
  static Map<String, String> createExpFailed({
    required String response,
    required String errorCode,
    String? errorMessage,
  }) {
    return <String, String>{
      "response": handleReqExp(response),
      "ue_api_status": "Failure",
      "ue_response_code": errorCode,
      "ue_response_code_desc": errorMessage ?? "",
    };
  }

  static String handleReqExp(String? data) {
    try {
      if (data != null && data.isNotEmpty && data.length > 100) {
        data = data.substring(0, 100);
      }
    } catch (e) {}
    return data ?? "";
  }
}
