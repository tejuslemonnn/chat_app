// To parse this JSON data, do
//
//     final contentModel = contentModelFromJson(jsonString);

import 'dart:convert';

UsersModel contentModelFromJson(String str) =>
    UsersModel.fromJson(json.decode(str));

String contentModelToJson(UsersModel data) => json.encode(data.toJson());

class UsersModel {
  UsersModel({
    this.uid,
    this.name,
    this.keyName,
    this.email,
    this.createdAt,
    this.lastSignIn,
    this.photoUrl,
    this.status,
    this.updatedAt,
    this.chats,
  });

  String? uid;
  String? name;
  String? keyName;
  String? email;
  String? createdAt;
  String? lastSignIn;
  String? photoUrl;
  String? status;
  String? updatedAt;
  List<Chat>? chats;

  factory UsersModel.fromJson(Map<String, dynamic> json) => UsersModel(
        uid: json["uid"],
        name: json["name"],
        keyName: json["keyName"],
        email: json["email"],
        createdAt: json["createdAt"],
        lastSignIn: json["lastSignIn"],
        photoUrl: json["photoUrl"],
        status: json["status"],
        updatedAt: json["updatedAt"],
        chats: List<Chat>.from(json["chats"].map((x) => Chat.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "keyName": keyName,
        "email": email,
        "createdAt": createdAt,
        "lastSignIn": lastSignIn,
        "photoUrl": photoUrl,
        "status": status,
        "updatedAt": updatedAt,
        "chats": List<dynamic>.from(chats!.map((x) => x.toJson())),
      };
}

class Chat {
  Chat({
    this.connection,
    this.chatId,
    this.lastTime,
    this.totalUnread,
  });

  String? connection;
  String? chatId;
  String? lastTime;
  int? totalUnread;

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        connection: json["connection"],
        chatId: json["chat_id"],
        lastTime: json["lastTime"],
        totalUnread: json["total_unread"],
      );

  Map<String, dynamic> toJson() => {
        "connection": connection,
        "chat_id": chatId,
        "lastTime": lastTime,
        "total_unread": totalUnread,
      };
}
