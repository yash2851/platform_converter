import 'dart:convert';

ChatModel chatModelFromJson(String str) => ChatModel.fromJson(json.decode(str));

String chatModelToJson(ChatModel data) => json.encode(data.toJson());

class ChatModel {
  String id;
  String image;
  String name;
  String phone;
  String msg;
  String date;
  String time;

  ChatModel({
    required this.id,
    required this.image,
    required this.name,
    required this.phone,
    required this.msg,
    required this.date,
    required this.time,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        id: json["id"],
        image: json["image"],
        name: json["name"],
        phone: json["phone"],
        msg: json["msg"],
        date: json["date"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "name": name,
        "phone": phone,
        "msg": msg,
        "date": date,
        "time": time,
      };
}

List<ChatModel> chatmodel = [];
