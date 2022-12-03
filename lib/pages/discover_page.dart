import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luxepass/constants/const_variables.dart';
import 'package:luxepass/pages/property_details_screen.dart';
import '../../constants/constant_colors.dart';
import '../../constants/constant_widgets.dart';
import '../constants/constant.dart';
import '../home/widgets/wishl_list_item_widget.dart';
import '../providers/serach_screen_controller.dart';
import '../utils/wishlist_shimmer.dart';

class DiscoverPage extends StatefulWidget {
  final searchData;

  const DiscoverPage({super.key, required this.searchData});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage>
    with SingleTickerProviderStateMixin {
  ConstWidgets constWidgets = ConstWidgets();
  ScrollController _scrollController = ScrollController();
  SerachController _serachController = Get.put(SerachController());
  bool hasMore = true; // flag for more products available or not
  bool isLoading = false;

  List<DocumentSnapshot> products = []; // stor
  // es fetched products
  int documentLimit = 10; // documents to be fetched per request
  TextEditingController? _searchController;
  DocumentSnapshot? lastDocument;

  @override
  void initState() {
    try {
      _searchController = TextEditingController(text: widget.searchData);
    } catch (e) {
      _searchController = TextEditingController();
    }
    _scrollController.addListener(() {
      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.position.pixels;
      double delta = MediaQuery.of(context).size.height * 0.20;
      if (maxScroll - currentScroll <= delta) {
        getProducts();
      }
    });
    getProducts();
    super.initState();
  }

  getProducts() async {
    try {
      if (!hasMore) {
        return;
      }
      if (isLoading) {
        return;
      }
      setState(() {
        isLoading = true;
      });

      QuerySnapshot querySnapshot;
      if (lastDocument == null) {
        querySnapshot = await FirebaseFirestore.instance
            .collection('property_data')
            .orderBy('create_time', descending: true)
            .limit(documentLimit)
            .get();
      } else {
        querySnapshot = await FirebaseFirestore.instance
            .collection('property_data')
            .orderBy('create_time', descending: true)
            .startAfterDocument(lastDocument!)
            .limit(documentLimit)
            .get();
      }
      if (querySnapshot.docs.length < documentLimit) {
        hasMore = false;
      }
      lastDocument = querySnapshot.docs[querySnapshot.docs.length - 1];
      products.addAll(querySnapshot.docs);
      print('length of pt ${products.length}');
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
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
    var width = MediaQuery.of(context).size.width;

    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(ConstVar.backgroundImg), fit: BoxFit.cover),
      ),
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              width: width,
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkResponse(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(Icons.arrow_back_ios),
                  ),
                  // constWidgets.textWidget(
                  //     "Discover", FontWeight.w700, 24, Colors.black),
                  // IconButton(
                  //     onPressed: () {},
                  //     icon: const Icon(
                  //       Icons.add_road,
                  //       size: 24.0,
                  //       color: ConstColors.darkColor,
                  //     ))
                ],
              ),
            ),
            SizedBox(
              height: 50,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: TextFormField(
                  //autofocus: true,
                  onChanged: (value) {
                    setState(() {});
                  },
                  controller: _searchController,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(top: 10),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: themColors309D9D),
                      ),
                      hintText: "Search",
                      prefixIcon: InkResponse(
                        onTap: () {},
                        child: Icon(
                          Icons.search,
                        ),
                      )),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            // Container(
            //   padding: const EdgeInsets.all(15),
            //   width: width,
            //   child: Container(
            //     height: 50,
            //     padding: const EdgeInsets.all(5),
            //     decoration: BoxDecoration(
            //       color: ConstColors.searchBoxColor,
            //       border: Border.all(
            //           color: ConstColors.widgetDividerColor, width: 1.0),
            //       borderRadius: BorderRadius.circular(50),
            //     ),
            //     child: TextFormField(
            //       controller: _searchController,
            //       onChanged: (value) {
            //         setState(() {});
            //       },
            //       decoration: InputDecoration(
            //         prefixIcon: Icon(Icons.search),
            //         hintText: "Search",
            //         border: InputBorder.none,
            //       ),
            //     ),
            //   ),
            // ),
            _descriptionWidget()
          ],
        ),
      ),
    );
  }

  Widget _descriptionWidget() {
    print("property length==>>${products.length}");
    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection('property_data')
          .where('city', isGreaterThanOrEqualTo: 'surat')
          .where('state', isGreaterThanOrEqualTo: 'gujrat')
          .where('address1', isGreaterThanOrEqualTo: 'nana varchha')
          // .where('city', isGreaterThanOrEqualTo: _serachController.city)
          // .where('state', isGreaterThanOrEqualTo: _serachController.state)
          // .where('address1', isGreaterThanOrEqualTo: _serachController.address1)
          .get(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          List<DocumentSnapshot> properties = snapshot.data!.docs;
          if (_searchController!.text.isNotEmpty) {
            properties = properties.where((element) {
              return element
                  // .get('propertyName')
                  .get('address')
                  .toString()
                  .toLowerCase()
                  .contains(_searchController!.text.toLowerCase());
            }).toList();
          }
          try {
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: properties.length,
              itemBuilder: (context, index) {
                var fetchData = properties[index];
                return WishListItemWidget(
                    onTap: () {
                      Get.to(() => PropertyDetailsPage(
                            fetchData: fetchData,
                          ));
                    },
                    wishListItemModel: fetchData);
              },
            );
          } catch (e) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/services/villa.png',
                    scale: 3,
                  ),
                  // Text(
                  //   'Hii',
                  //   textScaleFactor: 3,
                  // )
                ],
              ),
            );
          }
        } else {
          return WishListShimmer();
        }
      },
    );
  }
}
