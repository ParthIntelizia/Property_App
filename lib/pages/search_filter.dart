import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/common_widget.dart';
import '../constants/constant.dart';
import 'discover_page.dart';

class SearchFilter extends StatefulWidget {
  final searchText;

  const SearchFilter({super.key, required this.searchText});

  @override
  State<SearchFilter> createState() => _SearchFilterState();
}

class _SearchFilterState extends State<SearchFilter> {
  TextEditingController? searchController;

  List type = ["For sale", "To rent"];

  int typeSelected = 0;

  String radiusSelected = "This area only";

  List radius = [
    "This area only",
    "within 1/4 mile",
    "within 1/2 mile",
    "within 1 mile",
    "within 3 miles",
    "within 5 miles",
    "within 15 miles",
    "within 20 miles",
    "within 30 miles",
  ];

  String minBedroomSelected = "No min";

  List minBedrooms = [
    "No min",
    "Studio",
    "1",
    "2",
    "3",
    "4",
    "6",
    "7",
    "8",
    "9",
    "10",
  ];
  String maxBedroomSelected = "No max";

  List maxBedrooms = [
    "No max",
    "Studio",
    "1",
    "2",
    "3",
    "4",
    "6",
    "9",
    "10",
  ];
//"€"

  String minPriceSelected = "No min";

  List minPrice = [
    "No min",
    "€ 50,000",
    "€ 60,000",
    "€ 70,000",
    "€ 80,000",
    "€ 90,000",
    "€ 100,000",
    "€ 110,000",
    "€ 120,000",
    "€ 130,000",
    "€ 140,000",
    "€ 150,000",
    "€ 160,000",
  ];

  String maxPriceSelected = "No max";

  List maxPrice = [
    "No max",
    "€ 50,000",
    "€ 60,000",
    "€ 70,000",
    "€ 80,000",
    "€ 90,000",
    "€ 100,000",
    "€ 110,000",
    "€ 120,000",
    "€ 130,000",
    "€ 140,000",
    "€ 150,000",
    "€ 160,000",
  ];

  String dateAdded = "Added anytime";

  List dateAddedList = [
    "Added anytime",
    "Last 24 hours",
    "Last 3 days",
    "Last 7 days",
    "Last 14 days",
    "Last 30 days",
  ];

  bool isSwitched = false;
  bool isSwitched1 = false;
  bool isSwitched2 = false;
  bool isSwitched3 = false;
  bool isSwitched4 = false;
  bool isSwitched5 = false;

  int categorySelected = 0;

  List categories = [
    "All",
    "Detached",
    "Semi-\ndetached",
    "Terraced",
    "Flats",
    "Farms/land",
    "Bungalows",
    "Mobile/park\nhomes",
  ];

  List categoriesList = [];

  final keywordController = TextEditingController();

