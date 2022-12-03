import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/common_widget.dart';
import '../constants/constant_colors.dart';
import '../constants/constant_widgets.dart';
import '../get_storage_services/get_storage_service.dart';
import 'authentication/signin.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  ConstWidgets constWidgets = ConstWidgets();

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _pastCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: Text(
          "About Us",
          style: GoogleFonts.urbanist(
              fontWeight: FontWeight.w700, fontSize: 20.0, color: Colors.black),
        ),
      ),
      body: ProgressHUD(
        child: Builder(
          builder: (context) {
            final progress = ProgressHUD.of(context);
            return Padding(
              padding: EdgeInsets.all(15.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CachedNetworkImage(
                      imageUrl:
                          "https://www.therightpropertycompany.co.uk/wp-content/uploads/2016/12/background-image-04.png",
                      height: 250,
                      width: double.infinity,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    constWidgets.textWidget(
                      "Buy or sell your house in\nfew seconds with us.",
                      FontWeight.w500,
                      20,
                      ConstColors.serviceHeadLineColor,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    constWidgets.textWidget(
                      "Buy or sell your house infew seconds with us.The Right Property Company is your local one stop shop for all your property needs.The Right Property Company has extensive experience and strict standards of quality and customer care to create a professional, yet personal residential lettings service that exceeded the expectations of landlords and tenants.Each of our branches are run by passionate, local property experts that operate out of eye-catching shopfronts on the high street. This means you’re getting the benefit of buying, selling and letting with a national brand, but you’re also benefiting from genuine local expertise and knowledge that cannot be learned through corporate training.",
                      FontWeight.w500,
                      16,
                      ConstColors.serviceHeadLineColor,
                    ),
                    // Text(
                    //   "Buy or sell your house infew seconds with us.The Right Property Company is your local one stop shop for all your property needs.The Right Property Company has extensive experience and strict standards of quality and customer care to create a professional, yet personal residential lettings service that exceeded the expectations of landlords and tenants.Each of our branches are run by passionate, local property experts that operate out of eye-catching shopfronts on the high street. This means you’re getting the benefit of buying, selling and letting with a national brand, but you’re also benefiting from genuine local expertise and knowledge that cannot be learned through corporate training.",
                    //   textScaleFactor: 1.1,
                    //   style: TextStyle(height: 1.5),
                    // ),
                    SizedBox(
                      height: 10,
                    ),
                    inputForm("heading", progress),
                    SizedBox(
                      height: 20,
                    ),
                    // Text(
                    //   "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of 'de Finibus Bonorum et Malorum' (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, 'Lorem ipsum dolor sit amet..', comes from a line in section 1.10.32.",
                    //   style: TextStyle(height: 1.5),
                    // ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget inputForm(String heading, final progress) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(top: 20.0),
          padding: const EdgeInsets.only(left: 15.0, right: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              constWidgets.textWidget(
                  "ALWAYS SUPPORT YOU", FontWeight.w500, 12, Colors.grey),
              SizedBox(
                height: 3,
              ),
              constWidgets.textWidget("HOW CAN WE HELP?", FontWeight.w500, 20,
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
                  constWidgets.textWidget(
                      "Full Name", FontWeight.w500, 16, Colors.black),
                  const SizedBox(height: 10.0),
                  TextField(
                    controller: _fullNameController,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(8.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: const BorderSide(
                                color: ConstColors.widgetDividerColor,
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
                    controller: _emailController,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(8.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: const BorderSide(
                                color: ConstColors.widgetDividerColor,
                                width: 1.0))),
                  )
                ],
              ),
              const SizedBox(height: 15.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  constWidgets.textWidget(
                      "Telephone no", FontWeight.w500, 16, Colors.black),
                  const SizedBox(height: 10.0),
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: _phoneController,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(8.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: const BorderSide(
                                color: ConstColors.widgetDividerColor,
                                width: 1.0))),
                  )
                ],
              ),
              const SizedBox(height: 15.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  constWidgets.textWidget(
                      "Postcode", FontWeight.w500, 16, Colors.black),
                  const SizedBox(height: 10.0),
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: _pastCodeController,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(8.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: const BorderSide(
                                color: ConstColors.widgetDividerColor,
                                width: 1.0))),
                  )
                ],
              ),
              const SizedBox(height: 15.0),
              Center(
                child: GestureDetector(
                  onTap: () async {
                    if (GetStorageServices.getUserLoggedInStatus() == true) {
                      if (_fullNameController.text.isNotEmpty &&
                          _emailController.text.isNotEmpty &&
                          _phoneController.text.isNotEmpty &&
                          _pastCodeController.text.isNotEmpty) {
                        bool emailValid = RegExp(
                                r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                            .hasMatch(_emailController.text.trim());
                        if (emailValid == true) {
                          await FirebaseFirestore.instance
                              .collection('Admin')
                              .doc('inquires_list')
                              .collection('get_a_free_valuation')
                              .add({
                            'to_sell & to_let': "Male",
                            'full_name': _fullNameController.text.toString(),
                            "email": _emailController.text.toString().trim(),
                            "phone_number": _phoneController.text.toString(),
                            "postcode": _pastCodeController.text,
                            "user_token": GetStorageServices.getToken(),
                            'crate_date': DateTime.now().toString()
                          });

                          CommonWidget.getSnackBar(
                              title: "Submitted!",
                              duration: 2,
                              message:
                                  'Your inquiry has been received, We will contact you shortly.');
                        } else {
                          CommonWidget.getSnackBar(
                              color: Colors.red,
                              duration: 2,
                              title: 'Invalid Email',
                              message: 'Please Enter Valid Email');
                        }

                        setState(() {});

                        progress.dismiss();
                      } else {
                        CommonWidget.getSnackBar(
                            color: Colors.red,
                            duration: 2,
                            title: 'required',
                            message: 'Please Enter all filed required');
                      }
                    } else {
                      Get.to(() => const SignInScreen());
                    }
                  },
                  child: Container(
                    height: 50,
                    width: 150,
                    margin: const EdgeInsets.only(top: 15.0),
                    decoration: const BoxDecoration(
                        color: ConstColors.darkColor,
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                    child: Center(
                      child: constWidgets.textWidget(
                          "Submit", FontWeight.w700, 13, Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
