import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luxepass/constants/constant_colors.dart';

import '../../constants/constant_widgets.dart';

class Services extends StatefulWidget {
  final String title;
  final String image;
  final String location;
  final String highlight1;
  final String highlight2;
  final String price;
  const Services(
      {Key? key,
      required this.title,
      required this.image,
      required this.location,
      required this.highlight1,
      required this.highlight2,
      required this.price})
      : super(key: key);

  @override
  State<Services> createState() => _ServicesState();
}

class _ServicesState extends State<Services> {
  ConstWidgets constWidgets = ConstWidgets();
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(right: 15.0),
        child: Container(
          height: 350,
          width: 220,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: ConstColors.widgetDividerColor, width: 1.0)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(10)),
                child: SizedBox(
                  height: 200,
                  //   width: 200,
                  child: Image.network(
                    widget.image,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 10, left: 10, right: 10, bottom: 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    constWidgets.textWidget(
                        "⭐ 4.2   ", FontWeight.w600, 12, Colors.yellow),
                    constWidgets.textWidget(widget.highlight1, FontWeight.w400,
                        12, ConstColors.darkColor)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 10, left: 10, right: 10, bottom: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    constWidgets.textWidget(
                        widget.title, FontWeight.w700, 16, Colors.black),
                    const SizedBox(height: 3),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.location_pin,
                            size: 12, color: ConstColors.serviceHighlightColor),
                        const SizedBox(width: 2),
                        constWidgets.textWidget(
                            widget.location,
                            FontWeight.w400,
                            12,
                            ConstColors.serviceHighlightColor),
                      ],
                    ),
                    const SizedBox(height: 8),
                    RichText(
                      text: TextSpan(
                        text: widget.price.toString(),
                        style: GoogleFonts.urbanist(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: ConstColors.darkColor),
                        children: [
                          TextSpan(
                            text: '/year ',
                            style: GoogleFonts.urbanist(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: ConstColors.serviceHighlightColor),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
