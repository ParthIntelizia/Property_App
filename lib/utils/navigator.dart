import 'package:flutter/material.dart';

class MyNavigator {
  static void goToHome(BuildContext context) {
    Navigator.pushReplacementNamed(context, "/home");
  }

  static void goToSignIn(BuildContext context) {
    Navigator.popAndPushNamed(context, "/signin");
  }

  static void goToEmailEntryScreen(BuildContext context) {
    Navigator.pushReplacementNamed(context, "/emailEntryScreen");
  }

  static void goToLoading(BuildContext context) {
    Navigator.pushReplacementNamed(context, "/loading");
  }
  static void gotoSearchResultPage(BuildContext context){
    Navigator.pushReplacementNamed(context, "/searchResult");
  }
  static void goToEventDetailsScreen(BuildContext context){
    Navigator.pushNamed(context, "/eventDetailsScreen");
  }

  static void goToRegisterUserDetails(BuildContext context) {
    Navigator.popAndPushNamed(context, "/customerUserDetails");
  }

  static void goToBookingReviewPage(BuildContext context){
    Navigator.pushNamed(context, "/bookingReviewPage");
  }


}
