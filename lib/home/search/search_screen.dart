import 'package:flutter/material.dart';
import 'package:luxepass/utils/navigator.dart';
import 'package:provider/provider.dart';

import '../../constants/const_variables.dart';
import '../../constants/constant_colors.dart';
import '../../constants/constant_widgets.dart';
import '../../providers/search_screen_provider.dart';
import 'widgets/search_city.dart';
import 'widgets/search_date_member_widget.dart';
import 'widgets/search_suggestion_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  ConstWidgets constWidgets = ConstWidgets();
  @override
  void initState() {

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SearchScreenProvider _searchScreenProvider = Provider.of<SearchScreenProvider>(context);
    return SafeArea(
        child: Scaffold(
      backgroundColor: ConstColors.backgroundColor,
      body: _body(_searchScreenProvider),
    ));
  }

  Widget _body(SearchScreenProvider _searchScreenProvider) {
    var width = MediaQuery.of(context).size.width;
    var safearea = MediaQuery.of(context).padding.top;
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(ConstVar.backgroundImg), fit: BoxFit.cover),
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: safearea,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.arrow_back_ios,
                          color: Colors.black45, size: 18)),
                  constWidgets.logo(),
                  IconButton(
                      onPressed: () {},
                      icon:
                          const Icon(Icons.cancel, color: Colors.transparent)),
                ],
              ),
              Container(
                margin: const EdgeInsets.all(20),
                child: Material(
                  elevation: 10,
                  shadowColor: ConstColors.widgetDividerColor,
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white),
                    child: Column(children: [
                      const SearchCity(),
                      const SizedBox(
                        height: 35,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          SearchSuggestionWidget(
                              image: "assets/mumbai.png",
                              cityName: "Mumbai",
                              suggestionType: "city"),
                          SearchSuggestionWidget(
                              image: "assets/delhi.png",
                              cityName: "Delhi",
                              suggestionType: "city"),
                          SearchSuggestionWidget(
                              image: "assets/kerla.png",
                              cityName: "Kerla",
                              suggestionType: "city"),
                          SearchSuggestionWidget(
                              image: "assets/gujrat.png",
                              cityName: "Gujrat",
                              suggestionType: "city"),
                        ],
                      )
                    ]),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: Material(
                  elevation: 10,
                  shadowColor: ConstColors.widgetDividerColor,
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white),
                    child: Column(children: [
                      constWidgets.textWidget(
                          "Select Amenities",
                          FontWeight.w600,
                          20,
                          const Color.fromRGBO(0, 0, 0, 1)),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          SearchSuggestionWidget(
                              image: "assets/services/gym.png",
                              cityName: "Gym",
                              suggestionType: "amenities"),
                          SearchSuggestionWidget(
                              image: "assets/services/salon.png",
                              cityName: "Salon",
                              suggestionType: "amenities"),
                          SearchSuggestionWidget(
                              image: "assets/services/spa.png",
                              cityName: "Spa",
                              suggestionType: "amenities"),
                          SearchSuggestionWidget(
                              image: "assets/services/pool.png",
                              cityName: "Pool",
                              suggestionType: "amenities"),
                        ],
                      )
                    ]),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      _searchScreenProvider.clearAll();
                    },
                    child: SizedBox(
                      width: 100,
                      child: constWidgets.textWidget(
                          "Clear All",
                          FontWeight.w500,
                          18,
                          const Color.fromRGBO(137, 137, 137, 1)),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                    //  MyNavigator.gotoSearchResultPage(context);
                    },
                    child: Container(
                      width: 100,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: ConstColors.lightColor,
                          borderRadius: BorderRadius.circular(100)),
                      child: Center(
                        child: constWidgets.textWidget("Search", FontWeight.w600,
                            20, const Color.fromRGBO(255, 255, 255, 1)),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 150,
              )
            ]),
      ),
    );
  }
}
