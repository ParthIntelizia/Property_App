import 'package:flutter/material.dart';

import '../models/service_model.dart';
import '../models/wish_list_model.dart';

class HomeProvider extends ChangeNotifier {
  ServiceModel? service;
  List<List<ServiceModel>>? allServices;

  List<WishListItemModel>? recomendedService;
  HomeProvider() {
    allServices = [
      [
        ServiceModel(
            title: "3 Bed Detached House",
            image: "assets/services/img2.jpg",
            location: "Roseate House, Delhi",
            highlight1: "Breakfast Included",
            highlight2: "Use of hammocks and spa",
            price: 7500,
            service: "Home"),
        ServiceModel(
            title: "2 Bed Flat to Rent",
            image: "assets/services/img3.jpg",
            location: "Jaypee Vasant Continental, Delhi",
            highlight1: "Spa circuit, 1 hour long",
            highlight2: "Natural infusion (hot or cold)",
            price: 1699,
            service: "Apartment"),
        ServiceModel(
            title: "3 Bed Detached House",
            image: "assets/services/img4.jpg",
            location: "Roseate House, Delhi",
            highlight1: "Breakfast Included",
            highlight2: "Use of hammocks and spa",
            price: 7500,
            service: "Home"),
        ServiceModel(
            title: "2 Bed Flat to Rent",
            image: "assets/services/img5.jpg",
            location: "Jaypee Vasant Continental, Delhi",
            highlight1: "Spa circuit, 1 hour long",
            highlight2: "Natural infusion (hot or cold)",
            price: 1699,
            service: "Apartment"),
      ],
    ];

    recomendedService=[
      WishListItemModel(
          title: "Plaza Avenue",
          image: "assets/services/img6.jpg",
          location: " Delhi India",
          rating: "4.0",
          review: "500",
          price: 1699,
          service: "Home"),
      WishListItemModel(
          title: "3 Bed House",
          image: "assets/login_corosal_img/img2.jpg",
          location: " Delhi India",
          rating: "4.0",
          review: "500",
          price: 1699,
          service: "Home"),
      WishListItemModel(
          title: "2 Bed Flat",
          image: "assets/services/img1.jpg",
          location: " Gurugram  India",
          rating: "4.0",
          review: "500",
          price: 1699,
          service: "Home"),
    ];

  }
}
