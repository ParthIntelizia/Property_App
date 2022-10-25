import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:luxepass/constants/const_variables.dart';
import 'package:luxepass/get_storage_services/get_storage_service.dart';
import 'package:provider/provider.dart';
import '../../constants/constant_colors.dart';
import '../../constants/constant_widgets.dart';
import '../../providers/search_screen_provider.dart';
import '../home/widgets/unordered_list.dart';

class PropertyDetailsPage extends StatefulWidget {
  final fetchData;
  const PropertyDetailsPage({Key? key, required this.fetchData})
      : super(key: key);

  @override
  State<PropertyDetailsPage> createState() => _PropertyDetailsPageState();
}

class _PropertyDetailsPageState extends State<PropertyDetailsPage>
    with SingleTickerProviderStateMixin {
  TabController? _homePageTabController;
  ConstWidgets constWidgets = ConstWidgets();

  int _current = 0;

  final CarouselController _controller = CarouselController();
  List<String> crouselImage = [];
  bool isContainCheck = false;
  @override
  void initState() {
    _homePageTabController = TabController(length: 5, vsync: this);
    widget.fetchData['listOfImage'].forEach((element) {
      crouselImage.add(element as String);
    });
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
    SearchScreenProvider searchScreenProvider =
        Provider.of<SearchScreenProvider>(context);
    var width = MediaQuery.of(context).size.width;
    var safearea = MediaQuery.of(context).padding.top;

    var title =
        "${searchScreenProvider.selectedDate}. ${searchScreenProvider.selectedAdults} Adults  ${searchScreenProvider.selectedChildren} Child ";

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
              child: SizedBox(
                height: 400,
                width: width,
                child: Stack(
                  children: [
                    CarouselSlider.builder(
                      itemCount: widget.fetchData['listOfImage'].length,
                      carouselController: _controller,
                      itemBuilder: (BuildContext context, int itemIndex,
                              int pageViewIndex) =>
                          SizedBox(
                        width: width,
                        height: 400,
                        child: Image.network(
                            widget.fetchData['listOfImage'][itemIndex],
                            fit: BoxFit.fill),
                      ),
                      options: CarouselOptions(
                        onPageChanged: (index, reason) {
                          _current = index;
                          setState(() {});
                        },
                        height: 400,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        viewportFraction: 1.0,
                        initialPage: 1,
                      ),
                    ),
                    Positioned(
                        left: width / 2 - 50,
                        bottom: 20.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: crouselImage.asMap().entries.map((entry) {
                            print('enenen ${entry.key}  ${_current}');
                            return GestureDetector(
                              onTap: () => _controller.animateToPage(entry.key),
                              child: Container(
                                width: 12.0,
                                height: 12.0,
                                margin: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 4.0),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: _current == entry.key
                                        ? Colors.black
                                        : Colors.black.withOpacity(0.4)),
                              ),
                            );
                          }).toList(),
                        )),
                    Column(
                      children: [
                        SizedBox(
                          height: safearea,
                        ),
                        Container(
                          width: width,
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.only(left: 5),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white),
                                      height: 30,
                                      width: 30,
                                      margin: const EdgeInsets.only(left: 10.0),
                                      child: Center(
                                        child: const Icon(Icons.arrow_back_ios,
                                            size: 16, color: Colors.grey),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                margin: const EdgeInsets.only(right: 10.0),
                                padding: const EdgeInsets.only(right: 10.0),
                                child: Row(
                                  children: [
                                    FutureBuilder(
                                      builder:
                                          (context, AsyncSnapshot snapshot) {
                                        if (snapshot.hasData) {
                                          try {
                                            isContainCheck = snapshot
                                                .data['list_of_like']
                                                .contains(1);
                                            print(
                                                'list_of_like  ${snapshot.data['list_of_like'].contains(1)}');
                                          } catch (e) {
                                            isContainCheck = false;
                                          }

                                          return GestureDetector(
                                            onTap: () {
                                              likeUnLike(
                                                  productId: widget
                                                      .fetchData['productId']);
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  color: Colors.white),
                                              height: 30,
                                              width: 30,
                                              child: Center(
                                                child: likeWidget(snapshot),
                                              ),
                                            ),
                                          );
                                        } else {
                                          return Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                color: Colors.white),
                                            height: 30,
                                            width: 30,
                                          );
                                        }
                                      },
                                      future: FirebaseFirestore.instance
                                          .collection('All_User_Details')
                                          .doc(GetStorageServices.getToken())
                                          .get(),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white),
                                      height: 30,
                                      width: 30,
                                      padding: const EdgeInsets.only(right: 3),
                                      child: const Center(
                                        child: Icon(
                                          Icons.share,
                                          color: Colors.grey,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ];
        },
        body: _descriptionWidget(widget.fetchData),
      ),
    );
  }

  Image likeWidget(AsyncSnapshot<dynamic> snapshot) {
    try {
      return Image.asset(
        color: snapshot.data['list_of_like']
                .contains(widget.fetchData['productId'])
            ? Colors.red
            : Colors.grey,
        'assets/icons/favorite.png',
        height: 20,
        width: 20,
      );
    } catch (e) {
      return Image.asset(
        color: Colors.grey,
        'assets/icons/favorite.png',
        height: 20,
        width: 20,
      );
    }
  }

  likeUnLike({required int productId}) async {
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
      queue = docSnap.get('list_of_like');
    }
    if (queue.contains(productId) == true) {
      equipmentCollection.update({
        "list_of_like": FieldValue.arrayRemove([productId])
      }).then((value) {
        setState(() {
          isContainCheck = false;
        });
      });
    } else {
      equipmentCollection.update({
        "list_of_like": FieldValue.arrayUnion([productId])
      }).then((value) {
        isContainCheck = true;
      });
    }
    setState(() {});
  }

  Widget selectedFilter(String text, IconData icon) {
    return Container(
      color: ConstColors.darkColor,
      padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
      margin: const EdgeInsets.all(5.0),
      height: 35,
      child: Row(children: [
        Icon(
          icon,
          color: Colors.white,
          size: 14,
        ),
        constWidgets.textWidget(text, FontWeight.w700, 14, Colors.white),
      ]),
    );
  }

  Widget _descriptionWidget(final fetchData) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            constWidgets.textWidget("${fetchData['propertyName']}",
                FontWeight.w700, 20, Colors.black),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(0.0, 5.0, 10.0, 5.0),
                    height: 25,
                    child: Row(children: [
                      const Icon(
                        Icons.location_on,
                        color: Colors.grey,
                        size: 12,
                      ),
                      constWidgets.textWidget("${fetchData['address']}",
                          FontWeight.w400, 12, Colors.grey),
                    ]),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                    height: 30,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        constWidgets.textWidget(
                            "⭐ 4.2   ", FontWeight.w600, 12, Colors.yellow),
                        constWidgets.textWidget("${fetchData['category']}",
                            FontWeight.w600, 12, ConstColors.darkColor)
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 1,
              margin: const EdgeInsets.only(top: 10.0),
              width: MediaQuery.of(context).size.width,
              color: ConstColors.widgetDividerColor,
            ),
            SizedBox(
              height: 80,
              width: MediaQuery.of(context).size.width - 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                      width: 60,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Icon(Icons.square,
                                size: 20, color: ConstColors.lightColor),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: constWidgets.textWidget(
                                "${fetchData['size']}",
                                FontWeight.w500,
                                10,
                                Colors.grey),
                          )
                        ],
                      )),
                  Container(
                    height: 50,
                    width: 0.5,
                    color: ConstColors.widgetDividerColor,
                  ),
                  SizedBox(
                      width: 80,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Icon(Icons.bedroom_parent_sharp,
                                size: 20, color: ConstColors.darkColor),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: constWidgets.textWidget(
                                "${fetchData['totalBedRooms']} Bedroom",
                                FontWeight.w500,
                                10,
                                Colors.grey),
                          )
                        ],
                      )),
                  Container(
                    height: 50,
                    width: 0.5,
                    color: ConstColors.widgetDividerColor,
                  ),
                  SizedBox(
                      width: 80,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Icon(Icons.bathtub_sharp,
                                size: 20, color: ConstColors.darkColor),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: constWidgets.textWidget(
                                "${fetchData['totalBathrooms']} Bathroom",
                                FontWeight.w500,
                                10,
                                Colors.grey),
                          )
                        ],
                      )),
                  Container(
                    height: 50,
                    width: 0.5,
                    color: ConstColors.widgetDividerColor,
                  ),
                  fetchData['isParkingAvailable'] == true
                      ? SizedBox(
                          width: 80,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Icon(Icons.local_parking,
                                    size: 20, color: ConstColors.darkColor),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: constWidgets.textWidget("Parking",
                                    FontWeight.w500, 10, Colors.grey),
                              )
                            ],
                          ))
                      : SizedBox(),
                ],
              ),
            ),
            Container(
              height: 1,
              margin: const EdgeInsets.only(bottom: 15.0),
              width: MediaQuery.of(context).size.width,
              color: ConstColors.widgetDividerColor,
            ),
            Container(
              margin: const EdgeInsets.only(top: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  constWidgets.textWidget(
                      "Description", FontWeight.w700, 20, Colors.black),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: constWidgets.textWidget(
                        "${fetchData['description']}",
                        FontWeight.w500,
                        12,
                        Colors.black),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 10.0),
                    child: UnorderedList(const [
                      "Two good size reception room",
                      "3 Bedrooms",
                      "Bathroom upstairs",
                      "Walk in Shower downstairs",
                      "Garden",
                      "Rent : 750",
                      "DSS Accepted "
                    ]),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
