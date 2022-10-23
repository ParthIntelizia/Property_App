import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luxepass/constants/constant_colors.dart';

import '../../constants/constant_widgets.dart';

class SearchResultWidget extends StatefulWidget {
  final String title;
  final String image;
  final String location;
  final String highlight1;
  final String highlight2;
  final int price;
  const SearchResultWidget(
      {Key? key,
        required this.title,
        required this.image,
        required this.location,
        required this.highlight1,
        required this.highlight2,
        required this.price})
      : super(key: key);

  @override
  State<SearchResultWidget> createState() => _SearchResultWidgetState();
}

class _SearchResultWidgetState extends State<SearchResultWidget> {
  ConstWidgets constWidgets = ConstWidgets();

  List<String> crouselImage = [
    "assets/login_corosal_img/img1.jpg",
    "assets/login_corosal_img/img2.jpg",
    "assets/login_corosal_img/img3.jpg"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffF2F6F5),
      padding:  const EdgeInsets.all( 10.0),
      child: Container(
        decoration: BoxDecoration(
          color:Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                CarouselSlider.builder(
                  itemCount: 3,
                  itemBuilder: (BuildContext context, int itemIndex,
                      int pageViewIndex) =>
                      SizedBox(
                        height: 400,
                        width: MediaQuery.of(context).size.width,
                        child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(10),
                                topLeft: Radius.circular(10)),
                          child: Image.asset(crouselImage[itemIndex],
                              fit: BoxFit.fill),
                        ),
                      ),
                  options: CarouselOptions(
                    autoPlay: false,
                    enlargeCenterPage: true,
                    initialPage: 1,
                  ),
                ),
                // ClipRRect(
                //   borderRadius: const BorderRadius.only(
                //       topRight: Radius.circular(10),
                //       topLeft: Radius.circular(10)),
                //   child: SizedBox(
                //     child: Image.asset(
                //       widget.image,
                //       fit: BoxFit.fill,
                //     ),
                //   ),
                // ),
                Positioned(
                    top: 7,
                    right: 7,
                    child: SizedBox(
                      width: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                color: const Color.fromRGBO(0, 0, 0, 0.44),
                                borderRadius: BorderRadius.circular(3)),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                constWidgets.textWidget(
                                    "⭐ 4.2",
                                    FontWeight.w600,
                                    12,
                                    const Color.fromRGBO(255, 255, 255, 1)),
                              ],
                            ),
                          ),
                          Container(
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                  color: const Color.fromRGBO(0, 0, 0, 0.44),
                                  borderRadius: BorderRadius.circular(30)),
                              child: const Icon(Icons.heart_broken_outlined,
                                  size: 13,
                                  color: Color.fromRGBO(255, 255, 255, 1)))
                        ],
                      ),
                    ))
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 10, left: 10, right: 10, bottom: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  constWidgets.textWidget(widget.title, FontWeight.w700, 15,
                      ConstColors.serviceTitleColor),
                  const SizedBox(height: 3),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.location_pin,
                          size: 12, color: ConstColors.lightColor),
                      const SizedBox(width: 3),
                      constWidgets.textWidget(widget.location,
                          FontWeight.w600, 14, ConstColors.lightColor),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.check_sharp,
                          size: 12, color: Color.fromRGBO(51, 205, 155, 1)),
                      const SizedBox(width: 3),
                      constWidgets.textWidget(
                          widget.highlight1,
                          FontWeight.w500,
                          13,
                          ConstColors.serviceHighlightColor),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.check_sharp,
                          size: 12, color: Color.fromRGBO(51, 205, 155, 1)),
                      const SizedBox(width: 3),
                      constWidgets.textWidget(
                          widget.highlight1,
                          FontWeight.w500,
                          13,
                          ConstColors.serviceHighlightColor),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          height: 1,
                          width: 300,
                          margin: const EdgeInsets.only(top: 10.0,),
                          color: const Color.fromRGBO(199, 199, 199, 1)),
                    ],
                  ),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: 'From ',
                        style: GoogleFonts.urbanist(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            color: ConstColors.serviceRateStatmentColor),
                        children: [
                          TextSpan(
                            text: '${widget.price.toString()}/- ',
                            style: GoogleFonts.urbanist(
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                                color: ConstColors.servicePriceColor),
                          ),
                          TextSpan(
                            text: 'Per 1 Person',
                            style: GoogleFonts.urbanist(
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                                color: const Color.fromRGBO(31, 31, 31, 1)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
