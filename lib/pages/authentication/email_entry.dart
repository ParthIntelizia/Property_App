import 'package:flutter/material.dart';
import 'package:luxepass/constants/constant_colors.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:luxepass/pages/authentication/otp_input_page.dart';
import 'package:luxepass/utils/navigator.dart';

import '../../constants/const_variables.dart';
import '../../models/send_otp_reponse_model.dart';
import '../../services/locator_service.dart';
import '../../services/navigation_service.dart';

class EmailEntryScreen extends StatefulWidget {
  const EmailEntryScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _EmailEntryScreenState();
  }
}

class _EmailEntryScreenState extends State<EmailEntryScreen> {
  bool isLoading = false;
  final TextEditingController _emailControllerController =
      TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // AuthRepository authRepository=AuthRepository();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailControllerController.dispose();
    _passwordController.dispose();
    super.dispose();
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
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(color: ConstColors.darkColor),
              )
            : ListView(
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
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              hintText: 'Enter you emailId',
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
                          if (_emailControllerController.text.length > 5 &&
                              RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(_emailControllerController.text)) {
                            validateEmail(_emailControllerController.text);
                          } else {
                            showToast("Enter a valid email ", Colors.red);
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


  validateEmail(
    String emailID,
  ) {
    setState(() {
      isLoading = true;
    });
    // authRepository.validateEmailID(emailID).then((value) => {
    //   gotoOtpInputPage(emailID,value)
    //
    // }).onError((error, stackTrace) => {
    //   showToast(error.toString(),Colors.black)
    // });
  }

  showToast(message, Color color) {
    setState(() {
      isLoading = false;
    });
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
