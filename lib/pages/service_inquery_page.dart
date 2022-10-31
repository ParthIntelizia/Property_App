import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:get/get.dart';
import '../constants/common_widget.dart';
import '../constants/const_variables.dart';
import '../constants/constant_colors.dart';
import '../constants/constant_widgets.dart';
import '../get_storage_services/get_storage_service.dart';
import 'authentication/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ServiceEnquiryPage extends StatefulWidget {
  final enquiryName;

  const ServiceEnquiryPage({super.key, required this.enquiryName});
  @override
  State<ServiceEnquiryPage> createState() => _ServiceEnquiryPageState();
}

class _ServiceEnquiryPageState extends State<ServiceEnquiryPage> {
  final TextEditingController _fullNameController1 = TextEditingController();
  final TextEditingController _emailController1 = TextEditingController();
  final TextEditingController _phoneController1 = TextEditingController();
  final TextEditingController _messageController1 = TextEditingController();

  ConstWidgets constWidgets = ConstWidgets();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProgressHUD(child: Builder(
        builder: (context) {
          final progress = ProgressHUD.of(context);
          return Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(ConstVar.backgroundImg), fit: BoxFit.cover),
            ),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(Icons.arrow_back_ios),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(top: 20.0),
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          constWidgets.textWidget(
                              "${widget.enquiryName} Inquiry",
                              FontWeight.w500,
                              20,
                              ConstColors.serviceHeadLineColor),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              constWidgets.textWidget("Full Name",
                                  FontWeight.w500, 16, Colors.black),
                              const SizedBox(height: 10.0),
                              TextField(
                                controller: _fullNameController1,
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(8.0),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        borderSide: const BorderSide(
                                            color:
                                                ConstColors.widgetDividerColor,
                                            width: 1.0))),
                              )
                            ],
                          ),
                          const SizedBox(height: 15.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              constWidgets.textWidget(
                                  "Email", FontWeight.w500, 16, Colors.black),
                              const SizedBox(height: 10.0),
                              TextField(
                                controller: _emailController1,
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(8.0),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        borderSide: const BorderSide(
                                            color:
                                                ConstColors.widgetDividerColor,
                                            width: 1.0))),
                              )
                            ],
                          ),
                          const SizedBox(height: 15.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              constWidgets.textWidget("Telephone no",
                                  FontWeight.w500, 16, Colors.black),
                              const SizedBox(height: 10.0),
                              TextField(
                                keyboardType: TextInputType.number,
                                controller: _phoneController1,
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(8.0),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        borderSide: const BorderSide(
                                            color:
                                                ConstColors.widgetDividerColor,
                                            width: 1.0))),
                              )
                            ],
                          ),
                          const SizedBox(height: 15.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              constWidgets.textWidget(
                                  "Message", FontWeight.w500, 16, Colors.black),
                              const SizedBox(height: 10.0),
                              TextField(
                                maxLines: 5,
                                controller: _messageController1,
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(8.0),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        borderSide: const BorderSide(
                                            color:
                                                ConstColors.widgetDividerColor,
                                            width: 1.0))),
                              )
                            ],
                          ),
                          const SizedBox(height: 15.0),
                          Center(
                            child: GestureDetector(
                              onTap: () async {
                                if (GetStorageServices
                                        .getUserLoggedInStatus() ==
                                    true) {
                                  if (_fullNameController1.text.isNotEmpty &&
                                      _emailController1.text.isNotEmpty &&
                                      _phoneController1.text.isNotEmpty &&
                                      _messageController1.text.isNotEmpty) {
                                    bool emailValid = RegExp(
                                            r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                                        .hasMatch(
                                            _emailController1.text.trim());

                                    if (emailValid == true) {
                                      progress!.show();
                                      await FirebaseFirestore.instance
                                          .collection('Admin')
                                          .doc('inquires_list')
                                          .collection("inquiries")
                                          .add({
                                        'full_name': _fullNameController1.text
                                            .toString(),
                                        "email": _emailController1.text
                                            .toString()
                                            .trim(),
                                        "phone_number":
                                            _phoneController1.text.toString(),
                                        "message": _messageController1.text,
                                        "inquiryFor": widget.enquiryName,
                                        'uid':
                                            '${FirebaseAuth.instance.currentUser!.uid}'
                                      });
                                    } else {
                                      CommonWidget.getSnackBar(
                                          color: Colors.red,
                                          duration: 2,
                                          title: 'Invalid Email',
                                          message: 'Please Enter Valid Email');
                                    }
                                    progress!.dismiss();

                                    setState(() {});
                                    Get.back();
                                  } else {
                                    CommonWidget.getSnackBar(
                                        color: Colors.red,
                                        duration: 2,
                                        title: 'required',
                                        message:
                                            'Please Enter all filed required');
                                  }
                                } else {
                                  Get.to(() => const SignInScreen());
                                }
                              },
                              child: Container(
                                  height: 50,
                                  width: 100,
                                  margin: const EdgeInsets.only(top: 15.0),
                                  decoration: const BoxDecoration(
                                      color: ConstColors.darkColor,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(25))),
                                  child: Center(
                                    child: constWidgets.textWidget("Submit",
                                        FontWeight.w700, 12, Colors.white),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      )),
    );
  }
}
