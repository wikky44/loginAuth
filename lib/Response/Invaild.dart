import 'dart:convert';

Invaild invaildFromJson(String str) => Invaild.fromJson(json.decode(str));
String invaildToJson(Invaild data) => json.encode(data.toJson());
class Invaild {
  Invaild({
      this.status, 
      this.message,});

  Invaild.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
  }
  String? status;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    return map;
  }

}