import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../get_storage_services/get_storage_service.dart';

class CommonMethode {
  static SizedBox commonSizedBox({double? height, double? width}) {
    return SizedBox(height: height, width: width);
  }

  static likeFiledAdd() async {
    final equipmentCollection = FirebaseFirestore.instance
        .collection("All_User_Details")
        .doc(GetStorageServices.getToken());

    final docSnap = await equipmentCollection.get();
    List queue;
    try {
      queue = docSnap.get('list_of_like');
    } catch (e) {
      await FirebaseFirestore.instance
          .collection("All_User_Details")
          .doc(GetStorageServices.getToken())
          .set({"list_of_like": []});
    }
  }
}
