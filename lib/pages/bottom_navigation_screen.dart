import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:luxepass/constants/constant_colors.dart';
import 'package:luxepass/pages/services_page.dart';
import 'package:luxepass/pages/user_profile_page.dart';
import '../home/home.dart';
import '../providers/navbar_provider.dart';
import '../services/locator_service.dart';
import 'discover_page.dart';
import 'my_wish_list_page.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  const BottomNavigationBarScreen({Key? key}) : super(key: key);
  @override
  _BottomNavigationBarState createState() => _BottomNavigationBarState();
}

class _BottomNavigationBarState extends State<BottomNavigationBarScreen>
    with WidgetsBindingObserver {
  final _bottomNavigationBarColor = Colors.white;
  bool checkConn = true;
  final List<Widget> _dynamicPageList = [];

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.paused:
        break;

      case AppLifecycleState.inactive:
        {
          print('inactive');
        }
        break;

      case AppLifecycleState.resumed:
        {
          print('resumed');
        }

        break;

      case AppLifecycleState.detached:
        print('detached');
        break;
    }
  }

  Future<void> checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      setState(() {
        checkConn = true;
      });
    } else if (connectivityResult == ConnectivityResult.wifi) {
      setState(() {
        checkConn = true;
      });
    } else {
      setState(() {
        checkConn = false;
      });
    }
  }

  @override
  void initState() {
    _getTokenForUser();
    checkConnection();
    _dynamicPageList
      ..add(const HomePage())
      ..add(const MyWishListPage())
      ..add(const ServicesPage())
      ..add(const DiscoverPage())
      ..add(const UserProfilePage());
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  Future<void> _getTokenForUser() async {}

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    checkConnection();
    var indexCounter = locator<NavBarIndex>().getCounter;
    return WillPopScope(
      onWillPop: () {
        return Future(() => false);
      },
      child: SafeArea(
        child: Scaffold(
            backgroundColor: ConstColors.backgroundColor,
            body: _body(indexCounter),
            bottomNavigationBar: BottomAppBar(
                color: ConstColors.backgroundColor,
                child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      IconButton(
                          icon: SvgPicture.asset('assets/icons/home.svg',
                              height: 23,
                              width: 23,
                              color: indexCounter == 0
                                  ? ConstColors.darkColor
                                  : Colors.grey),
                          iconSize: 22,
                          onPressed: () {
                            setNavBarIndex(context, 0);
                          }),
                      IconButton(
                          iconSize: 22,
                          icon: SvgPicture.asset('assets/icons/favourite.svg',
                              height: 26,
                              width: 26,
                              color: indexCounter == 1
                                  ? ConstColors.darkColor
                                  : Colors.grey),
                          onPressed: () {
                            setNavBarIndex(context, 1);
                          }),
                      IconButton(
                          iconSize: 22,
                          icon: SvgPicture.asset('assets/icons/services.svg',
                              height: 23,
                              width: 23,
                              color: indexCounter == 2
                                  ? ConstColors.darkColor
                                  : Colors.grey),
                          onPressed: () {
                            setNavBarIndex(context, 2);
                          }),
                      IconButton(
                          iconSize: 22,
                          icon: SvgPicture.asset('assets/icons/search.svg',
                              height: 24,
                              width: 24,
                              color: indexCounter == 3
                                  ? ConstColors.darkColor
                                  : Colors.grey),
                          onPressed: () {
                            setNavBarIndex(context, 3);
                          }),
                      IconButton(
                          iconSize: 22,
                          icon: SvgPicture.asset('assets/icons/profile.svg',
                              height: 23,
                              width: 23,
                              color: indexCounter == 4
                                  ? ConstColors.darkColor
                                  : Colors.grey),
                          onPressed: () {
                            setNavBarIndex(context, 4);
                          })
                    ]))),
      ),
    );
  }

  _body(int index) {
    return checkConn == true ? _dynamicPageList[index] : _connectionStatus();
  }

  void setNavBarIndex(BuildContext context, int index) {
    locator<NavBarIndex>().setTabCount(index);
  }

  _loading() {
    return Center(
      child: Container(
          height: 50.0,
          margin: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: const Center(
              child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xff0962ff)),
          ))),
    );
  }

  _connectionStatus() {
    return Center(
        child: Container(
            margin: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 200,
                ),
                Image.asset("assets/noconnection.png"),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "No Internet",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Nunito Sans',
                    fontSize: 35,
                    color: Color(0xFFBAC0C5),
                    fontWeight: FontWeight.w800,
                  ),
                )
              ],
            )));
  }
}
