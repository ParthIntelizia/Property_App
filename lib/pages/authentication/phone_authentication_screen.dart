import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../constants/common_widget.dart';
import '../../constants/const_variables.dart';
import '../../constants/constant_colors.dart';
import '../../models/CountryModel.dart';
import '../../models/send_otp_reponse_model.dart';
import 'otp_input_page.dart';

enum MobileVerificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}

class PhoneAuthenticationScreen extends StatefulWidget {
  const PhoneAuthenticationScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PhoneAuthenticationScreenState();
  }
}

class _PhoneAuthenticationScreenState extends State<PhoneAuthenticationScreen> {
  bool isTrue = false;
  dynamic resendToken;
  String countryCode = "+1";
  TextEditingController numberController = new TextEditingController();
  TextEditingController searchTextEditing = new TextEditingController();

  bool _hasSpeech = false;
  double level = 0.0;
  double minSoundLevel = 50000;
  double maxSoundLevel = -50000;
  String lastWords = "";
  String lastError = "";
  String lastStatus = "";
  String _currentLocaleId = "";

  List<CountryModel> _searchResult = [];
  List<CountryModel> _countryList = [];
  FirebaseAuth _auth = FirebaseAuth.instance;

  late CountryModel seletedCountry;
  MobileVerificationState currentState =
      MobileVerificationState.SHOW_MOBILE_FORM_STATE;
  bool isObscured = true;
  String? verificationId;
  bool? emailValid;
  // AuthRepository authRepository=AuthRepository();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    seletedCountry = CountryModel("India", "🇮🇳", "IN", "+91");
    loadCountry().then((value) {
      _countryList = value;
      if (_countryList.isNotEmpty) {
        setState(() {
          if (_currentLocaleId == "en_IN") {
            seletedCountry = _countryList[1];
          } else {
            seletedCountry = _countryList[0];
          }
        });
      }
    });
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
                            "Enter your mobile number",
                            style: TextStyle(
                                color: Colors.black,
                                letterSpacing: 1,
                                fontSize: 20,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Container(
                          height: 50.0,
                          margin:
                              const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 40.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: GestureDetector(
                                  onTap: () {
                                    _displayDialog(context);
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.fromLTRB(
                                        0.0, 0.0, 0.0, 0.0),
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
                              ),
                              Expanded(
                                flex: 6,
                                child: SizedBox(
                                  height: 50.0,
                                  child: TextField(
                                      controller: numberController,
                                      enabled: true,
                                      maxLength: 12,
                                      style: const TextStyle(
                                          color: Color(0xff008080),
                                          fontSize: 14,
                                          fontStyle: FontStyle.normal,
                                          letterSpacing: 1),
                                      keyboardType: TextInputType.phone,
                                      decoration: const InputDecoration(
                                        hintText: 'Continue with mobile number',
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
                                        focusedErrorBorder:
                                            UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: ConstColors.lightColor,
                                              width: 1),
                                        ),
                                        hintStyle: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 14,
                                            fontStyle: FontStyle.normal),
                                      ),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'[0-9]')),
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      onChanged: (String value) {
                                        if (value.length >= 8) {
                                          setState(() {
                                            isTrue = true;
                                          });
                                        } else {
                                          setState(() {
                                            isTrue = false;
                                          });
                                        }
                                      }),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: 60.0,
                          margin:
                              const EdgeInsets.fromLTRB(40.0, 40.0, 40.0, 40.0),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: RawMaterialButton(
                              onPressed: () {
                                signInMethod(progress);
                              },
                              elevation: 2.0,
                              fillColor: isTrue
                                  ? ConstColors.lightColor
                                  : Colors.grey[300],
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
                    ));
              },
            ),
          )),
    );
  }

  Future<String> _loadAStudentAsset() async {
    return await rootBundle.loadString('assets/country.JSON');
  }

  Future<List<CountryModel>> loadCountry() async {
    String jsonString = await _loadAStudentAsset();
    final jsonResponse = json.decode(jsonString);

    List<CountryModel> listData = jsonResponse
        .map<CountryModel>((json) => CountryModel.fromJson(json))
        .toList();
    return listData;
  }

  Future wait(int seconds) {
    return Future.delayed(Duration(seconds: seconds), () => {});
  }

  _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter modalSetState) {
            return AlertDialog(
              content: SizedBox(
                width: double.maxFinite,
                height: 360.0,
                child: Column(
                  children: <Widget>[
                    Container(
                      color: Theme.of(context).primaryColor,
                      child: Card(
                        child: ListTile(
                          leading: const Icon(Icons.search),
                          title: TextField(
                            controller: searchTextEditing,
                            decoration: const InputDecoration(
                                hintText: 'Search', border: InputBorder.none),
                            onChanged: (value) {
                              onSearchTextChanged(value, modalSetState);
                            },
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.cancel),
                            onPressed: () {
                              searchTextEditing.clear();
                              onSearchTextChanged('', modalSetState);
                            },
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: _searchResult.isNotEmpty ||
                              searchTextEditing.text.isNotEmpty
                          ? ListView.builder(
                              itemCount: _searchResult.length,
                              itemBuilder: (context, i) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      seletedCountry = _searchResult[i];
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: Card(
                                    margin: const EdgeInsets.all(6.0),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0, right: 10.0),
                                            child: Text(
                                              _searchResult[i].flag,
                                              style: const TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            _searchResult[i].name,
                                            maxLines: 2,
                                            textAlign: TextAlign.justify,
                                            style: const TextStyle(
                                              fontSize: 12,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            )
                          : ListView.builder(
                              itemCount: _countryList.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      seletedCountry = _countryList[index];
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0, right: 10.0),
                                            child: Text(
                                              _countryList[index].flag,
                                              style: const TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            _countryList[index].name,
                                            maxLines: 2,
                                            style: const TextStyle(
                                              fontSize: 12,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
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
                    child: const Text('CANCEL'),
                  ),
                )
              ],
            );
          });
        });
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

  onSearchTextChanged(String text, StateSetter modalSetState) async {
    _searchResult.clear();
    if (text.isEmpty) {
      modalSetState(() {});
      return;
    }
    for (var value in _countryList) {
      if (value.name.toLowerCase().contains(text.toLowerCase()))
        _searchResult.add(value);
    }

    modalSetState(() {});
  }

  signInMethod(
    final progress,
  ) async {
    try {
      if (numberController.text.length == 10) {
        progress.show();

        await _auth.verifyPhoneNumber(
          phoneNumber: seletedCountry.dial_code + numberController.text,
          verificationCompleted: (phoneAuthCredential) async {
            progress.dismiss();
          },
          verificationFailed: (verificationFailed) async {
            progress.dismiss();

            print('----verificationFailed---${verificationFailed.message}');
            CommonWidget.getSnackBar(
              message: verificationFailed.message!,
              title: 'Failed',
              duration: 2,
              color: Colors.red,
            );
          },
          codeSent: (verificationId, resendingToken) async {
            setState(() {
              //  showLoading = false;
              currentState = MobileVerificationState.SHOW_OTP_FORM_STATE;
              this.verificationId = verificationId;
              resendToken = resendingToken;

              Get.to(OTPInputScreen(
                resendToken: resendingToken,
                isEmail: false,
                emailOrPhoneText:
                    seletedCountry.dial_code + numberController.text,
                verificationId: verificationId,
              ));
              progress.dismiss();
            });
          },
          forceResendingToken: resendToken,
          codeAutoRetrievalTimeout: (verificationId) async {},
        );
      } else {
        CommonWidget.getSnackBar(
            message: 'Please enter your mobile number',
            color: Colors.red,
            title: '');
      }
    } on FirebaseException catch (e) {
      CommonWidget.getSnackBar(
          message: '${e.message}',
          color: Colors.red,
          title: 'Failed',
          duration: 2);
      print('MAG ERROR----${e.message}');
    }
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
