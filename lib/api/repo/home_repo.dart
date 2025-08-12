
import 'package:flutter_getx_project/api/api_helpers.dart';
import 'package:flutter_getx_project/api/api_urls.dart';
import 'package:flutter_getx_project/models/response_item.dart';

class HomeRepo {
  static Future<ResponseItem> homeList(
      {required Map<String,dynamic> body}) async {
    String url = ApiUrls.home;
    ResponseItem result = await BaseApiHelper.getRequest(url,queryParams: body);
    return result;
  }


}