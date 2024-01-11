import 'Token.dart';
import 'UserData.dart';
import 'dart:convert';

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      this.token, 
      this.userData, 
      this.msg,});

  Data.fromJson(dynamic json) {
    token = json['token'] != null ? Token.fromJson(json['token']) : null;
    userData = json['user_data'] != null ? UserData.fromJson(json['user_data']) : null;
    msg = json['msg'];
  }
  Token? token;
  UserData? userData;
  String? msg;

    Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (token != null) {
      map['token'] = token?.toJson();
    }
    if (userData != null) {
      map['user_data'] = userData?.toJson();
    }
    map['msg'] = msg;
    return map;
  }
}