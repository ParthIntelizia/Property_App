// To parse this JSON data, do
//
//     final serviceModel = serviceModelFromJson(jsonString);

import 'dart:convert';

List<List<WishListItemModel>> serviceModelFromJson(String str) =>
    List<List<WishListItemModel>>.from(json.decode(str).map((x) =>
    List<WishListItemModel>.from(x.map((x) => WishListItemModel.fromJson(x)))));

String serviceModelToJson(List<List<WishListItemModel>> data) =>
    json.encode(List<dynamic>.from(
        data.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))));

class WishListItemModel {
  WishListItemModel({
    this.title,
    this.location,
    this.rating,
    this.review,
    this.image,
    this.price,
    this.service,
  });

  String? title;
  String? location;
  String? rating;
  String? review;
  String? image;
  int? price;
  String? service;

  factory WishListItemModel.fromJson(Map<String, dynamic> json) => WishListItemModel(
    title: json["title"],
    location: json["location"],
    rating: json["rating"],
    review: json["review"],
    image: json["image"],
    price: json["price"],
    service: json["service"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "location": location,
    "rating": rating,
    "review": review,
    "image": image,
    "price": price,
    "service": service,
  };
}
