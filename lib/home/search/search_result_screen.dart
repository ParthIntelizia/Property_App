import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:luxepass/constants/const_variables.dart';
import 'package:luxepass/home/search/widgets/search_date_member_widget.dart';
import 'package:luxepass/utils/navigator.dart';
import 'package:provider/provider.dart';

import '../../constants/constant_colors.dart';
import '../../constants/constant_widgets.dart';
import '../../models/service_model.dart';
import '../../providers/search_screen_provider.dart';
import '../widgets/search_result_item_widget.dart';

class SearchResultPage extends StatefulWidget {
  const SearchResultPage({Key? key}) : super(key: key);

  @override
  State<SearchResultPage> createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage>
    with SingleTickerProviderStateMixin {
  TabController? _homePageTabController;
  ConstWidgets constWidgets = ConstWidgets();

  List<String> crouselImage = [
    "assets/login_corosal_img/img1.jpg",
    "assets/login_corosal_img/img2.jpg",
    "assets/login_corosal_img/img3.jpg"
  ];


  @override
  void initState() {
    _homePageTabController = TabController(length: 5, vsync: this);
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
    SearchScreenProvider searchScreenProvider = Provider.of<SearchScreenProvider>(context);
    var width = MediaQuery.of(context).size.width;
    var safearea = MediaQuery.of(context).padding.top;

    var title="${searchScreenProvider.selectedDate}. ${searchScreenProvider.selectedAdults} Adults  ${searchScreenProvider.selectedChildren} Child ";

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
              color:searchScreenProvider.isEdit?Colors.white: ConstColors.lightColor,
              child: Column(
                children: [
                  SizedBox(
                    height: safearea,
                  ),
                  SizedBox(
                    width: width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon:  Icon(Icons.arrow_back_ios,size: 16,
                                color:searchScreenProvider.isEdit?Colors.black: Colors.white)),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: SizedBox(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                constWidgets.textWidget("Spa | New Delhi",
                                    FontWeight.w700, 20, searchScreenProvider.isEdit?Colors.black: Colors.white),
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
                                            searchScreenProvider.isEdit?Colors.black: Colors.white),
                                      ),
                                      GestureDetector(
                                        onTap: (){
                                          searchScreenProvider.setEditTrue();
                                        },
                                        child: Container(
                                          color: ConstColors.darkColor,
                                          padding: const EdgeInsets.fromLTRB(
                                              10.0, 5.0, 10.0, 5.0),
                                          height: 25,
                                          child: Row(children: [
                                            constWidgets.textWidget(
                                                "Edit",
                                                FontWeight.w700,
                                                12,
                                                Colors.white),
                                             Icon(
                                              searchScreenProvider.isEdit?  Icons.keyboard_arrow_up_outlined:Icons.keyboard_arrow_down_outlined,
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
                    ),
                  ),
                ],
              ),
            )),
            SliverToBoxAdapter(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                   if (searchScreenProvider.isEdit)   const SearchDateMemberWidget(),
                    Container(
                      padding: const EdgeInsets.fromLTRB(
                          40.0, 5.0, 0.0, 10.0),
                      color:searchScreenProvider.isEdit?Colors.white: ConstColors.lightColor,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Row(children: [
                              const Icon(
                                Icons.filter_list_sharp,
                                color: ConstColors.darkColor,
                                size: 16,
                              ),
                              constWidgets.textWidget("All Filters",
                                  FontWeight.w700, 14, searchScreenProvider.isEdit?Colors.black: Colors.white),
                            ]),
                          ),
                          SizedBox(
                              height: 35,
                              child: ListView(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                children: [
                                  selectedFilter(
                                      "Poll Access", Icons.pool),
                                  selectedFilter(
                                      "Spa Circuit", Icons.spa),

                                ],
                              ))
                        ],
                      ),
                    ),
                    Container(
                      height: 1.5,
                      width: MediaQuery.of(context).size.width,
                      color: ConstColors.widgetDividerColor,
                    )
                  ],
                ),
              ),
            ),
          ];
        },
        body: allCategories(searchScreenProvider.allServices!),
      ),

      // child: Expanded(
      //   flex: 1,
      //   child: SingleChildScrollView(
      //     physics: const BouncingScrollPhysics(),
      //     child: Column(
      //       mainAxisSize: MainAxisSize.max,
      //       crossAxisAlignment: CrossAxisAlignment.stretch,
      //       children: [
      //         SizedBox(
      //           height: safearea,
      //         ),
      //         SizedBox(
      //           width: width,
      //           child: Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: [
      //               Padding(
      //                 padding: const EdgeInsets.only(left: 15),
      //                 child: SizedBox(
      //                   child: Row(
      //                     mainAxisSize: MainAxisSize.min,
      //                     children: [
      //                       const CircleAvatar(
      //                           minRadius: 20,
      //                           backgroundImage:
      //                               AssetImage('assets/profilepic.jpg')),
      //                       constWidgets.textWidget(" 👏 Hello, Naman",
      //                           FontWeight.w700, 20, ConstColors.userTitleColor),
      //                     ],
      //                   ),
      //                 ),
      //               ),
      //               const Padding(
      //                 padding: EdgeInsets.only(right: 15),
      //                 child: Icon(
      //                   Icons.notifications_none_rounded,
      //                   color: ConstColors.lightColor,
      //                   size: 20,
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ),
      //         InkWell(
      //           onTap: () {
      //             Navigator.push(
      //                 context,
      //                 MaterialPageRoute(
      //                     builder: (context) => const SearchScreen()));
      //           },
      //           child: const SearchWidget(
      //               title: "Spa, Gym, Pool & More",
      //               highlight: "Any Day | Any Where | Add Guest"),
      //         ),
      //         Row(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: [
      //             TabBar(
      //               tabs: myTabs,
      //               isScrollable: true,
      //               indicator: const UnderlineTabIndicator(
      //                   borderSide: BorderSide(
      //                       width: 3.0,
      //                       color: ConstColors.homePageTabLightColor)),
      //               indicatorSize: TabBarIndicatorSize.label,
      //               physics: const BouncingScrollPhysics(),
      //               controller: _homePageTabController,
      //             ),
      //           ],
      //         ),
      //         Container(
      //           height: 1.5,
      //           width: MediaQuery.of(context).size.width,
      //           color: ConstColors.widgetDividerColor,
      //         ),
      //         Container(
      //           child: SizedBox(
      //             height: 800,
      //               child: TabBarView(
      //                   controller: _homePageTabController,
      //                   physics: const NeverScrollableScrollPhysics(),
      //                   children: [
      //                     allCategories(homeProvider.allServices!),
      //                     const SizedBox(),
      //                     const SizedBox(),
      //                     const SizedBox(),
      //                     const SizedBox()
      //                   ])),
      //         ),
      //       ],
      //     )
      //   ),
      // ),
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

  Widget allCategories(List<ServiceModel> services) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: services.length,
        itemBuilder: (context, index) {
          return InkWell(

            child: SearchResultWidget(
              title: services[index].title!,
              image: services[index].image!,
              location: services[index].location!,
              highlight1: services[index].highlight1!,
              highlight2: services[index].highlight2!,
              price: services[index].price!,
            ),
            onTap: () {
              MyNavigator.goToEventDetailsScreen(context);
            },
          );
        });
  }


}
