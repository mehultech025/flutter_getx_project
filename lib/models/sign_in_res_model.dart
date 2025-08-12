import 'dart:convert';
/// error : "Missing API key."
/// how_to_get_one : "https://reqres.in/signup"
/// token : "QpwL5tke4Pnpja7X4"

SignInResModel signInResModelFromJson(String str) => SignInResModel.fromJson(json.decode(str));
String signInResModelToJson(SignInResModel data) => json.encode(data.toJson());
class SignInResModel {
  SignInResModel({
      String? error, 
      String? howToGetOne, 
      String? token,}){
    _error = error;
    _howToGetOne = howToGetOne;
    _token = token;
}

  SignInResModel.fromJson(dynamic json) {
    _error = json['error'];
    _howToGetOne = json['how_to_get_one'];
    _token = json['token'];
  }
  String? _error;
  String? _howToGetOne;
  String? _token;
SignInResModel copyWith({  String? error,
  String? howToGetOne,
  String? token,
}) => SignInResModel(  error: error ?? _error,
  howToGetOne: howToGetOne ?? _howToGetOne,
  token: token ?? _token,
);
  String? get error => _error;
  String? get howToGetOne => _howToGetOne;
  String? get token => _token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    map['how_to_get_one'] = _howToGetOne;
    map['token'] = _token;
    return map;
  }

}