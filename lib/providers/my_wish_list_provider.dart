import 'package:flutter/material.dart';
import 'package:luxepass/models/wish_list_model.dart';



class MyWishListProvider extends ChangeNotifier {

  List<WishListItemModel>? allServices;


  MyWishListProvider() {
    allServices = [
      WishListItemModel(
          title: "Plaza Avenue",
          image: "assets/services/img1.jpg",
          location: " DLF Cyber City , Gurugram",
          rating: "4.0",
          review: "500",
          price: 3100,
          service: "Home"),

      WishListItemModel(
          title: "Plaza Permai",
          image: "assets/services/img2.jpg",
          location: " Dwarka sector-32 ,Delhi",
          rating: "4.5",
          review: "135",
          price: 5000,
          service: "Villa"),

      WishListItemModel(
          title: "Taj Vivan",
          image: "assets/services/img3.jpg",
          location: "Dwarka, Delhi",
          rating: "4.0",
          review: "235",
          price: 3100,
          service: "Villa"),
      WishListItemModel(
          title: "The Plaza",
          image: "assets/services/img4.jpg",
          location: "Noida city center",
          rating: "4.0",
          review: "235",
          price: 4000,
          service: "Villa"),

    ];
  }






}
