
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../constants/constant_colors.dart';
import '../../../constants/constant_widgets.dart';
import '../../models/wish_list_model.dart';

class MyBookingListItemWidget extends StatefulWidget {
  final WishListItemModel wishListItemModel;
  const MyBookingListItemWidget({Key? key, required this.wishListItemModel}) : super(key: key);

  @override
  State<MyBookingListItemWidget> createState() => _MyBookingListItemWidgetState();
}

class _MyBookingListItemWidgetState extends State<MyBookingListItemWidget> {
  ConstWidgets constWidgets = ConstWidgets();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),

      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0), color: Colors.white,border: Border.all(color: ConstColors.lightColor,width: 0.5)),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: Image.asset(
                widget.wishListItemModel.image!,
                height: 120.0,
                width: 100.0,
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
                width: MediaQuery.of(context).size.width-162 , // Full Width - 15padding +15 Padding + 50+10 ( Profile pic width) ,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    constWidgets.textWidget(widget.wishListItemModel.title!,
                        FontWeight.w800, 16, Colors.black),
                    Container(
                      padding: const EdgeInsets.fromLTRB(0.0, 5.0, 10.0, 5.0),
                      height: 25,
                      child: Row(children: [
                        const Icon(
                          Icons.location_on,
                          color: ConstColors.darkColor,
                          size: 12,
                        ),
                        constWidgets.textWidget(widget.wishListItemModel.location!,
                            FontWeight.w600, 14, Colors.grey),
                      ]),
                    ),
                    Container(
                        padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 10.0),

                        child:  RichText(
                          text:  TextSpan(
                            text: "4 Days Remaining",
                            style: GoogleFonts.urbanist(
                                fontWeight: FontWeight.w600, fontSize: 12.0, color: Colors.black),
                          ),
                        )
                    ),
                    Container(
                        padding: const EdgeInsets.fromLTRB(
                            0.0, 5.0, 0.0, 0.0),
                        child:  Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 80,
                              padding: const EdgeInsets.only(top: 5.0,bottom: 5.0),
                              margin: const EdgeInsets.only(right: 20.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0), color:Colors.greenAccent.withOpacity(0.5)),
                              child: Center(
                                child: constWidgets.textWidget("Booked",
                                    FontWeight.w600, 14, Colors.green) ,
                              ),
                            ),
                            Center(
                              child: constWidgets.textWidget("ID 284106",
                                  FontWeight.w600, 14, Colors.grey) ,
                            ),
                          ],
                        )
                    ),

                  ],
                )
            ),
          ]),
    );
  }
}
