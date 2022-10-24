import 'dart:async';
import 'package:flutter/material.dart';
import 'package:luxepass/constants/constant_colors.dart';
import 'package:get/get.dart';
import '../utils/navigator.dart';
import 'authentication/signin.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      MyNavigator.goToHome(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.darkColor,
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: ExactAssetImage('assets/icons/splash_screen.png'),
              fit: BoxFit.fill,
            ),
          )),
    );
  }
}
