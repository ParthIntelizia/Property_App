// To parse this JSON data, do
//
//     final serviceModel = serviceModelFromJson(jsonString);

import 'dart:convert';

class OTPResponseModel {
  OTPResponseModel({
    this.otp,
    this.status
  });

  String? otp;
  String? status;


  factory OTPResponseModel.fromJson(Map<String, dynamic> json) => OTPResponseModel(
    otp: json["otp"].toString(),
    status: json["status"]
  );

  Map<String, dynamic> toJson() => {
    "otp": otp,
    "status": status
  };
}
