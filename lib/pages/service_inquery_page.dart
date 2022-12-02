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
import 'package:cached_network_image/cached_network_image.dart';

class ServiceEnquiryPage extends StatefulWidget {
  final enquiryName;
  final int index;

  const ServiceEnquiryPage(
      {super.key, required this.enquiryName, required this.index});
  @override
  State<ServiceEnquiryPage> createState() => _ServiceEnquiryPageState();
}

class _ServiceEnquiryPageState extends State<ServiceEnquiryPage> {
  final TextEditingController _fullNameController1 = TextEditingController();
  final TextEditingController _emailController1 = TextEditingController();
  final TextEditingController _phoneController1 = TextEditingController();
  final TextEditingController _messageController1 = TextEditingController();

  ConstWidgets constWidgets = ConstWidgets();

  List services = [
    {
      'image':
          'https://www.therightpropertycompany.co.uk/wp-content/uploads/2017/02/fatmaghaly-1.png',
      'description':
          "Our sales teams are friendly, approachable, confident, highly motivated and dedicated to achieving the best possible results for you.\nWe have stayed at the forefront of estate agency by understanding the market through experience, local teams understanding regional knowledge, integrations of new technologies and through extensive staff training and development. We know what’s needed to make your property stand out from the crowd and sell.\nReal people working out of real branches\nLocal experts with outstanding knowledge of the property market in the Black Country and West Midlands\nConfident teams dedicated to achieving results\nAll your buying and selling services in one place including Mortgages, Conveyancing, Surveys and Valuations\nComprehensive property marketing"
    },
    {
      'image':
          'https://www.therightpropertycompany.co.uk/wp-content/uploads/2020/01/lettings.jpg',
      'description':
          "Our proven track record and experience in the lettings industry has resulted in managing a huge number of properties locally across the black country and beyond, catering for all different landlords requirements. We treat your home as our home ensuring an open and honest approach. As with all of our clients you will get the highest level of service with effective communication and regular inspections resulting in an effective investment."
    },
    {
      'image': 'https://www.sdlauctions.co.uk/search/',
      'description': "Auction"
    },
    {
      'image': 'https://www.speedconveyancing.co.uk/',
      'description': "Conveyancing",
    },
    {
      'image':
          'https://www.therightpropertycompany.co.uk/wp-content/uploads/2020/07/energy-efficiency-2.jpg',
      'description':
          "We provide residential and commercial EPC. All domestic and commercial buildings in the UK available to buy or rent must have an Energy Performance Certificate (EPC). If you own a home, getting an energy performance survey done could help you identify ways to save money on your energy bills and improve the comfort of your home.\nplease fill in the contact form below or give us a call on 01384 231999",
    },
    {
      'image':
          'https://www.therightpropertycompany.co.uk/wp-content/uploads/2020/05/build-a-house-4503738_1920-1024x769.jpg',
      'description':
          """" 'Everyone should have a place to call home'\nProviders of Supported Accommodation for Adults Facing Homelessness""",
    },
    {
      'image':
          'https://www.therightpropertycompany.co.uk/wp-content/uploads/2020/05/build-a-house-4503738_1920-1024x769.jpg',
      'description':
          "We can give you advice on the best mortgage products to suit you, and can recommend local and national solicitors to handle the legal process for you. Contact us on 01384 231999 or fill the contact form below and we will contact you. FIRST TIME BUYER, REMORTGAGE, BUY TO LET, RIGHT TO BUY\nFREE MORTGAGE CHECK\nYOUR HOME MAY BE REPOSSESSED IF YOU DO NOT KEEP UP REPAYMENTS ON YOUR MORTGAGE\nAll advice is provided by Armchair Mortgages who regulated by the FCA.\nFCA Number 612752",
    },
    {
      'image':
          'https://www.therightpropertycompany.co.uk/wp-content/uploads/2020/07/1.jpg',
      'description':
          "At The Right Property Company, we comprise a team of experienced, multi-skilled in house professionals that offer a range of services: including full electrical wiring, alarms, CCTV, fire alarm systems and electrical certificates, and the installation of new boilers, boiler replacement, and central heating services. Our staff are members of Checkatrade, Gas Safe, and a number of industry recognised and revered accreditations. You can rest assured you’ll be investing in the right degree of quality for your home.",
    },
    {
      'image':
          'https://www.therightpropertycompany.co.uk/wp-content/uploads/2020/02/6-months-or-1-year-visa-on-arrival-to-vietnam-for-uk-citizens-4.jpg',
      'description':
          "Property Inspection Report for your UK Visa and Immigration case.\nPrices start at £90 and price depends on location, We cover the whole of West Midlands and surrounding areas.\nYour  U.K. Visa specific property inspection report will be dispatched the next day as your inspection by first class post.\nNext Day Service Available\nCost £90",
    },
  ];

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
                          CachedNetworkImage(
                            imageUrl: services[widget.index]['image'],
                            height: 250,
                            width: double.infinity,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          constWidgets.textWidget(
                            "${services[widget.index]['description']}",
                            FontWeight.w500,
                            14,
                            ConstColors.serviceHeadLineColor,
                          ),
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
