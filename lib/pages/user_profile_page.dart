import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:luxepass/constants/const_variables.dart';
import 'package:luxepass/get_storage_services/get_storage_service.dart';
import 'package:luxepass/providers/my_booking_provider.dart';
import 'package:provider/provider.dart';
import '../../constants/constant_colors.dart';
import '../../constants/constant_widgets.dart';
import '../providers/navbar_provider.dart';
import '../services/locator_service.dart';
import 'authentication/signin.dart';
import 'package:get/get.dart';

import 'edit_profile_screen.dart';
import 'my_inquiry_screen.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);
  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage>
    with SingleTickerProviderStateMixin {
  ConstWidgets constWidgets = ConstWidgets();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: ConstColors.backgroundColor,
      body: _body(),
    ));
  }

  Widget _body() {
    MyBookingProvider myBookingProvider =
        Provider.of<MyBookingProvider>(context);
    var width = MediaQuery.of(context).size.width;
    var safearea = MediaQuery.of(context).padding.top;

    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(ConstVar.backgroundImg), fit: BoxFit.cover),
      ),
      child: NestedScrollView(
        headerSliverBuilder: (context, value) {
          return [
            SliverToBoxAdapter(
                child: Container(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              width: width,
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  constWidgets.textWidget(
                      "Profile ", FontWeight.w600, 20, Colors.black),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.more_vert,
                        size: 20.0,
                        color: ConstColors.lightColor,
                      ))
                ],
              ),
            )),
            SliverToBoxAdapter(
                child: Column(
              children: [
                SizedBox(
                  height: safearea,
                ),
                SizedBox(
                  width: width,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GetStorageServices.getProfileImageValue() == null
                          ? CircleAvatar(
                              minRadius: 26,
                              maxRadius: 26,
                              backgroundColor: Colors.grey.withOpacity(0.5),
                              child: Icon(
                                Icons.person,
                                color: Colors.grey,
                              ),
                            )
                          : Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(shape: BoxShape.circle),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(300),
                                child: Image.network(
                                    '${GetStorageServices.getProfileImageValue()}',
                                    fit: BoxFit.cover),
                              ),
                            ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, top: 2),
                        child: constWidgets.textWidget(
                            "${GetStorageServices.getNameValue() ?? ''}",
                            FontWeight.w600,
                            20,
                            ConstColors.userTitleColor),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    height: 1,
                    width: MediaQuery.of(context).size.width,
                    color: ConstColors.widgetDividerColor,
                  ),
                ),
              ],
            )),
          ];
        },
        body: _descriptionWidget(),
      ),
    );
  }

  Widget _descriptionWidget() {
    MyBookingProvider myBookingProvider =
        Provider.of<MyBookingProvider>(context, listen: false);
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              width: MediaQuery.of(context).size.width - 30,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    onTap: () {
                      if (GetStorageServices.getUserLoggedInStatus() == true) {
                        Get.to(() => EditProfileScreen());
                      } else {
                        Get.to(() => SignInScreen());
                      }
                    },
                    leading: const Icon(
                      Icons.person,
                      color: ConstColors.darkColor,
                      size: 20,
                    ),
                    title: constWidgets.textWidget(
                        "Personal Data", FontWeight.w400, 14, Colors.black),
                    trailing: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.grey,
                      size: 16,
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      if (GetStorageServices.getUserLoggedInStatus() == true) {
                        Get.to(() => MyInquiryScreen());
                      } else {
                        Get.to(() => SignInScreen());
                      }
                    },
                    leading: const Icon(
                      Icons.settings,
                      color: ConstColors.lightColor,
                      size: 20,
                    ),
                    title: constWidgets.textWidget(
                        "My Inquiries", FontWeight.w400, 14, Colors.black),
                    trailing: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.grey,
                      size: 16,
                    ),
                  ),
                  // ListTile(
                  //   leading: const Icon(
                  //     Icons.notifications,
                  //     color: ConstColors.darkColor,
                  //     size: 20,
                  //   ),
                  //   title: constWidgets.textWidget(
                  //       "Notification", FontWeight.w400, 14, Colors.black),
                  //   trailing: const Icon(
                  //     Icons.arrow_forward_ios_rounded,
                  //     color: Colors.grey,
                  //     size: 16,
                  //   ),
                  // ),
                  ListTile(
                    leading: const Icon(
                      Icons.privacy_tip_rounded,
                      color: ConstColors.darkColor,
                      size: 20,
                    ),
                    title: constWidgets.textWidget("Privacy and Policy",
                        FontWeight.w400, 14, Colors.black),
                    trailing: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.grey,
                      size: 16,
                    ),
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.info,
                      color: ConstColors.darkColor,
                      size: 20,
                    ),
                    title: constWidgets.textWidget(
                        "About Us", FontWeight.w400, 14, Colors.black),
                    trailing: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.grey,
                      size: 16,
                    ),
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.chat_bubble_outlined,
                      color: ConstColors.darkColor,
                      size: 20,
                    ),
                    title: constWidgets.textWidget(
                        "FAQ", FontWeight.w400, 14, Colors.black),
                    trailing: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.grey,
                      size: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    logOut();
                  },
                  child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width - 30,
                      margin: const EdgeInsets.only(top: 15.0),
                      decoration: const BoxDecoration(
                          color: ConstColors.lightColor,
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      child: Center(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              constWidgets.textWidget(
                                  "Logout", FontWeight.w700, 18, Colors.white),
                            ]),
                      )),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20.0, top: 10.0),
                  child: constWidgets.textWidget(
                      "Version:2.41", FontWeight.w400, 12, Colors.grey),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }

  logOut() async {
    try {
      FacebookAuth.instance.logOut();
    } catch (e) {}
    GetStorageServices.clearStorage();
    await FirebaseAuth.instance.signOut();

    locator<NavBarIndex>().setTabCount(0);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const SignInScreen()));
  }
}
