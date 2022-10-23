import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:luxepass/pages/authentication/my_location_page.dart';
import '../../constants/const_variables.dart';
import '../../constants/constant_colors.dart';

class AddProfilePictureScreen extends StatefulWidget {
  final String loginType;
  final String emailID;

  AddProfilePictureScreen({required this.loginType, required this.emailID})
      : super();

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AddProfilePictureScreenState();
  }
}

class _AddProfilePictureScreenState extends State<AddProfilePictureScreen> {
  late File _imageFile;
  bool isLoading = false;

  final TextEditingController _emailControllerController =
      TextEditingController();
  // AuthRepository authRepository = AuthRepository();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:
          Scaffold(backgroundColor: ConstColors.backgroundColor, body: _body()),
    );
  }

  Widget _body() {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(ConstVar.backgroundImg), fit: BoxFit.cover),
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: ListView(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(10.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: ElevatedButton.icon(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: ConstColors.lightColor,
                  ),
                  //`Icon` to display
                  label: const Text(
                    'Back',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  //`Text` to display
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
            Container(
              height: 50.0,
              margin: const EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: TextField(
                      controller: _emailControllerController,
                      enabled: true,
                      maxLength: 50,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontStyle: FontStyle.normal,
                          letterSpacing: 1),
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                        hintText: 'Enter your name ',
                        contentPadding: EdgeInsets.all(10.0),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 1),
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
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 50.0,
              margin: const EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 20.0),
              child: Align(
                alignment: Alignment.topRight,
                child: RawMaterialButton(
                  onPressed: () {
                    if (_emailControllerController.text.length > 5) {
                      addUserDetails(_emailControllerController.text);
                    } else {
                      showToast("Please enter your name ", Colors.red);
                    }
                  },
                  elevation: 2.0,
                  fillColor: ConstColors.lightColor,
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(10.0),
                  child: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 25.0,
                    color: Color(0xffffffff),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  addUserDetails(String name) async {
    try {
      var body = {
        "first_name": name,
        "last_name": "",
        "email": widget.loginType == "email" ? widget.emailID : "",
        "is_email_verified": widget.loginType == "email",
        "mobile_no": widget.loginType == "phone" ? widget.emailID : "",
        "is_mobile_verified": widget.loginType == "phone",
        "profile_pic": "",
        "gender": "",
        "id_type": "",
        "gov_id": "",
        "emergency_contact": "+",
        "user_token": "",
        "login_type": widget.loginType,
        "load_date": ""
      };

      // var response = await authRepository.registerCustomer(body);
      //
      //
      // userDataDB.put("email", widget.loginType=="email"?widget.emailID:"");
      // userDataDB.put("emergency_contact", "");
      // userDataDB.put("first_name",name );
      // userDataDB.put("gender", "");
      // userDataDB.put("gov_id", "");
      // userDataDB.put("id_type", "");
      // userDataDB.put("last_name", "");
      // userDataDB.put("load_date", "");
      // userDataDB.put("login_type", widget.loginType);
      // userDataDB.put("mobile_no", widget.loginType=="phone"?widget.emailID:"");
      // userDataDB.put("profile_pic", "");
      // userDataDB.put("type", "customer");

      goToMyLocationPage();
    } catch (e) {
      showToast(e.toString(), Colors.black);
    }
  }

  goToMyLocationPage() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const MyLocation()),
      (Route<dynamic> route) => false,
    );
  }

  showToast(message, Color color) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: color,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
