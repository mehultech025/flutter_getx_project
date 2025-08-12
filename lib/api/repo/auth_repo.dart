



import 'package:flutter_getx_project/api/api_helpers.dart';
import 'package:flutter_getx_project/api/api_urls.dart';
import 'package:flutter_getx_project/models/response_item.dart';

class AuthRepo {
  /// Register
  static Future<ResponseItem> register({required Map<String, dynamic> body}) async {
    String requestUrl = ApiUrls.register;
    ResponseItem result = await BaseApiHelper.postRequest(requestUrl, body);
    return result;
  }


  /// Login
  static Future<ResponseItem> login({required Map<String, dynamic> body}) async {
    String requestUrl = ApiUrls.login;
    ResponseItem result = await BaseApiHelper.postRequest(requestUrl, body);
    return result;
  }

}
