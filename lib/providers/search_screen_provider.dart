import 'package:flutter/material.dart';
import 'package:luxepass/models/more_hotel_model.dart';

import '../models/service_model.dart';

class SearchScreenProvider extends ChangeNotifier {
  String selectedDate = "";
  String selectedAdults = "00";
  String selectedChildren = "00";
  String selectedCity = "";
  String selectedAmenities = "";

  bool isEdit=false;

  TextEditingController dateSelectedController = TextEditingController();


  List<ServiceModel>? allServices;

  List<MoreHotelModel>? suggestedHotelList;


  SearchScreenProvider() {
    allServices = [
      ServiceModel(
          title: "Spa 60 Min & Spa Circuit 90 Min",
          image: "assets/services/img2.jpg",
          location: "Roseate House, Delhi",
          highlight1: "Breakfast Included",
          highlight2: "Use of hammocks and spa",
          price: 1699,
          service: "💆‍♀️ Spa"),
      ServiceModel(
          title: "Spa 60 Min & Spa Circuit 90 Min",
          image: "assets/services/img2.jpg",
          location: "Roseate House, Delhi",
          highlight1: "Breakfast Included",
          highlight2: "Use of hammocks and spa",
          price: 1699,
          service: "💆‍♀️ Spa"),
      ServiceModel(
          title: "Spa 60 Min & Spa Circuit 90 Min",
          image: "assets/services/img2.jpg",
          location: "Roseate House, Delhi",
          highlight1: "Breakfast Included",
          highlight2: "Use of hammocks and spa",
          price: 1699,
          service: "💆‍♀️ Spa"),
      ServiceModel(
          title: "Spa 60 Min & Spa Circuit 90 Min",
          image: "assets/services/img2.jpg",
          location: "Roseate House, Delhi",
          highlight1: "Breakfast Included",
          highlight2: "Use of hammocks and spa",
          price: 1699,
          service: "💆‍♀️ Spa"),
      ServiceModel(
          title: "Spa 60 Min & Spa Circuit 90 Min",
          image: "assets/services/img2.jpg",
          location: "Roseate House, Delhi",
          highlight1: "Breakfast Included",
          highlight2: "Use of hammocks and spa",
          price: 1699,
          service: "💆‍♀️ Spa"),
    ];


    suggestedHotelList = [
      MoreHotelModel(
          title: "Radisson Udhyog Vihar",
          image: "assets/login_corosal_img/img1.jpg",
          location: " Delhi India",
          rating: "4.0",
          review: "500",
          price: 1699,
          service: "💆‍♀️ Spa"),

      MoreHotelModel(
          title: "Pride Plaza",
          image: "assets/login_corosal_img/img2.jpg",
          location: " Delhi India",
          rating: "4.5",
          review: "135",
          price: 1699,
          service: "💆‍♀️ Spa"),

      MoreHotelModel(
          title: "Taj Vivan",
          image: "assets/login_corosal_img/img3.jpg",
          location: "Dwarka, Delhi",
          rating: "4.0",
          review: "235",
          price: 1699,
          service: "💆‍♀️ Spa"),

    ];

  }


  void selectCity(String city) {
    selectedCity = city;
    notifyListeners();
  }

  void selectAmenities(String amenity) {
    selectedAmenities = amenity;
    notifyListeners();
  }

  void selectDate(String date) {
    selectedDate = date;
    dateSelectedController.text = date;
    notifyListeners();
  }

  void selectAdults(String adults) {
    selectedAdults = adults;
    notifyListeners();
  }

  void selectChildren(String children) {
    selectedChildren = children;
    notifyListeners();
  }

  void setEditTrue(){
    isEdit=!isEdit;
    notifyListeners();
  }

  void clearAll() {
    selectedDate = "";
    selectedAdults = "00";
    selectedChildren = "00";
    selectedCity = "";
    selectedAmenities = "";
    dateSelectedController.text = "";
    notifyListeners();
  }



}
