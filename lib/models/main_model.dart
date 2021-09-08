// To parse this JSON data, do
//
//     final mainModel = mainModelFromJson(jsonString);

import 'dart:convert';

List<MainModel> mainModelFromJson(String str) => List<MainModel>.from(json.decode(str).map((x) => MainModel.fromJson(x)));

String mainModelToJson(List<MainModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MainModel {
  MainModel({
    required this.id,
    required this.row,
    required this.seqNum,
    required this.text,
  });

  int id;
  String row;
  int seqNum;
  String text;

  factory MainModel.fromJson(Map<String, dynamic> json) => MainModel(
    id: json["id"] == null ? null : json["id"],
    row: json["row"] == null ? null : json["row"],
    seqNum: json["seq_num"] == null ? null : json["seq_num"],
    text: json["text"] == null ? null : json["text"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "row": row == null ? null : row,
    "seq_num": seqNum == null ? null : seqNum,
    "text": text == null ? null : text,
  };
}
