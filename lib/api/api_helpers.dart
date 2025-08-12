import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter_getx_project/api/api_exception.dart';
import 'package:flutter_getx_project/api/api_extension.dart';
import 'package:flutter_getx_project/constant/app_strings.dart';
import 'package:flutter_getx_project/models/response_item.dart';
import 'package:http/http.dart' as http;


class BaseApiHelper {

  /// Post
  static Future<ResponseItem> postRequest(
      String requestUrl, Map<String, dynamic> requestData) async {
    return await http
        .post(Uri.parse(requestUrl),
            body: json.encode(requestData),
            headers: requestHeader())
        .then((response) => onValue(response))
        .onError((error, stackTrace) => onError(error));
  }

  /// Get
  static Future<dynamic> getRequest(
      String requestUrl, {
        Map<String, dynamic>? queryParams,
      }) async {
    // Build full URL with query parameters
    final uri = Uri.parse(requestUrl).replace(queryParameters: queryParams);

    return await http
        .get(uri, headers: requestHeader())
        .then((response) => onValue(response))
        .onError((error, stackTrace) => onError(error));
  }



  /// On Value
  static Future<ResponseItem> onValue(http.Response response) async {
    final ResponseItem result =
        ResponseItem(status: false, message: AppStrings.somethingWrongTextKey);

    dynamic data = json.decode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      result.status = true;
      result.data = data;
      result.message = data["message"];
      result.statusCode = response.statusCode;
    } else if (response.statusCode == 400) {
      result.data = data;
      result.message = data["error"];
      result.statusCode = response.statusCode;
    } else {
      result.data = data;
      result.message = data["error"];
      result.statusCode = response.statusCode;
    }

    return result;
  }

  /// On Error
  static onError(error) {
    log("Error caused: $error");
    String message = AppStrings.unsuccessfulTextKey;
    if (error is SocketException) {
      message = ResponseException(AppStrings.noInternetTextKey).toString();
    } else if (error is FormatException) {
      message = ResponseException(AppStrings.somethingWrongTextKey).toString() +
          error.toString();
    }
    return ResponseItem(data: null, message: message, status: false);
  }
}
