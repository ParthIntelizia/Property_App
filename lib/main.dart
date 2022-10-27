import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:luxepass/constants/constant_colors.dart';
import 'package:luxepass/home/search/search_result_screen.dart';
import 'package:luxepass/pages/authentication/email_entry.dart';
import 'package:luxepass/pages/authentication/phone_authentication_screen.dart';
import 'package:luxepass/pages/authentication/signin.dart';
import 'package:luxepass/pages/bottom_navigation_screen.dart';
import 'package:luxepass/pages/property_details_screen.dart';
import 'package:luxepass/pages/review_booking_page.dart';
import 'package:luxepass/pages/set_profile_screen.dart';
import 'package:luxepass/pages/splash_screen.dart';
import 'package:luxepass/providers/my_booking_provider.dart';
import 'package:luxepass/providers/my_wish_list_provider.dart';
import 'package:luxepass/services/locator_service.dart';
import 'package:luxepass/services/navigation_service.dart';
import 'package:provider/provider.dart';
import 'providers/homepage_provider.dart';
import 'providers/navbar_provider.dart';
import 'providers/search_screen_provider.dart';

var routes = <String, WidgetBuilder>{
  "/home": (BuildContext context) => const BottomNavigationBarScreen(),
  "/signin": (BuildContext context) => const SignInScreen(),
  "/mobileAuth": (BuildContext context) => const PhoneAuthenticationScreen(),
  "/emailEntryScreen": (BuildContext context) => const EmailEntryScreen(),
  "/searchResult": (BuildContext context) => const SearchResultPage(),
  "/bookingReviewPage": (BuildContext context) => const ReviewBookingPagePage(),
  "/emailAuth": (BuildContext context) => const EmailEntryScreen(),
};

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  setupLocator();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => NavBarIndex(),
        ),
        ChangeNotifierProvider(
          create: (_) => HomeProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => SearchScreenProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => MyWishListProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => MyBookingProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(ConstColors.lightColor);
    return GetMaterialApp(
      title: 'Property',
      navigatorKey: locator<NavigationService>().navigatorKey,
      routes: routes,
      debugShowCheckedModeBanner: false,
      home: const Splash(),
    );
  }
}
