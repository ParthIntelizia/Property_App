import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luxepass/get_storage_services/get_storage_service.dart';
import '../../../constants/constant_colors.dart';
import '../../../constants/constant_widgets.dart';

class WishListItemWidget extends StatefulWidget {
  final wishListItemModel;
  const WishListItemWidget({Key? key, required this.wishListItemModel})
      : super(key: key);

  @override
  State<WishListItemWidget> createState() => _WishListItemWidgetState();
}

class _WishListItemWidgetState extends State<WishListItemWidget> {
  ConstWidgets constWidgets = ConstWidgets();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection('All_User_Details')
          .doc(GetStorageServices.getToken())
          .get(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data['list_of_like'].length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              print('itm length ${snapshot.data['list_of_like'].length}');
              return FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('Admin')
                    .doc('all_properties')
                    .collection('property_data')
                    .where('productId',
                        isEqualTo: snapshot.data['list_of_like'][index])
                    .get(),
                builder: (context, AsyncSnapshot snapshotSingle) {
                  if (snapshotSingle.hasData) {
                    var getSingleProductData = snapshotSingle.data.docs[0];
                    print(
                        'getSingleProductData  ${getSingleProductData['address']}');
                    return Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.white,
                          border: Border.all(
                              color: ConstColors.widgetDividerColor,
                              width: 0.5)),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(5.0),
                              child: Image.network(
                                '${getSingleProductData['listOfImage'][0]}',
                                height: 100.0,
                                width: 100.0,
                                fit: BoxFit.fill,
                              ),
                            ),
                            const SizedBox(width: 10),
                            SizedBox(
                                width: MediaQuery.of(context).size.width -
                                    162, // Full Width - 15padding +15 Padding + 50+10 ( Profile pic width) ,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    constWidgets.textWidget(
                                        '${getSingleProductData['propertyName']}',
                                        FontWeight.w700,
                                        16,
                                        Colors.black),
                                    Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          0.0, 5.0, 10.0, 5.0),
                                      height: 25,
                                      child: Row(children: [
                                        const Icon(
                                          Icons.location_on,
                                          color: ConstColors.darkColor,
                                          size: 12,
                                        ),
                                        constWidgets.textWidget(
                                            '${getSingleProductData['address']}',
                                            FontWeight.w600,
                                            10,
                                            Colors.grey),
                                      ]),
                                    ),
                                    Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            0.0, 5.0, 0.0, 10.0),
                                        child: RichText(
                                          text: TextSpan(
                                            text: String.fromCharCodes(
                                                Runes('\u0024')),
                                            style: GoogleFonts.urbanist(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 14.0,
                                                color: ConstColors.darkColor),
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text:
                                                      '${getSingleProductData['price']}',
                                                  style: GoogleFonts.urbanist(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 14.0,
                                                      color: ConstColors
                                                          .darkColor)),
                                              TextSpan(
                                                  text: '/year',
                                                  style: GoogleFonts.urbanist(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 10.0,
                                                      color: Colors.grey))
                                            ],
                                          ),
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 0.0,
                                          left: 5.0,
                                          right: 0.0,
                                          bottom: 5.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          constWidgets.textWidget(
                                              "⭐ 4.2   ",
                                              FontWeight.w600,
                                              12,
                                              Colors.yellow),
                                          constWidgets.textWidget(
                                              "⚈ ${getSingleProductData['category']}",
                                              FontWeight.w500,
                                              12,
                                              ConstColors.darkColor)
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                          ]),
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              );
            },
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