  @override
  void initState() {
    try {
      searchController = TextEditingController(text: widget.searchText);
    } catch (e) {
      searchController = TextEditingController();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(
            thickness: 1,
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    isSwitched = false;
                    isSwitched1 = false;
                    isSwitched2 = false;
                    isSwitched3 = false;
                    isSwitched4 = false;
                    isSwitched5 = false;

                    categorySelected = 0;
                    dateAdded = "Added anytime";
                    maxPriceSelected = "No max";
                    minPriceSelected = "No min";
                    maxBedroomSelected = "No max";
                    minBedroomSelected = "No min";
                    radiusSelected = "This area only";

                    typeSelected = 0;

                    categoriesList = [];

                    setState(() {});
                  },
                  child: Container(
                    height: 45,
                    width: Get.width * 0.42,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        border: Border.all(
                          color: themColors309D9D,
                        )),
                    child: Center(
                      child: CommonWidget.textBoldWight500(
                          text: "Clear",
                          fontSize: 15,
                          color: Colors.grey.shade400),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.to(
                      () => DiscoverPage(
                        searchData: searchController!.text.trim(),
                      ),
                    );
                  },
                  child: Container(
                    height: 45,
                    width: Get.width * 0.42,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      //color: themColors309D9D,
                      color: Color(0xff254794),
                    ),
                    child: Center(
                      child: CommonWidget.textBoldWight500(
                          text: "Search", fontSize: 15, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 50,
                  child: TextFormField(
                    //autofocus: true,
                    controller: searchController,
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
                            Get.back();
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                          ),
                        )),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                        2,
                        (index) => GestureDetector(
                              onTap: () {
                                setState(() {
                                  typeSelected = index;
                                });
                              },
                              child: Container(
                                height: 45,
                                width: Get.width * 0.44,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  color: typeSelected == index
                                      ? themColors309D9D
                                      : Colors.grey.shade200,
                                ),
                                child: Center(
                                  child: CommonWidget.textBoldWight500(
                                      text: type[index],
                                      fontSize: 15,
                                      color: typeSelected == index
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ),
                            )),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                CommonWidget.textBoldWight500(
                    fontWeight: FontWeight.w400,
                    text: "Search radius",
                    fontSize: 15,
                    color: Colors.grey),
                DropdownButton(
                  isExpanded: true,
                  //menuMaxHeight: 20,

                  iconEnabledColor: Colors.grey.shade700,
                  iconDisabledColor: Colors.black,
                  icon: Icon(Icons.arrow_drop_down_outlined),
                  value: radiusSelected,
                  items: radius.map((e) {
                    return DropdownMenuItem(
                      value: e,
                      child: CommonWidget.textBoldWight500(
                          fontWeight: FontWeight.w400,
                          text: e.toString(),
                          fontSize: 15),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      radiusSelected = value as String;
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                CommonWidget.textBoldWight500(
                    fontWeight: FontWeight.w400,
                    text: "Bedroom",
                    fontSize: 15,
                    color: Colors.grey),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: Get.width * 0.40,
                      child: DropdownButton(
                        isExpanded: true,
                        //menuMaxHeight: 20,

                        iconEnabledColor: Colors.grey.shade700,
                        iconDisabledColor: Colors.black,
                        icon: Icon(Icons.arrow_drop_down_outlined),
                        value: minBedroomSelected,
                        items: minBedrooms.map((e) {
                          return DropdownMenuItem(
                            value: e,
                            child: CommonWidget.textBoldWight500(
                                fontWeight: FontWeight.w400,
                                text: e.toString(),
                                fontSize: 15),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            minBedroomSelected = value as String;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      width: Get.width * 0.40,
                      child: DropdownButton(
                        isExpanded: true,
                        //menuMaxHeight: 20,

                        iconEnabledColor: Colors.grey.shade700,
                        iconDisabledColor: Colors.black,
                        icon: Icon(Icons.arrow_drop_down_outlined),
                        value: maxBedroomSelected,
                        items: maxBedrooms.map((e) {
                          return DropdownMenuItem(
                            value: e,
                            child: CommonWidget.textBoldWight500(
                                fontWeight: FontWeight.w400,
                                text: e.toString(),
                                fontSize: 15),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            maxBedroomSelected = value as String;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                CommonWidget.textBoldWight500(
                    fontWeight: FontWeight.w400,
                    text: "Price range",
                    fontSize: 15,
                    color: Colors.grey),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: Get.width * 0.40,
                      child: DropdownButton(
                        isExpanded: true,
                        //menuMaxHeight: 20,

                        iconEnabledColor: Colors.grey.shade700,
                        iconDisabledColor: Colors.black,
                        icon: Icon(Icons.arrow_drop_down_outlined),
                        value: minPriceSelected,
                        items: minPrice.map((e) {
                          return DropdownMenuItem(
                            value: e,
                            child: CommonWidget.textBoldWight500(
                                fontWeight: FontWeight.w400,
                                text: "${e.toString()}",
                                fontSize: 15),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            minPriceSelected = value as String;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      width: Get.width * 0.40,
                      child: DropdownButton(
                        isExpanded: true,
                        //menuMaxHeight: 20,

                        iconEnabledColor: Colors.grey.shade700,
                        iconDisabledColor: Colors.black,
                        icon: Icon(Icons.arrow_drop_down_outlined),
                        value: maxPriceSelected,
                        items: maxPrice.map((e) {
                          return DropdownMenuItem(
                            value: e,
                            child: CommonWidget.textBoldWight500(
                                fontWeight: FontWeight.w400,
                                text: "${e.toString()}",
                                fontSize: 15),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            maxPriceSelected = value as String;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                CommonWidget.textBoldWight500(
                    fontWeight: FontWeight.w400,
                    text: "Date added",
                    fontSize: 15,
                    color: Colors.grey),
                DropdownButton(
                  isExpanded: true,
                  //menuMaxHeight: 20,

                  iconEnabledColor: Colors.grey.shade700,
                  iconDisabledColor: Colors.black,
                  icon: Icon(Icons.arrow_drop_down_outlined),
                  value: dateAdded,
                  items: dateAddedList.map((e) {
                    return DropdownMenuItem(
                      value: e,
                      child: CommonWidget.textBoldWight500(
                          fontWeight: FontWeight.w400,
                          text: e.toString(),
                          fontSize: 15),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      dateAdded = value as String;
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonWidget.textBoldWight500(
                        fontWeight: FontWeight.w400,
                        text: "New build homes only",
                        fontSize: 15,
                        color: Colors.black),
                    Switch(
                      activeColor: themColors309D9D,
                      value: isSwitched,
                      onChanged: (value) {
                        setState(() {
                          isSwitched = value;
                        });
                      },
                    )
                  ],
                ),
                Divider(
                  height: 5,
                  thickness: 1,
                ),
                SizedBox(
                  height: 20,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      categories.length,
                      (index) => GestureDetector(
                        onTap: () {
                          categorySelected = index;

                          setState(() {
                            if (categoriesList.contains(categories[index])) {
                              categoriesList.remove(categories[index]);
                            } else {
                              categoriesList.add(categories[index]);
                            }
                          });
                        },
                        child: Container(
                          height: Get.width * 0.23,
                          width: Get.width * 0.23,
                          margin: EdgeInsets.only(right: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            //color: themColors309D9D,
                            color: categoriesList.contains(categories[index])
                                ? Color(0xff254794)
                                : Colors.transparent,
                            border: Border.all(
                                color:
                                    categoriesList.contains(categories[index])
                                        ? Colors.transparent
                                        : Colors.grey),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CommonWidget.textBoldWight500(
                                  text: categories[index],
                                  fontSize: 12,
                                  color:
                                      categoriesList.contains(categories[index])
                                          ? Colors.white
                                          : Colors.black),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                CommonWidget.textBoldWight500(
                    fontWeight: FontWeight.w500, text: "Include", fontSize: 18),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonWidget.textBoldWight500(
                        fontWeight: FontWeight.w400,
                        text: "Shared ownership",
                        fontSize: 15,
                        color: Colors.black),
                    Switch(
                      activeColor: themColors309D9D,
                      value: isSwitched1,
                      onChanged: (value) {
                        setState(() {
                          isSwitched1 = value;
                        });
                      },
                    )
                  ],
                ),
                Divider(
                  height: 5,
                  thickness: 1,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonWidget.textBoldWight500(
                        fontWeight: FontWeight.w400,
                        text: "Retirement homes",
                        fontSize: 15,
                        color: Colors.black),
                    Switch(
                      activeColor: themColors309D9D,
                      value: isSwitched2,
                      onChanged: (value) {
                        setState(() {
                          isSwitched2 = value;
                        });
                      },
                    )
                  ],
                ),
                Divider(
                  height: 5,
                  thickness: 1,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonWidget.textBoldWight500(
                        fontWeight: FontWeight.w400,
                        text: "Auction",
                        fontSize: 15,
                        color: Colors.black),
                    Switch(
                      activeColor: themColors309D9D,
                      value: isSwitched3,
                      onChanged: (value) {
                        setState(() {
                          isSwitched3 = value;
                        });
                      },
                    )
                  ],
                ),
                Divider(
                  height: 5,
                  thickness: 1,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonWidget.textBoldWight500(
                        fontWeight: FontWeight.w400,
                        text: "Under offer or sold STC",
                        fontSize: 15,
                        color: Colors.black),
                    Switch(
                      activeColor: themColors309D9D,
                      value: isSwitched4,
                      onChanged: (value) {
                        setState(() {
                          isSwitched4 = value;
                        });
                      },
                    )
                  ],
                ),
                Divider(
                  height: 5,
                  thickness: 1,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonWidget.textBoldWight500(
                        fontWeight: FontWeight.w400,
                        text: "New build homes",
                        fontSize: 15,
                        color: Colors.black),
                    Switch(
                      activeColor: themColors309D9D,
                      value: isSwitched5,
                      onChanged: (value) {
                        setState(() {
                          isSwitched5 = value;
                        });
                      },
                    )
                  ],
                ),
                Divider(
                  height: 5,
                  thickness: 1,
                ),
                SizedBox(
                  height: 30,
                ),
                CommonWidget.textBoldWight500(
                    fontWeight: FontWeight.w500, text: "Keyword", fontSize: 18),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 50,
                  child: TextFormField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(top: 10, left: 10),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: themColors309D9D),
                      ),
                      hintText: "e.g. 'garden' or 'wooden floors'",
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                CommonWidget.textBoldWight500(
                  fontWeight: FontWeight.w400,
                  text:
                      """Search for phrases using quotation marks e.g."double\ngarage", or exclude terms by prefixing them with a minus\nsign e.g. "-studio" """,
                  fontSize: 12,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
