
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/constant_colors.dart';
import '../../../constants/constant_widgets.dart';

class ReviewCardItemWidget extends StatefulWidget {
  const ReviewCardItemWidget({Key? key}) : super(key: key);

  @override
  State<ReviewCardItemWidget> createState() => _ReviewCardItemWidgetState();
}

class _ReviewCardItemWidgetState extends State<ReviewCardItemWidget> {
  ConstWidgets constWidgets = ConstWidgets();

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      shadowColor: ConstColors.widgetDividerColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Colors.white),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset(
                  "assets/profilepic.jpg",
                  height: 50.0,
                  width: 50.0,
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width-120 , // Full Width - 15padding +15 Padding + 50+10 ( Profile pic width) ,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            constWidgets.textWidget(
                                "Dharmik Shah",
                                FontWeight.w600,
                                16, Colors.black),

                            constWidgets.textWidget(
                                "30 June , 2022",
                                FontWeight.w600,
                                12, Colors.grey),
                          ],
                        ),
                        Container(
                          color: ConstColors.darkColor,
                          padding: const EdgeInsets.fromLTRB(
                              5.0, 5.0, 5.0, 5.0),
                          height: 20,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Icon(Icons.star,
                                  color: Colors.yellow,
                                  size: 12,
                                ),
                                constWidgets.textWidget(
                                    "5.0",
                                    FontWeight.w700,
                                    12, Colors.white),

                              ]),
                        ),

                      ],
                    ),
                  ),
                  Container(
                  width: MediaQuery.of(context).size.width-120,
                    margin: const EdgeInsets.only(top: 5.0),
                    child: Text(
                     "New Room And Delicious Dinners! Special Resort In Every Way ",
                      maxLines: 5,
                      style: GoogleFonts.urbanist(
                          fontWeight: FontWeight.w400, fontSize: 14, color: Colors.black),
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 8.0,right: 8.0),
                    child: constWidgets.textWidget(
                        "Read More ",
                        FontWeight.w700,
                        14, ConstColors.lightColor),
                  ),


                ],
              )

        ]),
      ),
    );
  }
}
