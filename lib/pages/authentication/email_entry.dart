import 'package:flutter/material.dart';
import 'package:luxepass/constants/constant_colors.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:luxepass/pages/authentication/otp_input_page.dart';
import '../../constants/common_widget.dart';
import '../../constants/const_variables.dart';
import 'package:email_auth/email_auth.dart';
import 'package:get/get.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

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
  bool? emailValid; // AuthRepository authRepository=AuthRepository();
  EmailAuth? emailAuth;

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

    return ProgressHUD(child: Builder(
      builder: (context) {
        final progress = ProgressHUD.of(context);

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
                    child:
                        CircularProgressIndicator(color: ConstColors.darkColor),
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
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
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
                        margin:
                            const EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 20.0),
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
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 1),
                                  ),
                                  // Focused Border
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ConstColors.lightColor,
                                        width: 1),
                                  ),
                                  // Error Border
                                  errorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ConstColors.lightColor,
                                        width: 1),
                                  ),
                                  // Focused Error Border
                                  focusedErrorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ConstColors.lightColor,
                                        width: 1),
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
                        margin:
                            const EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 20.0),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: RawMaterialButton(
                            onPressed: () {
                              validateEmail(progress);
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
      },
    ));
  }

  validateEmail(final progress) async {
    if (_emailControllerController.text
            .isNotEmpty /* &&
                        _passWordController.text.isNotEmpty*/
        ) {
      progress.show();

      emailValid = RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
          .hasMatch(_emailControllerController.text);

      if (emailValid == true) {
        emailAuth = new EmailAuth(
          sessionName: "Sample session",
        );
        emailAuth!.config({
          "server": "server url",
          "serverKey": "AIzaSyCoJPlgKxXEy3FprIJYE5nPqaLC_gL94jI"
        });
        bool result = await emailAuth!.sendOtp(
            recipientMail: _emailControllerController.text.trim(),
            otpLength: 6);
        if (result) {
          // showBottomEmailSheet();
          Future.delayed(Duration(milliseconds: 500), () {
            Get.to(() => OTPInputScreen(
                  resendToken: '',
                  emailOrPhoneText: _emailControllerController.text.trim(),
                  isEmail: true,
                  verificationId: '',
                ));
          });
          progress.dismiss();
        } else {
          progress.dismiss();
          CommonWidget.getSnackBar(
            message: "Something went-wrong",
            color: Colors.red,
            title: 'Failed',
            duration: 2,
          );
        }
      } else {
        progress.dismiss();

        CommonWidget.getSnackBar(
            title: 'required',
            color: Colors.red,
            duration: 2,
            message: 'Please Enter valid Email');
      }
    } else {
      CommonWidget.getSnackBar(
          title: 'required',
          color: Colors.red,
          duration: 2,
          message: 'Please Enter Email');
    }
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
