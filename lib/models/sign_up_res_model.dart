import 'dart:convert';
/// id : 4
/// token : "QpwL5tke4Pnpja7X4"

SignUpResModel signUpResModelFromJson(String str) => SignUpResModel.fromJson(json.decode(str));
String signUpResModelToJson(SignUpResModel data) => json.encode(data.toJson());
class SignUpResModel {
  SignUpResModel({
      num? id, 
      String? token,
    String? error,
  }){
    _id = id;
    _token = token;
    _error = error;
}

  SignUpResModel.fromJson(dynamic json) {
    _id = json['id'];
    _token = json['token'];
    _error = json['error'];
  }
  num? _id;
  String? _token;
  String? _error;
SignUpResModel copyWith({  num? id,
  String? token,
  String? error,
}) => SignUpResModel(  id: id ?? _id,
  token: token ?? _token,
  error: error ?? _error,
);
  num? get id => _id;
  String? get token => _token;
  String? get error => _error;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['token'] = _token;
    map['error'] = _error;
    return map;
  }

}