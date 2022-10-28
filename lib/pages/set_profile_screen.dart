import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:luxepass/constants/common_method.dart';
import '../../constants/constant_colors.dart';
import '../../models/CountryModel.dart';
import '../constants/common_widget.dart';
import '../constants/const_variables.dart';
import '../get_storage_services/get_storage_service.dart';
import 'authentication/my_location_page.dart';

class SetProfileScreen extends StatefulWidget {
  const SetProfileScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SetProfileScreenState();
  }
}

class _SetProfileScreenState extends State<SetProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  late CountryModel seletedCountry;
  String? liveImageURL;

  bool isSignIn = false;
  bool google = false;
  File? image;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: ConstColors.backgroundColor,
          body: _body()),
    );
  }

  Widget _body() {
    var width = MediaQuery.of(context).size.width;
    var safearea = MediaQuery.of(context).padding.top;

    return ProgressHUD(child: Builder(
      builder: (context) {
        final progress = ProgressHUD.of(context);

        return Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(ConstVar.backgroundImg), fit: BoxFit.cover),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
                child: Text(
                  "Profile",
                  style: GoogleFonts.urbanist(
                      fontWeight: FontWeight.w700,
                      fontSize: 26.0,
                      color: Colors.black),
                ),
              ),
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    height: 180,
                    width: 180,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.withOpacity(0.5)),
                    child: image == null
                        ? Icon(
                            color: Colors.grey,
                            Icons.person,
                            size: 120,
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(500),
                            child: Image.file(image!, fit: BoxFit.cover)),
                  ),
                  Positioned(
                    //bottom: 20,
                    right: 10,
                    child: CircleAvatar(
                        backgroundColor: ConstColors.darkColor,
                        child: IconButton(
                            onPressed: () {
                              showDialogWidget();
                            },
                            icon: Icon(
                              Icons.edit,
                              color: Colors.white,
                            ))),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: CommonWidget.textBoldWight500(text: 'User Name'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(8.0),
                      hintText: 'User Name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: const BorderSide(
                              color: ConstColors.widgetDividerColor,
                              width: 1.0))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: CommonWidget.textBoldWight500(text: 'Full Name'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: fullNameController,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(8.0),
                      hintText: 'Full Name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: const BorderSide(
                              color: ConstColors.widgetDividerColor,
                              width: 1.0))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: CommonWidget.textBoldWight500(text: 'Email'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(8.0),
                      hintText: 'Email',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: const BorderSide(
                              color: ConstColors.widgetDividerColor,
                              width: 1.0))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: CommonWidget.textBoldWight500(text: 'Mobile Number'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: mobileController,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(8.0),
                      hintText: 'Mobile Number',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: const BorderSide(
                              color: ConstColors.widgetDividerColor,
                              width: 1.0))),
                ),
              ),
              Spacer(),
              InkWell(
                onTap: () async {
                  print('enter thg escree ');

                  if (image != null &&
                      nameController.text.isNotEmpty &&
                      mobileController.text.isNotEmpty &&
                      fullNameController.text.isNotEmpty &&
                      emailController.text.isNotEmpty) {
                    try {
                      print('enter thg escree ');
                      progress!.show();
                      var snapshot = await FirebaseStorage.instance
                          .ref()
                          .child(
                              'AllUserImage/${DateTime.now().microsecondsSinceEpoch}')
                          .putFile(image!);
                      liveImageURL = await snapshot.ref.getDownloadURL();
                      await FirebaseFirestore.instance
                          .collection('All_User_Details')
                          .doc(GetStorageServices.getToken())
                          .update({
                        'profile_image': liveImageURL,
                        'user_name': nameController.text.toString(),
                        'is_Profile_check': true,
                        'email': emailController.text.toString(),
                        'mobile': mobileController.text.toString(),
                        'full_name': fullNameController.text.toString(),
                      });
                      CommonMethode.setProfileAllDetails(
                          mobile: mobileController.text.toString(),
                          fullName: fullNameController.text.toString(),
                          email: emailController.text.toString(),
                          imageUrl: liveImageURL!,
                          name: nameController.text.toString());
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyLocation()),
                        (Route<dynamic> route) => false,
                      );
                      progress.dismiss();
                    } catch (e) {
                      progress!.dismiss();

                      return CommonWidget.getSnackBar(
                          message: 'went-wrong',
                          title: 'Failed',
                          duration: 2,
                          color: Colors.red);
                    }
                  } else {
                    CommonWidget.getSnackBar(
                        message: 'Photo & Name are required',
                        title: 'required',
                        duration: 2,
                        color: Colors.red);
                  }
                },
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                      color: ConstColors.darkColor,
                      borderRadius: BorderRadius.circular(10)),
                  margin: const EdgeInsets.all(10.0),
                  child: Center(
                    child: Text(
                      'Next',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        );
      },
    ));
  }

  imageUpload() async {
    var snapshot = await FirebaseStorage.instance
        .ref()
        .child('AllUserImage/${DateTime.now().microsecondsSinceEpoch}')
        .putFile(image!);
    liveImageURL = await snapshot.ref.getDownloadURL();
  }

  showDialogWidget() {
    return showDialog(
        context: context,
        builder: (_) => SimpleDialog(
              children: [
                Column(
                  children: [
                    InkWell(
                      onTap: () async {
                        Navigator.of(context).pop();
                        await imageFromGallery();
                      },
                      child: Container(
                        height: 40,
                        width: 160,
                        decoration: BoxDecoration(
                            color: ConstColors.darkColor,
                            borderRadius: BorderRadius.circular(16)),
                        margin: const EdgeInsets.all(10.0),
                        child: Center(
                          child: Text(
                            'Gallery',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        Navigator.of(context).pop();
                        await imageFromCamera();
                      },
                      child: Container(
                        height: 40,
                        width: 160,
                        decoration: BoxDecoration(
                            color: ConstColors.darkColor,
                            borderRadius: BorderRadius.circular(16)),
                        margin: const EdgeInsets.all(10.0),
                        child: Center(
                          child: Text(
                            'Camera',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ));
  }

  imageFromGallery() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickImage =
        await _picker.pickImage(source: ImageSource.gallery);
    image = File(pickImage!.path);
    setState(() {});
  }

  imageFromCamera() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickImage =
        await _picker.pickImage(source: ImageSource.camera);
    image = File(pickImage!.path);
    setState(() {});
  }
}
