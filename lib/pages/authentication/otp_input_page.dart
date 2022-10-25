import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:luxepass/constants/common_method.dart';
import '../../constants/common_widget.dart';
import '../../constants/const_variables.dart';
import '../../constants/constant_colors.dart';
import '../../get_storage_services/get_storage_service.dart';
import '../../home/home.dart';
import '../../utils/navigator.dart';
import 'package:get/get.dart';

enum MobileVerificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}

class OTPInputScreen extends StatefulWidget {
  final String emailOrPhoneText;
  final String verificationId;
  final bool isEmail;

  OTPInputScreen({
    Key? key,
    required this.emailOrPhoneText,
    required this.verificationId,
    required this.isEmail,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _OTPInputScreenState();
  }
}

class _OTPInputScreenState extends State<OTPInputScreen> {
  bool isTrue = false;
  String? verificationCode;
  MobileVerificationState currentState =
      MobileVerificationState.SHOW_MOBILE_FORM_STATE;
  FirebaseAuth _auth = FirebaseAuth.instance;

  String countryCode = "+1";
  TextEditingController numberController = TextEditingController();
  TextEditingController searchTextEditing = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future wait(int seconds) {
    return Future.delayed(Duration(seconds: seconds), () => {});
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    numberController.dispose();
    searchTextEditing.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: ConstColors.backgroundColor,
          body: ProgressHUD(
            child: Builder(
              builder: (context) {
                final progress = ProgressHUD.of(context);

                return Container(
                    constraints: const BoxConstraints.expand(),
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(ConstVar.backgroundImg),
                          fit: BoxFit.cover),
                    ),
                    child: ListView(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.all(10.0),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: ElevatedButton.icon(
                              icon: const Icon(
                                Icons.arrow_back_ios,
                                color: Color(0xff66B3B3),
                              ),
                              //`Icon` to display
                              label: const Text(
                                'Back',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                              //`Text` to display
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                        ),
                        Container(
                          margin:
                              const EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 20.0),
                          child: const Text(
                            "Enter your 6-digit code",
                            style: TextStyle(
                                color: Colors.black,
                                letterSpacing: 1,
                                fontSize: 20,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Container(
                          margin:
                              const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 10.0),
                          child: const Text(
                            "Code",
                            style: TextStyle(
                                color: Colors.grey,
                                letterSpacing: 1,
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Container(
                          height: 50.0,
                          margin:
                              const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 20.0),
                          child: OtpTextField(
                            numberOfFields: 6,
                            borderColor: Colors.grey,
                            enabledBorderColor: ConstColors.lightColor,
                            //set to true to show as box or false to show as dash
                            showFieldAsBox: true,
                            //runs when a code is typed in

                            //runs when every textfield is filled
                            onSubmit: (String verificationCode) {
                              print(
                                  'code length verificationCode ${verificationCode}');
                              print(
                                  'code length verificationCode ${verificationCode.length}');
                              if (verificationCode.length == 6) {
                                if (widget.isEmail) {
                                  print('is Email');
                                } else {
                                  PhoneAuthCredential phoneAuthCredential =
                                      PhoneAuthProvider.credential(
                                          verificationId: widget.verificationId,
                                          smsCode: verificationCode);
                                  signInWithPhoneAuthCredential(
                                      progress: progress,
                                      phoneAuthCredential: phoneAuthCredential);
                                }
                              }
                            }, // end onSubmit
                          ),
                        ),
                        Container(
                          margin:
                              const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                          child: widget.isEmail
                              ? const Text(
                                  "Text you a 6 digit code on your email-id",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      letterSpacing: 1,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                )
                              : const Text(
                                  "Text you a 6 digit code on your phone number",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      letterSpacing: 1,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(
                                30.0, 20.0, 30.0, 10.0),
                            child: const Center(
                              child: Text(
                                "Resend Code",
                                style: TextStyle(
                                    color: ConstColors.lightColor,
                                    letterSpacing: 1,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(
                                30.0, 20.0, 30.0, 10.0),
                            child: Center(
                              child: Text(
                                widget.isEmail
                                    ? "Change email-id"
                                    : "Change mobile No.",
                                style: const TextStyle(
                                    color: Colors.grey,
                                    letterSpacing: 1,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        )
                      ],
                    ));
              },
            ),
          )),
    );
  }

  signInWithPhoneAuthCredential({
    required PhoneAuthCredential phoneAuthCredential,
    required final progress,
  }) async {
    progress.show();

    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);

      if (authCredential.user != null) {
        String uid = _auth.currentUser!.uid.toString();

        print('---------uid in current user $uid');
        print(
            '---------uid in- displayName  user ${_auth.currentUser!.displayName}');
        GetStorageServices.setLoginValue('${widget.emailOrPhoneText}');
        GetStorageServices.setToken(uid);
        GetStorageServices.setUserLoggedIn();
        CommonMethode.likeFiledAdd();
        MyNavigator.goToHome(context);
      }
    } on FirebaseAuthException catch (e) {
      progress.dismiss();

      CommonWidget.getSnackBar(
          message: '${e.message}',
          title: 'Failed',
          duration: 2,
          color: Colors.red);
    }
  }

  validateOtp(String otp) {
    fetchUserDetails();

    // if(otp==widget.otpResponseModel.otp){
    //   fetchUserDetails();
    // }else{
    //   showToast("Invalid  OTP", Colors.black);
    // }
  }

  resendOTP() async {
    // try {
    //   if (widget.isEmail) {
    //     // var response = await authRepository.validateEmailID(widget.emailID);
    //     // showToast("Text you a 4 digit code on your email-id", Colors.black);
    //     // widget.otpResponseModel=response;
    //   } else {
    //     // var response = await authRepository.validatePhoneNumber(widget.emailID);
    //     // showToast("Text you a 4 digit code on your phone number", Colors.black);
    //     // widget.otpResponseModel=response;
    //     progress.show();
    //
    //     await _auth.verifyPhoneNumber(
    //       phoneNumber: widget.emailOrPhoneText,
    //       verificationCompleted: (phoneAuthCredential) async {
    //         progress.dismiss();
    //       },
    //       verificationFailed: (verificationFailed) async {
    //         progress.dismiss();
    //
    //         print('----verificationFailed---${verificationFailed.message}');
    //         CommonWidget.getSnackBar(
    //           message: verificationFailed.message!,
    //           title: 'Failed',
    //           duration: 2,
    //           color: Colors.red,
    //         );
    //       },
    //       codeSent: (verificationId, resendingToken) async {
    //         setState(() {
    //           //  showLoading = false;
    //           currentState = MobileVerificationState.SHOW_OTP_FORM_STATE;
    //           this.verificationId = verificationId;
    //
    //           Get.to(OTPInputScreen(
    //             isEmail: false,
    //             emailOrPhoneText:
    //             seletedCountry.dial_code + numberController.text,
    //             verificationId: verificationId,
    //           ));
    //           progress.dismiss();
    //         });
    //       },
    //       codeAutoRetrievalTimeout: (verificationId) async {},
    //     );
    //   }
    // } catch (e) {
    //   showToast(e.toString(), Colors.black);
    // }
  }

  fetchUserDetails() async {
    //
    // try{
    //
    //     var response = await authRepository.validateUserByEmail(widget.emailID,widget.loginType);
    //     if(response.toString()=="-1"){
    //       gotoCustomerSignupPage();
    //     }else if(response is Map){
    //       if(response["data"].length>=0){
    //         userDataDB.put("email", response["data"][0]["email"]);
    //         userDataDB.put("emergency_contact", response["data"][0]["emergency_contact"]);
    //         userDataDB.put("first_name", response["data"][0]["first_name"]);
    //         userDataDB.put("gender", response["data"][0]["gender"]);
    //         userDataDB.put("gov_id", response["data"][0]["gov_id"]);
    //         userDataDB.put("id_type", response["data"][0]["id_type"]);
    //         userDataDB.put("last_name", response["data"][0]["last_name"]);
    //         userDataDB.put("load_date", response["data"][0]["load_date"]);
    //         userDataDB.put("login_type", response["data"][0]["login_type"]);
    //         userDataDB.put("mobile_no", response["data"][0]["mobile_no"]);
    //         userDataDB.put("profile_pic", response["data"][0]["profile_pic"]);
    //         userDataDB.put("type", response["data"][0]["type"]);
    //         gotoHomePage();
    //       }else {
    //         gotoCustomerSignupPage();
    //       }
    //
    //
    //   }
    // }catch(e){
    //   showToast(e.toString(), Colors.black);
    // }
  }

  gotoHomePage() {
    MyNavigator.goToHome(context);
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
