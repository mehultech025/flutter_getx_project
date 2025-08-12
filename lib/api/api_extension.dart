
import 'package:flutter_getx_project/api/api_urls.dart';

Map<String, String> requestHeader() {
  return {
    "Content-Type": "application/json",
    "x-api-key": ApiUrls.apiKey
  };
}
