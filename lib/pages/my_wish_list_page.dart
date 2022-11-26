import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luxepass/constants/const_variables.dart';
import 'package:luxepass/pages/property_details_screen.dart';
import 'package:luxepass/providers/my_wish_list_provider.dart';
import 'package:provider/provider.dart';

import '../../constants/constant_colors.dart';
import '../../constants/constant_widgets.dart';
import '../get_storage_services/get_storage_service.dart';
import '../home/widgets/wishl_list_item_widget.dart';
import '../utils/navigator.dart';
import '../utils/wishlist_shimmer.dart';
import 'authentication/signin.dart';

class MyWishListPage extends StatefulWidget {
  const MyWishListPage({Key? key}) : super(key: key);

  @override
  State<MyWishListPage> createState() => _MyWishListPageState();
}

class _MyWishListPageState extends State<MyWishListPage>
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
    MyWishListProvider myWishListProvider =
        Provider.of<MyWishListProvider>(context);
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
                      "Wishlist", FontWeight.w700, 22, Colors.black),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.search,
                        size: 24.0,
                        color: ConstColors.lightColor,
                      ))
                ],
              ),
            )),
          ];
        },
        body: _descriptionWidget(),
      ),
    );
  }

  Widget _descriptionWidget() {
    MyWishListProvider myWishListProvider =
        Provider.of<MyWishListProvider>(context, listen: false);

    return Container(
      padding: const EdgeInsets.all(15.0),
      width: MediaQuery.of(context).size.width - 30,
      child: SingleChildScrollView(
          child: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('All_User_Details')
            .doc(GetStorageServices.getToken())
            .get(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            try {
              return snapshot.data['list_of_like'].length == 0
                  ? Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: Get.height / 2.5),
                        child: Text('Empty'),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data['list_of_like'].length,
                      itemBuilder: (context, index) {
                        var wishListItem =
                            myWishListProvider.allServices![index];
                        return FutureBuilder(
                          future: FirebaseFirestore.instance
                              .collection('Admin')
                              .doc('all_properties')
                              .collection('property_data')
                              .where('productId',
                                  isEqualTo: snapshot.data['list_of_like']
                                      [index])
                              .get(),
                          builder: (context, AsyncSnapshot snapshotSingle) {
                            if (snapshotSingle.hasData) {
                              var getSingleProductData =
                                  snapshotSingle.data.docs[0];
                              print(
                                  'getSingleProductData  ${getSingleProductData['address']}');
                              return WishListItemWidget(
                                  onTap: () {
                                    Get.to(() => PropertyDetailsPage(
                                          fetchData: getSingleProductData,
                                        ));
                                  },
                                  wishListItemModel: getSingleProductData);
                            } else {
                              return WishListShimmer();
                            }
                          },
                        );
                      },
                    );
            } catch (e) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.only(top: Get.height / 2.8),
                  child: Text('No Data Found'),
                ),
              );
            }
          } else {
            return WishListShimmer();
          }
        },
      )),
    );
  }
}
