
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/const_variables.dart';
import '../../constants/constant_colors.dart';
import '../../constants/constant_widgets.dart';
import '../../utils/navigator.dart';



class MyLocation extends StatefulWidget {
  const MyLocation({Key? key}) : super(key: key);

  @override
  _MyLocationState createState() => _MyLocationState();
}


class _MyLocationState extends State<MyLocation> {

  ConstWidgets constWidgets = ConstWidgets();
  String location ='';
  String city = '';

  List<Placemark> placeMarks=[];




  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }
  Future<void> getAddressFromLatLong(Position position)async {
    placeMarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placeMarks[0];
    city=place.locality!;
    location=place.subLocality!;
    setState(()  {
    });
  }






  @override
  void initState() {
    super.initState();
    getUserCurrent();

  }


  @override
  Widget build(BuildContext context) {

    return SafeArea(
        child: Scaffold(
          backgroundColor: ConstColors.backgroundColor,
          body: _body(),
        ));

  }


  _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter modalSetState){
                return AlertDialog(
                  content: SizedBox(
                    width: double.maxFinite,
                    height: 360.0,
                    child:  Column(
                      children: <Widget>[

                        Expanded(
                          child: placeMarks.isNotEmpty
                              ? ListView.builder(
                            itemCount: placeMarks.length,
                            itemBuilder: (context, i) {

                              Placemark place = placeMarks[i];
                              String address = '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';

                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    city=place.locality!;
                                    location=place.subLocality!;
                                  });
                                  Navigator.pop(context);
                                },
                                child: Card(
                                  margin: const EdgeInsets.all(6.0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child:  Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left:8.0,right: 10.0),
                                          child: Text(
                                            address,
                                            maxLines: 5,
                                            style: GoogleFonts.urbanist(
                                                fontWeight: FontWeight.w400, fontSize: 14, color: Colors.black),
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: true,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                              :   Padding(
                            padding: const EdgeInsets.only(top: 15,bottom: 15.0),
                            child:   constWidgets.textWidget("Allow Your Location From Setting",
                                FontWeight.w600, 18, Colors.grey),

                          ),
                        ),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    GestureDetector(
                      onTap: (){
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5.0),
                        child:  const Text('CANCEL'),

                      ),
                    )
                  ],
                );
              });
        });


  }


  getUserCurrent() async {
    Position position = await _getGeoLocationPosition();
    location ='Lat: ${position.latitude} , Long: ${position.longitude}';
    getAddressFromLatLong(position);
  }

  Widget _body() {
    var width = MediaQuery.of(context).size.width;
    var safearea = MediaQuery.of(context).padding.top;
  return  Container(
      constraints: const BoxConstraints.expand(),
      padding: const EdgeInsets.fromLTRB(20.0, 100.0, 20.0, 0.0),
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(ConstVar.backgroundImg), fit: BoxFit.cover),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 25.0,bottom: 10.0),
              width: width-40,
              child: Center(
                child: Column(
                  children: [
                    Container(
                        width: 200,
                        height: 150,
                      margin: const EdgeInsets.only(top: 10.0,bottom: 10.0),
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/map_with_location_icon.jpg"), fit: BoxFit.contain),
                      )),
                    constWidgets.textWidget("Select Your Location",
                        FontWeight.w800, 22, Colors.black),

                    Padding(
                      padding: const EdgeInsets.only(top: 15,bottom: 15.0),
                      child:   constWidgets.textWidget("Allow Your Location ",
                          FontWeight.w600, 18, Colors.grey),

                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20.0),
                      width: width-40,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          constWidgets.textWidget("Your Area ",
                              FontWeight.w600, 18, Colors.grey),

                          GestureDetector(
                            onTap: (){
                              _displayDialog(context);
                            },
                            child: SizedBox(
                              width: width-40,
                              height: 60,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  constWidgets.textWidget(location,
                                      FontWeight.w600, 18, Colors.black),
                                  const Icon(
                                    Icons.keyboard_arrow_down_outlined,
                                    color: Colors.grey,
                                    size: 16,
                                  )

                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 1.5,
                            width: MediaQuery.of(context).size.width,
                            color: ConstColors.widgetDividerColor,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20.0),
                      width: width-40,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          constWidgets.textWidget("Your City",
                              FontWeight.w600, 18, Colors.grey),

                          GestureDetector(
                            onTap: (){
                              _displayDialog(context);
                            },
                            child: SizedBox(
                              width: width-40,
                              height: 60,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  constWidgets.textWidget(city,
                                      FontWeight.w600, 18, Colors.black),
                                  const Icon(
                                    Icons.keyboard_arrow_down_outlined,
                                    color: Colors.grey,
                                    size: 16,
                                  )

                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 1.5,
                            width: MediaQuery.of(context).size.width,
                            color: ConstColors.widgetDividerColor,
                          ),

                          GestureDetector(
                            onTap: (){
                                MyNavigator.goToHome(context);

                            },
                            child: Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width - 30,
                                margin: const EdgeInsets.only(top: 15.0),
                                decoration: const BoxDecoration(
                                    color: ConstColors.lightColor,
                                    borderRadius: BorderRadius.all(Radius.circular(25))),
                                child: Center(
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        constWidgets.textWidget(
                                            "Next", FontWeight.w700, 18, Colors.white),

                                      ]),
                                )),
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),




          ],
        ),
      ),

    );

  }
}
