import 'package:flutter/material.dart';
import 'package:luxepass/constants/common_widget.dart';
import 'package:luxepass/constants/constant.dart';
import 'package:get/get.dart';
import 'package:luxepass/pages/search_filter.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 50,
                child: TextFormField(
                  controller: searchController,
                  autofocus: true,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: 10),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: themColors309D9D),
                    ),
                    hintText: "Search Property here",
                    prefixIcon: InkResponse(
                      onTap: () {
                        Get.to(
                          () => SearchFilter(searchText: searchController.text),
                        );
                      },
                      child: Icon(
                        Icons.search,
                        color: themColors309D9D,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonWidget.textBoldWight500(
                      text: "Recent Search", fontSize: 20),
                  CommonWidget.textBoldWight500(
                      text: "Clear", fontSize: 15, color: Colors.grey),
                ],
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Image.asset(
                        "assets/app_icon.png",
                        scale: 4,
                        color: themColors309D9D,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CommonWidget.textBoldWight500(
                        text: "Find your next home", fontSize: 20),
                    SizedBox(
                      height: 20,
                    ),
                    CommonWidget.textBoldWight500(
                        text: "Search listings for sale or to rent. Your",
                        fontSize: 15,
                        color: Colors.grey),
                    CommonWidget.textBoldWight500(
                        text: "recent searches will appear here.",
                        fontSize: 15,
                        color: Colors.grey),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
