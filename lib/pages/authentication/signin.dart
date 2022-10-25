import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luxepass/constants/const_variables.dart';
import '../../constants/common_method.dart';
import '../../constants/constant_colors.dart';
import '../../get_storage_services/get_storage_service.dart';
import '../../models/CountryModel.dart';
import '../../services/locator_service.dart';
import '../../services/navigation_service.dart';
import 'my_location_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SignInScreenState();
  }
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController numberController = TextEditingController();
  late CountryModel seletedCountry;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  bool isSignIn = false;
  bool google = false;

  @override
  void initState() {
    // TODO: implement initState

    seletedCountry = CountryModel("India", "🇮🇳", "IN", "+91");
    super.initState();
    if (Platform.isIOS) {
      //check for ios if developing for both android & ios

    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:
          Scaffold(backgroundColor: ConstColors.backgroundColor, body: _body()),
    );
  }

  Widget _body() {
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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 80.0,
              width: 250.0,
              margin: const EdgeInsets.all(50.0),
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                border: Border.all(
                    color: ConstColors.widgetDividerColor, width: 0.0),
                image: const DecorationImage(
                    image: AssetImage('assets/logo.png'), fit: BoxFit.contain),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
              child: Text(
                "Let's you in",
                style: GoogleFonts.urbanist(
                    fontWeight: FontWeight.w700,
                    fontSize: 26.0,
                    color: Colors.black),
              ),
            ),
            GestureDetector(
              onTap: () {
                _performLogin();
              },
              child: Container(
                height: 60.0,
                margin: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  border: Border.all(
                    color: ConstColors.widgetDividerColor,
                    width: 1,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Expanded(
                      flex: 1,
                      child: Image(
                        image: AssetImage("assets/icons/facebook.png"),
                        width: 30.0,
                        height: 30.0,
                        color: null,
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.center,
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Text(
                        "Continue with Facebook",
                        style: GoogleFonts.urbanist(
                            fontWeight: FontWeight.w700,
                            fontSize: 14.0,
                            color: Colors.black),
                      ),
                    )
                  ],
                ),
              ),
            ),
            if (Platform.isIOS)
              GestureDetector(
                onTap: () {},
                child: Container(
                  height: 60.0,
                  margin: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    border: Border.all(
                      color: ConstColors.widgetDividerColor,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Expanded(
                        flex: 1,
                        child: Image(
                          image: AssetImage("assets/icons/apple.png"),
                          width: 30.0,
                          height: 30.0,
                          color: null,
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.center,
                        ),
                      ),
                      Expanded(
                          flex: 4,
                          child: Text(
                            "Continue with Apple",
                            style: GoogleFonts.urbanist(
                                fontWeight: FontWeight.w700,
                                fontSize: 14.0,
                                color: Colors.black),
                          ))
                    ],
                  ),
                ),
              ),
            GestureDetector(
              onTap: () {
                signInWithGoogle();
              },
              child: Container(
                height: 60.0,
                margin: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  border: Border.all(
                    color: ConstColors.widgetDividerColor,
                    width: 1,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Expanded(
                      flex: 1,
                      child: Image(
                        image: AssetImage("assets/icons/google.png"),
                        width: 30.0,
                        height: 30.0,
                        color: null,
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.center,
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Text(
                        "Continue with Google",
                        style: GoogleFonts.urbanist(
                            fontWeight: FontWeight.w700,
                            fontSize: 14.0,
                            color: Colors.black),
                      ),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                locator<NavigationService>().navigateTo("/emailAuth");
              },
              child: Container(
                height: 60.0,
                margin: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  border: Border.all(
                    color: ConstColors.widgetDividerColor,
                    width: 1,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Expanded(
                      flex: 1,
                      child: Image(
                        image: AssetImage("assets/icons/email.png"),
                        width: 30.0,
                        height: 30.0,
                        color: null,
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.center,
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Text(
                        "Continue with Email",
                        style: GoogleFonts.urbanist(
                            fontWeight: FontWeight.w700,
                            fontSize: 14.0,
                            color: Colors.black),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              height: 20.0,
              margin: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                      child: Divider(
                    color: Colors.grey[400],
                  )),
                  Text(
                    "  OR  ",
                    style: TextStyle(color: Colors.grey[400]),
                  ),
                  Expanded(child: Divider(color: Colors.grey[400])),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                locator<NavigationService>().navigateTo("/mobileAuth");
              },
              child: Container(
                height: 50.0,
                margin: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                        height: 50.0,
                        child: seletedCountry != null
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    seletedCountry.flag,
                                    style: const TextStyle(
                                      fontSize: 30,
                                    ),
                                  ),
                                  Text(
                                    seletedCountry.dial_code,
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  )
                                ],
                              )
                            : const SizedBox(),
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: SizedBox(
                        height: 50.0,
                        child: TextField(
                            controller: numberController,
                            enabled: false,
                            maxLength: 12,
                            style: const TextStyle(
                                color: Color(0xff008080),
                                fontSize: 14,
                                fontStyle: FontStyle.normal,
                                letterSpacing: 1),
                            keyboardType: TextInputType.none,
                            decoration: const InputDecoration(
                              hintText: 'Continue with mobile number',
                              contentPadding: EdgeInsets.all(10.0),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 1),
                              ),
                              // Focused Border
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: ConstColors.lightColor, width: 1),
                              ),
                              // Error Border
                              errorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: ConstColors.lightColor, width: 1),
                              ),
                              // Focused Error Border
                              focusedErrorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: ConstColors.lightColor, width: 1),
                              ),
                              hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                  fontStyle: FontStyle.normal),
                            ),
                            onChanged: (String value) {}),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(40.0, 10.0, 40.0, 30.0),
              child: GestureDetector(
                onTap: () {
                  _displayTermConditionsDialog(context);
                },
                child: RichText(
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  text: const TextSpan(
                    text: 'By Creating an account, you aggree to our ',
                    style: TextStyle(
                        color: Color(0xff000000),
                        fontSize: 12.0,
                        height: 2,
                        letterSpacing: 1),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Term of service ',
                          style: TextStyle(color: Color(0xff66B3B3))),
                      TextSpan(text: ' and '),
                      TextSpan(
                          text: 'Privacy Policy.',
                          style: TextStyle(color: Color(0xff66B3B3)))
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                goToMyLocationPage();
              },
              child: Container(
                height: 40.0,
                margin: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                decoration: BoxDecoration(
                  color: ConstColors.backgroundColor,
                  borderRadius: const BorderRadius.all(Radius.circular(40.0)),
                  border: Border.all(
                    color: ConstColors.widgetDividerColor,
                    width: 1,
                  ),
                ),
                child: const Center(
                  child: Text(
                    "  Skip  ",
                    style: TextStyle(color: Color(0xff66B3B3)),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  goToMyLocationPage() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const MyLocation()),
      (Route<dynamic> route) => false,
    );
  }

  _displayTermConditionsDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter modalSetState) {
            return AlertDialog(
              content: SizedBox(
                width: double.maxFinite,
                height: 350.0,
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 50.0,
                      width: double.maxFinite,
                      child: Center(
                        child: Text(
                          "Terms And Conditions",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16.0,
                              fontFamily: 'Montserrat Regular',
                              color: Color(0xff008080)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 300.0,
                      child: Flexible(
                        child: ListView(
                          children: const [
                            Center(
                              child: Text(
                                "Terms And Conditions Text",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.0,
                                    fontFamily: 'Montserrat Regular',
                                    color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(5.0),
                    child: const Text('OK'),
                  ),
                )
              ],
            );
          });
        });
  }

  signInWithGoogle() async {
    GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();

    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;

    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    var authResult = await _auth.signInWithCredential(credential);

    var user = authResult.user;

    assert(!user!.isAnonymous);

    assert(await user?.getIdToken() != null);

    var currentUser = _auth.currentUser;

    if (authResult.user != null) {
      String nameOfUser;
      try {
        nameOfUser = FirebaseAuth.instance.currentUser!.displayName!;
      } catch (e) {
        nameOfUser = FirebaseAuth.instance.currentUser!.email!;
      }
      GetStorageServices.setLoginValue(nameOfUser);
      GetStorageServices.setToken(FirebaseAuth.instance.currentUser!.uid);
      GetStorageServices.setUserLoggedIn();
      CommonMethode.likeFiledAdd();
    }

    assert(user?.uid == currentUser?.uid);

    print("User Name: ${user?.displayName}");
    print("User Email ${user?.email}");

    goToMyLocationPage();
  }

  _performLogin() async {
    final LoginResult loginResult = await FacebookAuth.instance
        .login(permissions: ["public_profile", "email"]);

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    FirebaseAuth.instance
        .signInWithCredential(facebookAuthCredential)
        .then((value) {
      if (value.user != null) {
        GetStorageServices.setToken(FirebaseAuth.instance.currentUser!.uid);
        GetStorageServices.setUserLoggedIn();
        log('Token===>>${GetStorageServices.getToken()}');
        CommonMethode.likeFiledAdd();
        goToMyLocationPage();
      }
    });
  }
}
