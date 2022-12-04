import 'package:flutter/material.dart';
import 'package:luxepass/constants/common_widget.dart';
import 'package:luxepass/constants/constant.dart';
import 'package:get/get.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:luxepass/pages/search_filter.dart';
import '../models/google_api_repo.dart';
import '../providers/serach_screen_controller.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final searchController = TextEditingController();

  String kGoogleApiKey = 'AIzaSyBLjgELUHE9X1z5OI0if3tMRDG5nWK2Rt8';
  PlaceApi _placeApi = PlaceApi.instance;

  SerachController _serachController = Get.put(SerachController());

  bool buscando = false;

  List<Place> _predictions = [];
  final homeScaffoldKey = GlobalKey<ScaffoldState>();

  final Mode _mode = Mode.overlay;

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
                  onChanged: (query) {
                    if (query.trim().length > 2) {
                      setState(() {
                        buscando = true;
                      });
                      _placeApi
                          .searchPredictions(query)
                          .asStream()
                          .listen((List<Place> predictions) {
                        buscando = false;
                        _predictions = predictions ?? [];
                        //  print('Resultados: ${predictions.length}');
                      });
                      setState(() {});
                    } else {
                      if (buscando || _predictions.length > 0) {
                        setState(() {
                          buscando = false;
                          _predictions = [];
                        });
                      }
                    }
                    setState(() {});
                  },
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
                        //_handlePressButton();
                        // Get.to(
                        //   () => SearchFilter(searchText: searchController.text),
                        // );
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
              CommonWidget.commonSizedBox(height: 10),
              Expanded(
                child: searchController.text.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: _predictions.length,
                        itemBuilder: (_, i) {
                          final Place item = _predictions[i];
                          return ListTile(
                            onTap: () {
                              try {
                                print(
                                    'all get address for  ${item.structuredFormatting['main_text']}');
                                List structuredFormatting = item
                                    .structuredFormatting['secondary_text']
                                    .toString()
                                    .split(',');

                                print(
                                    'all strat of uiuiuiuib    ${structuredFormatting.length}  country ');
                                List itm = item.description!.split(',');
                                print('last but not list  ${itm.last}');
                                int count = itm.length - 2;

                                print('last but not list $count  $itm');

                                if (structuredFormatting.length == 2) {
                                  _serachController.address1 =
                                      item.structuredFormatting['main_text'];

                                  print(
                                      "ADDRESS==>>${item.structuredFormatting['main_text']}");

                                  _serachController.state = '';
                                  _serachController.city =
                                      structuredFormatting.first;
                                } else if (structuredFormatting.length == 1) {
                                  _serachController.address1 =
                                      item.structuredFormatting['main_text'];
                                  _serachController.state = '';
                                  _serachController.city = '';
                                } else {
                                  _serachController.address1 =
                                      item.structuredFormatting['main_text'];
                                  _serachController.state =
                                      structuredFormatting[
                                          structuredFormatting.length - 2];
                                  _serachController.city = structuredFormatting[
                                      structuredFormatting.length - 3];
                                }
                              } catch (e) {}
                              Get.to(
                                () => SearchFilter(
                                  ///searchText: item.description,
                                  searchText: searchController.text.trim(),
                                ),
                              );
                            },
                            title: Text(item.description!),
                          );
                        })
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                          Center(
                            child: CommonWidget.textBoldWight500(
                                text: "Find your next home", fontSize: 20),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: CommonWidget.textBoldWight500(
                                text:
                                    "Search listings for sale or to rent. Your",
                                fontSize: 15,
                                color: Colors.grey),
                          ),
                          Center(
                            child: CommonWidget.textBoldWight500(
                                text: "recent searches will appear here.",
                                fontSize: 15,
                                color: Colors.grey),
                          ),
                        ],
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handlePressButton() async {
    Prediction? p = await PlacesAutocomplete.show(
        context: context,
        apiKey: kGoogleApiKey,
        mode: _mode,
        language: 'in',
        strictbounds: false,
        types: [""],
        logo: SizedBox(),
        decoration: InputDecoration(
            hintText: 'Search',
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.white))),
        components: [
          Component(Component.country, "in"),
          // Component(Component.country, "in")
        ]);

    displayPrediction(p!, homeScaffoldKey.currentState);
  }

  Future<void> displayPrediction(
      Prediction p, ScaffoldState? currentState) async {
    print('pppppppp    ${p.description}');
    print('currentState    ${currentState}');
    GoogleMapsPlaces places = GoogleMapsPlaces(
        apiKey: kGoogleApiKey,
        apiHeaders: await const GoogleApiHeaders().getHeaders());

    PlacesDetailsResponse detail = await places.getDetailsByPlaceId(p.placeId!);

    final lat = detail.result.geometry!.location.lat;
    final lng = detail.result.geometry!.location.lng;
    print('get lat long by map $lat  $lng  ');

    setState(() {});
  }
}
