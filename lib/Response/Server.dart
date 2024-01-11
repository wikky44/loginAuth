import 'dart:convert';

Server serverFromJson(String str) => Server.fromJson(json.decode(str));
String serverToJson(Server data) => json.encode(data.toJson());
class Server {
  Server({
      this.status, 
      this.message,});

  Server.fromJson(dynamic json) {
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