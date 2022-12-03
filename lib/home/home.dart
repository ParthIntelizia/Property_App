import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_codes/country_codes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luxepass/constants/common_widget.dart';
import 'package:luxepass/constants/const_variables.dart';
import 'package:luxepass/get_storage_services/get_storage_service.dart';
import 'package:luxepass/home/widgets/wishl_list_item_widget.dart';
import 'package:luxepass/pages/popular_screen.dart';
import 'package:luxepass/providers/homepage_provider.dart';
import 'package:provider/provider.dart';
import '../constants/constant_colors.dart';
import '../constants/constant_widgets.dart';
import '../models/service_model.dart';
import '../models/wish_list_model.dart';
import '../pages/authentication/signin.dart';
import '../pages/property_details_screen.dart';
import '../providers/navbar_provider.dart';
import '../services/locator_service.dart';
import '../utils/category_shimmer.dart';
import '../utils/properties_shimmer.dart';
import '../utils/wishlist_shimmer.dart';
import 'widgets/search_widget.dart';
import 'widgets/service_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController? _homePageTabController;

  ConstWidgets constWidgets = ConstWidgets();
  bool form = true;
  bool form1 = true;

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _pastCodeController = TextEditingController();
  final TextEditingController _fullNameController1 = TextEditingController();
  final TextEditingController _emailController1 = TextEditingController();
  final TextEditingController _phoneController1 = TextEditingController();
  final TextEditingController _messageController1 = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _pastCodeController.dispose();
    _fullNameController1.dispose();
    _emailController1.dispose();
    _phoneController1.dispose();
    _messageController1.dispose();
  }

  String showCategoryWiseData = 'All';
  setCountryCode() async {
    await CountryCodes.init();

    final CountryDetails details = CountryCodes.detailsForLocale();
    print('ddddddddd    ${details.alpha2Code}');
    GetStorageServices.setCountryCode(details.alpha2Code!);
  }

  @override
  void initState() {
    super.initState();
    setCountryCode();
    _homePageTabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    HomeProvider homeProvider = Provider.of<HomeProvider>(context);
    return SafeArea(
        child: Scaffold(
      backgroundColor: ConstColors.backgroundColor,
      body: ProgressHUD(child: Builder(
        builder: (context) {
          final progress = ProgressHUD.of(context);

          return _body(homeProvider, progress);
        },
      )),
    ));
  }

  Widget _body(HomeProvider homeProvider, final progress) {
    var width = MediaQuery.of(context).size.width;
    var safearea = MediaQuery.of(context).padding.top;
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(ConstVar.backgroundImg), fit: BoxFit.cover),
      ),
      child: Column(
        children: [
          Column(
            children: [
              SizedBox(
                height: safearea,
              ),
              Container(
                width: width,
                padding: const EdgeInsets.only(
                    left: 15.0, top: 15.0, right: 15.0, bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        constWidgets.textWidget("Find your best property",
                            FontWeight.w700, 18, Colors.black),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        locator<NavBarIndex>().setTabCount(3);
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(shape: BoxShape.circle),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(300),
                          child: Image.network(
                              '${GetStorageServices.getProfileImageValue()}',
                              errorBuilder: (context, error, stackTrace) =>
                                  CircleAvatar(
                                    minRadius: 20,
                                    backgroundColor:
                                        Colors.grey.withOpacity(0.5),
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.grey,
                                    ),
                                  ),
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(children: [
                InkWell(
                  onTap: () {
                    locator<NavBarIndex>().setTabCount(2);

                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => const SearchScreen(),
                    //   ),
                    // );
                  },
                  child: const SearchWidget(
                      title: "Search",
                      highlight: "Any Day | Any Where | Add Guest"),
                ),
                FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('Admin')
                      .doc('categories')
                      .collection('categories_list')
                      .get(),
                  builder: (context, AsyncSnapshot snapshot) {
                    try {
                      if (snapshot.hasData) {
                        return snapshot.data.docs.length == 0
                            ? SizedBox()
                            : SizedBox(
                                width: Get.width,
                                height: 60,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: ListView.builder(
                                        itemCount:
                                            snapshot.data.docs.length + 1,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          if (index == 0) {
                                            return GestureDetector(
                                              onTap: () {
                                                showCategoryWiseData = 'All';
                                                setState(() {});
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8),
                                                child: Tab(
                                                    child: Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20.0,
                                                          right: 20.0,
                                                          top: 7.0,
                                                          bottom: 7.0),
                                                  decoration: BoxDecoration(
                                                      color: ConstColors
                                                          .searchBoxColor,
                                                      border: Border.all(
                                                          color:
                                                              showCategoryWiseData ==
                                                                      'All'
                                                                  ? ConstColors
                                                                      .lightColor
                                                                  : ConstColors
                                                                      .widgetDividerColor,
                                                          width: 1.0),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50)),
                                                  child: Text('All',
                                                      style:
                                                          GoogleFonts.urbanist(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 13,
                                                              color: ConstColors
                                                                  .darkColor)),
                                                )),
                                              ),
                                            );
                                          }
                                          var fetchCategory =
                                              snapshot.data.docs[index - 1];
                                          return fetchCategory[
                                                      'category_name'] ==
                                                  "All"
                                              ? SizedBox()
                                              : GestureDetector(
                                                  onTap: () {
                                                    showCategoryWiseData =
                                                        fetchCategory[
                                                            'category_name'];
                                                    setState(() {});
                                                  },
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 8),
                                                    child: Tab(
                                                        child: Container(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 15.0,
                                                              right: 15.0,
                                                              top: 5.0,
                                                              bottom: 5.0),
                                                      decoration: BoxDecoration(
                                                          color: ConstColors
                                                              .searchBoxColor,
                                                          border: Border.all(
                                                              color: showCategoryWiseData ==
                                                                      fetchCategory[
                                                                          'category_name']
                                                                  ? ConstColors
                                                                      .lightColor
                                                                  : ConstColors
                                                                      .widgetDividerColor,
                                                              width: 1.0),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      50)),
                                                      child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            SizedBox(
                                                              height: 22,
                                                              width: 22,
                                                              child: Image.network(
                                                                  '${fetchCategory['category_image'][0]}',
                                                                  fit: BoxFit
                                                                      .cover),
                                                            ),
                                                            SizedBox(width: 8),
                                                            // const Icon(Icons.home,
                                                            //     size: 25, color: ConstColors.darkColor),
                                                            Text(
                                                                '${fetchCategory['category_name']}',
                                                                style: GoogleFonts.urbanist(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        13,
                                                                    color: ConstColors
                                                                        .darkColor))
                                                          ]),
                                                    )),
                                                  ),
                                                );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              );
                      } else {
                        return CategoryShimmer();
                      }
                    } catch (e) {
                      return SizedBox();
                    }
                  },
                ),
                allCategories(homeProvider.allServices!, progress),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget allCategories(List<List<ServiceModel>> allServices, final progress) {
    HomeProvider homeProvider =
        Provider.of<HomeProvider>(context, listen: false);

    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          serviceFunction(allServices[0]),
          recomendedFunction(homeProvider.recomendedService!),
          form ? inputForm("heading", progress) : SizedBox(),
          form1 ? inputForm1("heading", progress) : SizedBox(),
        ],
      ),
    );
  }

  Widget serviceFunction(List<ServiceModel> services) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 40,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: constWidgets.textWidget("Popular", FontWeight.w500, 20,
                      ConstColors.serviceHeadLineColor),
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => PopularPage(
                          appTitle: 'Popular',
                        ));
                  },
                  child: Padding(
                      padding: EdgeInsets.only(right: 15, left: 15),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black,
                        size: 16,
                      )),
                ),
              ],
            ),
          ),
          popularWidget(services),
        ],
      ),
    );
  }

  Widget popularWidget(List<ServiceModel> services) {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: FutureBuilder(
        future: showCategoryWiseData == 'All'
            ? FirebaseFirestore.instance
                .collection('property_data')
                .orderBy('create_time', descending: true)
                .limit(10)
                .get()
            : FirebaseFirestore.instance
                .collection('property_data')
                .where('category', isEqualTo: showCategoryWiseData)
                .orderBy('create_time', descending: true)
                .limit(10)
                .get(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            try {
              return SizedBox(
                height: snapshot.data.docs.length == 0 ? 0 : 350,
                width: double.infinity,
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      var fetchData = snapshot.data.docs[index];

                      return InkWell(
                        child: Services(
                            highlight1: fetchData['category'],
                            title: fetchData['propertyName'],
                            image: fetchData['listOfImage'][0],
                            location: fetchData['address'],
                            price: '\$${fetchData['price']}'),
                        onTap: () {
                          Get.to(() => PropertyDetailsPage(
                                fetchData: fetchData,
                              ));

                          // MyNavigator.goToEventDetailsScreen(context);
                        },
                      );
                    }),
              );
            } catch (e) {
              return SizedBox();
            }
          } else {
            return PropertiesShimmer();
          }
        },
      ),
    );
  }

  Widget recomendedFunction(List<WishListItemModel> services) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 60,
            width: MediaQuery.of(context).size.width,
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: constWidgets.textWidget("Recommended for you",
                      FontWeight.w500, 20, ConstColors.serviceHeadLineColor),
                ),
                Spacer(),
                InkWell(
                  onTap: () {
                    Get.to(() => PopularPage(
                          appTitle: 'Recommended',
                        ));
                  },
                  child: Padding(
                      padding: EdgeInsets.only(right: 15, left: 15),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black,
                        size: 16,
                      )),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('property_data')
                  .orderBy('create_time', descending: false)
                  .limit(3)
                  .get(),
              builder: (context, AsyncSnapshot snapshot) {
                try {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, index) {
                          var fetchMenData = snapshot.data.docs[index];

                          return WishListItemWidget(
                              onTap: () {
                                Get.to(() => PropertyDetailsPage(
                                      fetchData: fetchMenData,
                                    ));
                              },
                              wishListItemModel: fetchMenData);
                        });
                  } else {
                    return WishListShimmer();
                  }
                } catch (e) {
                  return SizedBox();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  String? gender = "To Sell";

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
              constWidgets.textWidget("Get a Free Valuation", FontWeight.w500,
                  20, ConstColors.serviceHeadLineColor),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 150,
                      child: RadioListTile(
                        title: constWidgets.textWidget("To Sell",
                            FontWeight.w700, 12, ConstColors.darkColor),
                        value: "To Sell",
                        groupValue: gender,
                        onChanged: (value) {
                          setState(() {
                            gender = value.toString();
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      child: RadioListTile(
                        title: constWidgets.textWidget("To Let",
                            FontWeight.w700, 12, ConstColors.darkColor),
                        value: "To Let",
                        groupValue: gender,
                        onChanged: (value) {
                          setState(() {
                            gender = value.toString();
                          });
                        },
                      ),
                    ),
                  ],
                ),
              )
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
                          form = false;

                          await FirebaseFirestore.instance
                              .collection('Admin')
                              .doc('inquires_list')
                              .collection('get_a_free_valuation')
                              .add({
                            'to_sell & to_let': gender,
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
                      width: 100,
                      margin: const EdgeInsets.only(top: 15.0),
                      decoration: const BoxDecoration(
                          color: ConstColors.darkColor,
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      child: Center(
                        child: constWidgets.textWidget(
                            "Submit", FontWeight.w700, 12, Colors.white),
                      )),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget inputForm1(String heading, final progress) {
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
              constWidgets.textWidget("Free Mortgage check", FontWeight.w500,
                  20, ConstColors.serviceHeadLineColor),
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
                    controller: _fullNameController1,
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
                    controller: _emailController1,
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
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    keyboardType: TextInputType.number,
                    controller: _phoneController1,
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
                      "Message", FontWeight.w500, 16, Colors.black),
                  const SizedBox(height: 10.0),
                  TextField(
                    maxLines: 3,
                    controller: _messageController1,
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
                      if (_fullNameController1.text.isNotEmpty &&
                          _emailController1.text.isNotEmpty &&
                          _phoneController1.text.isNotEmpty &&
                          _messageController1.text.isNotEmpty) {
                        bool emailValid = RegExp(
                                r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                            .hasMatch(_emailController1.text.trim());
                        if (emailValid == true) {
                          form1 = false;

                          await FirebaseFirestore.instance
                              .collection('Admin')
                              .doc('inquires_list')
                              .collection('free_martgage_check')
                              .add({
                            'full_name': _fullNameController1.text.toString(),
                            "email": _emailController1.text.toString().trim(),
                            "phone_number": _phoneController1.text.toString(),
                            "postcode": _messageController1.text,
                            "user_token": GetStorageServices.getToken(),
                            'crate_date': DateTime.now().toString()
                          });

                          CommonWidget.getSnackBar(
                              duration: 2,
                              title: "Submitted!",
                              message:
                                  'Your inquiry has been received, We will contact you shortly.');
                        } else {
                          CommonWidget.getSnackBar(
                              color: Colors.red,
                              duration: 2,
                              title: 'Invalid Email',
                              message: 'Please Enter Valid Email');
                        }
                        progress.dismiss();

                        setState(() {});
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
                      width: 100,
                      margin: const EdgeInsets.only(top: 15.0),
                      decoration: const BoxDecoration(
                          color: ConstColors.darkColor,
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      child: Center(
                        child: constWidgets.textWidget(
                            "Submit", FontWeight.w700, 12, Colors.white),
                      )),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  final List<Tab> myTabs = <Tab>[
    Tab(
        child: Container(
      padding:
          const EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0, bottom: 5.0),
      decoration: BoxDecoration(
          color: ConstColors.searchBoxColor,
          border: Border.all(color: ConstColors.widgetDividerColor, width: 1.0),
          borderRadius: BorderRadius.circular(50)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        const Icon(Icons.home, size: 25, color: ConstColors.darkColor),
        Text('Home',
            style: GoogleFonts.urbanist(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: ConstColors.darkColor))
      ]),
    )),
    Tab(
        child: Container(
      padding:
          const EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0, bottom: 5.0),
      decoration: BoxDecoration(
          color: ConstColors.searchBoxColor,
          border: Border.all(color: ConstColors.widgetDividerColor, width: 1.0),
          borderRadius: BorderRadius.circular(50)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        const Icon(Icons.villa, size: 25, color: ConstColors.darkColor),
        Text('Villa',
            style: GoogleFonts.urbanist(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: ConstColors.darkColor))
      ]),
    )),
    Tab(
        child: Container(
      padding:
          const EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0, bottom: 5.0),
      decoration: BoxDecoration(
          color: ConstColors.searchBoxColor,
          border: Border.all(color: ConstColors.widgetDividerColor, width: 1.0),
          borderRadius: BorderRadius.circular(50)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        const Icon(Icons.apartment, size: 25, color: ConstColors.darkColor),
        Text('Apartment',
            style: GoogleFonts.urbanist(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: ConstColors.darkColor))
      ]),
    )),
  ];
}
