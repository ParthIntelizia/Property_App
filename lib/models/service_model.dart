// To parse this JSON data, do
//
//     final serviceModel = serviceModelFromJson(jsonString);

import 'dart:convert';

List<List<ServiceModel>> serviceModelFromJson(String str) =>
    List<List<ServiceModel>>.from(json.decode(str).map((x) =>
        List<ServiceModel>.from(x.map((x) => ServiceModel.fromJson(x)))));

String serviceModelToJson(List<List<ServiceModel>> data) =>
    json.encode(List<dynamic>.from(
        data.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))));

class ServiceModel {
  ServiceModel({
    this.title,
    this.location,
    this.highlight1,
    this.highlight2,
    this.image,
    this.price,
    this.service,
  });

  String? title;
  String? location;
  String? highlight1;
  String? highlight2;
  String? image;
  int? price;
  String? service;

  factory ServiceModel.fromJson(Map<String, dynamic> json) => ServiceModel(
        title: json["title"],
        location: json["location"],
        highlight1: json["highlight1"],
        highlight2: json["highlight2"],
        image: json["image"],
        price: json["price"],
        service: json["service"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "location": location,
        "highlight1": highlight1,
        "highlight2": highlight2,
        "image": image,
        "price": price,
        "service": service,
      };
}
