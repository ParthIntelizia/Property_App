
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:luxepass/constants/const_variables.dart';
import 'package:luxepass/home/search/widgets/search_date_member_widget.dart';
import 'package:luxepass/home/widgets/coupan_applied_widget.dart';
import 'package:luxepass/home/widgets/schedule_item_widget.dart';
import 'package:provider/provider.dart';

import '../../constants/constant_colors.dart';
import '../../constants/constant_widgets.dart';
import '../../providers/search_screen_provider.dart';
import '../home/widgets/review_service_item_widget.dart';


class ReviewBookingPagePage extends StatefulWidget {
  const ReviewBookingPagePage({Key? key}) : super(key: key);

  @override
  State<ReviewBookingPagePage> createState() => _ReviewBookingPagePageState();
}

class _ReviewBookingPagePageState extends State<ReviewBookingPagePage>
    with SingleTickerProviderStateMixin {

  ConstWidgets constWidgets = ConstWidgets();

  @override
  void initState() {
    super.initState();
  }

  List<String> crouselImage = [
    "assets/login_corosal_img/img1.jpg",
    "assets/login_corosal_img/img2.jpg",
    "assets/login_corosal_img/img3.jpg"
  ];

  List<String> keyPoints = [
    "Swan Necks",
    "Steam Shower",
    "Cold Water ",
    "Ice Fountain",
    "Salt Cabin",
    "Relaxation Area "
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: ConstColors.backgroundColor,
          body: _body(),
        ));
  }

  Widget _body() {
    SearchScreenProvider searchScreenProvider = Provider.of<SearchScreenProvider>(context);
    var width = MediaQuery.of(context).size.width;
    var safeArea = MediaQuery.of(context).padding.top;

    var title =
        "${searchScreenProvider.selectedDate}. ${searchScreenProvider.selectedAdults} Adults  ${searchScreenProvider.selectedChildren} Child ";

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
                  color: searchScreenProvider.isEdit
                      ? Colors.white
                      : ConstColors.lightColor,
                  child: Column(
                    children: [
                      SizedBox(
                        height: safeArea,
                      ),
                      SizedBox(
                        width: width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon:  Icon(Icons.arrow_back_ios,
                                        size: 16, color: searchScreenProvider.isEdit
                                            ? Colors.black
                                            : Colors.white)),
                                Padding(
                                  padding:
                                  const EdgeInsets.only(left: 10, bottom: 10.0),
                                  child: SizedBox(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        constWidgets.textWidget(
                                            "Review Booking",
                                            FontWeight.w700,
                                            20,
                                            searchScreenProvider.isEdit
                                                ? Colors.black
                                                : Colors.white),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 8.0),
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(
                                                    0.0, 5.0, 10.0, 5.0),
                                                child: constWidgets.textWidget(
                                                    title,
                                                    FontWeight.w700,
                                                    12,
                                                    searchScreenProvider.isEdit
                                                        ? Colors.black
                                                        : Colors.white),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  searchScreenProvider
                                                      .setEditTrue();
                                                },
                                                child: Container(
                                                  color: ConstColors.darkColor,
                                                  padding:
                                                  const EdgeInsets.fromLTRB(
                                                      10.0, 5.0, 10.0, 5.0),
                                                  height: 25,
                                                  child: Row(children: [
                                                    constWidgets.textWidget(
                                                        "Edit",
                                                        FontWeight.w700,
                                                        12,
                                                        Colors.white),
                                                    Icon(
                                                      searchScreenProvider.isEdit
                                                          ? Icons
                                                          .keyboard_arrow_up_outlined
                                                          : Icons
                                                          .keyboard_arrow_down_outlined,
                                                      color: Colors.white,
                                                      size: 12,
                                                    ),
                                                  ]),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
            SliverToBoxAdapter(
              child: (searchScreenProvider.isEdit)?
              const SearchDateMemberWidget():const SizedBox(),
            ),
          ];
        },
        body: _descriptionWidget(),
      ),
    );
  }

  Widget selectedFilter(String text, IconData icon) {
    return Container(
      color: ConstColors.darkColor,
      padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
      margin: const EdgeInsets.all(5.0),
      height: 35,
      child: Row(children: [
        Icon(
          icon,
          color: Colors.white,
          size: 14,
        ),
        constWidgets.textWidget(text, FontWeight.w700, 14, Colors.white),
      ]),
    );
  }

  Widget _descriptionWidget() {
    SearchScreenProvider searchScreenProvider = Provider.of<SearchScreenProvider>(context, listen: false);
    var title =
        "${searchScreenProvider.selectedDate}. ${searchScreenProvider.selectedAdults} Adults  ${searchScreenProvider.selectedChildren} Child ";

    return Container(
      padding: const EdgeInsets.all(15.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 15.0,top: 5.0),
                child: ReviewServiceItemWidget(memberCount:title)),
            Container(
                margin: const EdgeInsets.only(bottom: 15.0,top: 5.0),
                child: const ScheduleItemWidget()),
            Container(
                margin: const EdgeInsets.only(bottom: 15.0,top: 5.0),
                child: const CouponAppliedWidget()),
            Container(
              height: 1.5,
              margin: const EdgeInsets.only(top: 20.0),
              width: MediaQuery.of(context).size.width,
              color: ConstColors.widgetDividerColor,
            ),
            ListTile(
              title: constWidgets.textWidget(
                  "Resort Rule ", FontWeight.w700, 16, Colors.black),
              trailing: const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.grey,
                size: 12,
              ),
            ),
            Container(
              height: 1.5,
              width: MediaQuery.of(context).size.width,
              color: ConstColors.widgetDividerColor,
            ),
            ListTile(
              title: constWidgets.textWidget("Cancellation Policy ",
                  FontWeight.w700, 16, Colors.black),
              trailing: const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.grey,
                size: 12,
              ),
            ),
            Container(
              height: 1.5,
              margin: const EdgeInsets.only(bottom: 25.0),
              width: MediaQuery.of(context).size.width,
              color: ConstColors.widgetDividerColor,
            ),

          ],
        ),
      ),
    );
  }
}
