import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../get_storage_services/get_storage_service.dart';
import '../pages/set_profile_screen.dart';
import '../utils/navigator.dart';

class CommonMethode {
  static SizedBox commonSizedBox({double? height, double? width}) {
    return SizedBox(height: height, width: width);
  }

  static likeFiledAdd(BuildContext context) async {
    print('grehgrehgdrhd   ${GetStorageServices.getToken()}');
    final equipmentCollection = FirebaseFirestore.instance
        .collection("All_User_Details")
        .doc(GetStorageServices.getToken());

    final docSnap = await equipmentCollection.get();
    List queue;
    try {
      queue = docSnap.get('list_of_like');
      print('queue update app    ${queue}');
      try {
        var getDoc = FirebaseFirestore.instance
            .collection('All_User_Details')
            .doc(GetStorageServices.getToken());
        var fetchData = await getDoc.get();
        CommonMethode.setProfileAllDetails(
            uid: FirebaseAuth.instance.currentUser!.uid,
            emailOrMobile: fetchData['email_or_email'],
            fullName: fetchData['full_name'],
            imageUrl: fetchData['profile_image'],
            name: fetchData['user_name']);
      } catch (e) {
        Get.off(SetProfileScreen());
      }
      MyNavigator.goToHome(context);
    } catch (e) {
      try {
        await FirebaseFirestore.instance
            .collection("All_User_Details")
            .doc(GetStorageServices.getToken())
            .set({
          "list_of_like": [],
          'profile_image': '',
          'user_name': '',
          'is_Profile_check': true
        });
        Get.off(SetProfileScreen());
      } catch (e) {
        print('ERROR IN lIKE NULL LIST');
      }
    }
  }

  static setProfileAllDetails({
    required String imageUrl,
    required String name,
    required String fullName,
    required String emailOrMobile,
    required String uid,
  }) {
    GetStorageServices.setUserLoggedIn();
    GetStorageServices.setToken(uid);
    GetStorageServices.setProfileImageValue(imageUrl);
    GetStorageServices.setNameValue(name);
    GetStorageServices.setFullNameValue(fullName);
    GetStorageServices.setEmailOrMobileValue(emailOrMobile);
  }
}
