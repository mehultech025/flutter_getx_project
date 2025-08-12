import 'package:flutter_getx_project/api/api_helpers.dart';
import 'package:flutter_getx_project/api/api_urls.dart';
import 'package:flutter_getx_project/models/response_item.dart';

class ProfileRepo {
  static Future<ResponseItem> profileList(
      {required Map<String,dynamic> body}) async {
    String url = ApiUrls.profile;
    ResponseItem result = await BaseApiHelper.getRequest(url,queryParams: body);
    return result;
  }

}