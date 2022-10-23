
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../constants/constant_colors.dart';
import '../../../constants/constant_widgets.dart';

class CouponAppliedWidget extends StatefulWidget {

  const CouponAppliedWidget({Key? key}) : super(key: key);

  @override
  State<CouponAppliedWidget> createState() => _CouponAppliedWidgetState();
}

class _CouponAppliedWidgetState extends State<CouponAppliedWidget> {
  ConstWidgets constWidgets = ConstWidgets();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.white,border: Border.all(width: 1.0,color: ConstColors.darkColor)),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.asset(
                "assets/gift_box.jpg",
                height: 50.0,
                width: 50.0,
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
                width: MediaQuery.of(context).size.width-120 , // Full Width - 15padding +15 Padding + 50+10 ( Profile pic width) ,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        constWidgets.textWidget("Applied Coupon Code",
                            FontWeight.w600, 14, Colors.black),
                        constWidgets.textWidget("MZAXF4567",
                            FontWeight.w300, 16, Colors.grey),
                        Container(
                          padding: const EdgeInsets.fromLTRB(0.0, 5.0, 10.0, 5.0),
                          height: 25,
                          child: Row(children: [
                            constWidgets.textWidget("SAVE",
                                FontWeight.w600, 14, Colors.grey),
                            constWidgets.textWidget("  399/-",
                                FontWeight.w600, 14, ConstColors.darkColor),
                          ]),
                        ),
                      ],
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(40.0),
                      child: Container(
                        color: ConstColors.darkColor,
                        height: 25.0,
                        width: 25.0,
                        child: const Icon(
                          Icons.add_circle_outline,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                )
            ),
          ]),
    );
  }
}
