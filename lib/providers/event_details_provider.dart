import 'package:flutter/material.dart';
import 'package:luxepass/models/more_hotel_model.dart';



class EventDetailsProvider extends ChangeNotifier {

  List<MoreHotelModel>? allServices;


  EventDetailsProvider() {
    allServices = [
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






}
