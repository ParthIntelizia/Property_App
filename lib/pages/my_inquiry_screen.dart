import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:luxepass/constants/constant.dart';
import 'package:get/get.dart';
import 'package:luxepass/get_storage_services/get_storage_service.dart';
import '../constants/common_widget.dart';
import '../utils/inquiry_shimmer.dart';

class MyInquiryScreen extends StatefulWidget {
  const MyInquiryScreen({Key? key}) : super(key: key);

  @override
  State<MyInquiryScreen> createState() => _MyInquiryScreenState();
}

class _MyInquiryScreenState extends State<MyInquiryScreen>
    with SingleTickerProviderStateMixin {
  String searchText = '';

  TextEditingController searchController = TextEditingController();

  TabController? tabController;

  List<String> items = [
    'Service Inquiry',
    'Valuation Inquiries',
    'Mortgage Check',
  ];

  int selected = 0;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints:
              BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  title: Text(
                    "My Inquiries",
                    style: TextStyle(color: Colors.black),
                  ),
                  centerTitle: true,
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ),
                CommonWidget.commonSizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: TabBar(
                    isScrollable: true,
                    labelPadding: EdgeInsets.only(right: 13),
                    physics: BouncingScrollPhysics(),
                    indicator:
                        UnderlineTabIndicator(borderSide: BorderSide.none),
                    controller: tabController,
                    onTap: (value) {
                      setState(() {
                        selected = value;
                      });
                    },
                    tabs: List.generate(
                      items.length,
                      (index) => Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                          color: selected == index
                              ? Color(0xff26416B)
                              : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            items[index],
                            style: TextStyle(
                                color: selected == index
                                    ? Colors.white
                                    : Colors.grey),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      serviceInquiry(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 20, top: 20),
                            child: CommonWidget.textBoldWight700(
                                text: 'Service Inquiries', fontSize: 15),
                          ),
                          CommonWidget.commonSizedBox(height: 20),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  propertyInquiry(),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 20, top: 20),
                            child: CommonWidget.textBoldWight700(
                                text: 'Mortgage Check', fontSize: 15),
                          ),
                          CommonWidget.commonSizedBox(height: 20),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  mortgageCheck(),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column serviceInquiry() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20, top: 20),
          child: CommonWidget.textBoldWight700(
              text: 'Valuation Inquiries', fontSize: 15),
        ),
        CommonWidget.commonSizedBox(height: 20),
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Admin')
              .doc('inquires_list')
              .collection('inquiries')
              .where('uid', isEqualTo: GetStorageServices.getToken())
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              List<DocumentSnapshot> inquiries = snapshot.data!.docs;
              print("length======>${inquiries.length}");
              if (searchText.isNotEmpty) {
                inquiries = inquiries.where((element) {
                  return element
                      .get('inquiryFor')
                      .toString()
                      .toLowerCase()
                      .contains(searchText.toLowerCase());
                }).toList();
              }
              if (snapshot.data!.docs.length != 0) {
                return ListView.builder(
                  padding: EdgeInsets.only(left: 20),
                  shrinkWrap: true,
                  itemCount: inquiries.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Card(
                            child: ExpansionTile(
                              title: Text(inquiries[index]['full_name']),
                              subtitle: Text(inquiries[index]['inquiryFor']),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          CommonWidget.textBoldWight500(
                                              text: "Phone No: ",
                                              color: themColors309D9D),
                                          Text(
                                              inquiries[index]['phone_number']),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          CommonWidget.textBoldWight500(
                                              text: "Message: ",
                                              color: themColors309D9D),
                                          Text(inquiries[index]['message']),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              } else {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: Get.height / 3,
                      ),
                      CommonWidget.textBoldWight500(
                          text: "No Inquiry Found", color: themColors309D9D),
                    ],
                  ),
                );
              }
            } else {
              return InquiryShimmer();
            }
          },
        ),
      ],
    );
  }

  StreamBuilder<QuerySnapshot<Object?>> propertyInquiry() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Admin')
          .doc('inquires_list')
          .collection('get_a_free_valuation')
          .where('user_token', isEqualTo: GetStorageServices.getToken())
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          List<DocumentSnapshot> inquiries = snapshot.data!.docs;
          print("length======>${inquiries.length}");
          if (searchText.isNotEmpty) {
            inquiries = inquiries.where((element) {
              return element
                  .get('full_name')
                  .toString()
                  .toLowerCase()
                  .contains(searchText.toLowerCase());
            }).toList();
          }
          if (snapshot.data!.docs.length != 0) {
            return ListView.builder(
              padding: EdgeInsets.only(left: 20),
              shrinkWrap: true,
              itemCount: inquiries.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        child: ExpansionTile(
                          title: Text(inquiries[index]['full_name']),
                          subtitle: Text(inquiries[index]['to_sell & to_let']),
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      CommonWidget.textBoldWight500(
                                          text: "Phone No: ",
                                          color: themColors309D9D),
                                      Text(inquiries[index]['phone_number']),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      CommonWidget.textBoldWight500(
                                          text: "Email: ",
                                          color: themColors309D9D),
                                      Text(inquiries[index]['email']),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: Get.height / 3,
                  ),
                  CommonWidget.textBoldWight500(
                      text: "No Inquiry Found", color: themColors309D9D),
                ],
              ),
            );
          }
        } else {
          return InquiryShimmer();
        }
      },
    );
  }

  StreamBuilder<QuerySnapshot<Object?>> mortgageCheck() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Admin')
          .doc('inquires_list')
          .collection('free_martgage_check')
          .where('user_token', isEqualTo: GetStorageServices.getToken())
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          List<DocumentSnapshot> inquiries = snapshot.data!.docs;
          print("length======>${inquiries.length}");
          if (searchText.isNotEmpty) {
            inquiries = inquiries.where((element) {
              return element
                  .get('full_name')
                  .toString()
                  .toLowerCase()
                  .contains(searchText.toLowerCase());
            }).toList();
          }
          if (snapshot.data!.docs.length != 0) {
            return ListView.builder(
              padding: EdgeInsets.only(left: 20),
              shrinkWrap: true,
              itemCount: inquiries.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        child: ExpansionTile(
                          title: Text(inquiries[index]['full_name']),
                          subtitle: Text(inquiries[index]['email']),
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      CommonWidget.textBoldWight500(
                                          text: "Phone No: ",
                                          color: themColors309D9D),
                                      Text(inquiries[index]['phone_number']),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: Get.height / 3,
                  ),
                  CommonWidget.textBoldWight500(
                      text: "No Inquiry Found", color: themColors309D9D),
                ],
              ),
            );
          }
        } else {
          return InquiryShimmer();
        }
      },
    );
  }
}
