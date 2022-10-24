import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luxepass/constants/const_variables.dart';
import '../../constants/constant_colors.dart';
import '../../constants/constant_widgets.dart';
import '../get_storage_services/get_storage_service.dart';
import '../home/widgets/wishl_list_item_widget.dart';
import '../utils/wishlist_shimmer.dart';
import 'authentication/signin.dart';
import 'property_details_screen.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({Key? key}) : super(key: key);

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage>
    with SingleTickerProviderStateMixin {
  ConstWidgets constWidgets = ConstWidgets();

  String searchText = '';

  TextEditingController searchController = TextEditingController();

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
    var width = MediaQuery.of(context).size.width;

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
                        constWidgets.textWidget(
                            "Discover", FontWeight.w700, 24, Colors.black),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.add_road,
                              size: 24.0,
                              color: ConstColors.darkColor,
                            ))
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(15),
                    width: width,
                    child: Container(
                      height: 50,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: ConstColors.searchBoxColor,
                        border: Border.all(
                            color: ConstColors.widgetDividerColor, width: 1.0),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: TextFormField(
                        controller: searchController,
                        onChanged: (value) {
                          setState(() {
                            searchText = value;
                          });
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          hintText: "Search",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ];
        },
        body: _descriptionWidget(),
      ),
    );
  }

  Widget _descriptionWidget() {
    return Container(
      padding: const EdgeInsets.all(15.0),
      width: MediaQuery.of(context).size.width - 30,
      child: SingleChildScrollView(
          child: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('Admin')
            .doc('all_properties')
            .collection('property_data')
            .orderBy('create_time', descending: true)
            .get(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                var fetchData = snapshot.data.docs[index];
                // if (searchText.isNotEmpty) {
                //   fetchData = fetchData.where((element) {
                //     return element
                //         .get('propertyName')
                //         .toString()
                //         .toLowerCase()
                //         .contains(searchText.toLowerCase());
                //   }).toList();
                // }
                return WishListItemWidget(
                    onTap: () {
                      if (GetStorageServices.getUserLoggedInStatus() == true) {
                        Get.to(() => PropertyDetailsPage(
                              fetchData: fetchData,
                            ));
                      } else {
                        Get.to(() => const SignInScreen());
                      }
                    },
                    wishListItemModel: fetchData);
              },
            );
          } else {
            return WishListShimmer();
          }
        },
      )),
    );
  }
}
