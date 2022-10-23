
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../constants/constant_colors.dart';
import '../../../constants/constant_widgets.dart';

class ReviewServiceItemWidget extends StatefulWidget {
  final String memberCount;
  const ReviewServiceItemWidget({Key? key, required this.memberCount}) : super(key: key);

  @override
  State<ReviewServiceItemWidget> createState() => _ReviewServiceItemWidgetState();
}

class _ReviewServiceItemWidgetState extends State<ReviewServiceItemWidget> {
  ConstWidgets constWidgets = ConstWidgets();

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      shadowColor: ConstColors.widgetDividerColor,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
        child: Column(
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.asset(
                      "assets/login_corosal_img/img2.jpg",
                      height: 120.0,
                      width: 80.0,
                      fit: BoxFit.fill,
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: MediaQuery.of(context).size.width-140 , // Full Width - 15padding +15 Padding + 50+10 ( Profile pic width) ,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        constWidgets.textWidget("Spa 60 min & Spa Circuit 90 Min",
                            FontWeight.w600, 22, Colors.black),
                        constWidgets.textWidget("NCR Gurgaon Haryana 122002",
                            FontWeight.w300, 16, Colors.black),
                        Container(
                          padding: const EdgeInsets.fromLTRB(0.0, 5.0, 10.0, 5.0),
                          height: 25,
                          child: Row(children: [
                            const Icon(
                              Icons.location_on,
                              color: ConstColors.darkColor,
                              size: 12,
                            ),
                            constWidgets.textWidget("Weston Gurgaon Delhi",
                                FontWeight.w600, 14, Colors.grey),
                          ]),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(
                              5.0, 5.0, 5.0, 5.0),
                          height: 20,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(Icons.star,
                                  color: Colors.yellow,
                                  size: 12,
                                ),
                                constWidgets.textWidget(
                                    "5.0",
                                    FontWeight.w700,
                                    12, Colors.black),

                              ]),
                        ),

                      ],
                    )
                  ),
                ]),
            Container(
              height: 1,
              width: MediaQuery.of(context).size.width-50,
              margin: const EdgeInsets.only(top: 15),
              color: ConstColors.widgetDividerColor,
            ),

            Container(
              width: MediaQuery.of(context).size.width-50,
              padding: const EdgeInsets.all(15.0),
              child: Center(
                child:constWidgets.textWidget(
                    widget.memberCount,
                    FontWeight.w700,
                    18, Colors.black
              ),
            ))

          ],
        ),
      ),
    );
  }
}
