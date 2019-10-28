import 'dart:async';
import 'package:finesse/api/FinesseApi.dart';
import 'package:finesse/constant/Constant.dart';
import 'package:finesse/model/client_info.dart';
import 'package:finesse/util/connection_utils.dart';
import 'package:finesse/util/text_styles.dart';
import 'package:finesse/util/uidata.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:screen/screen.dart';
import 'package:connectivity/connectivity.dart';

class BillingScreen extends StatefulWidget {
  @override
  BillingScreenState createState() => new BillingScreenState();
}

class BillingScreenState extends State<BillingScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  ClientInfo user;

  final double profileWidthScale = .478875; //.557;
  final double intersectionWidthScale = .36425;
  final double leftPaddingScale = 0.078125;
  final double topPaddingScale = 0.083;
  final double verticalGapBetweenfields = 12.0;

  String name;
  String age;
  String phoneNo;
  String email;
  String occasion = "#";
  String peopleNo;

  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController occasionController = TextEditingController();
  TextEditingController peopleNumberController = TextEditingController();

  bool isLoading = false;

  goToMainMenu() async {
    var _duration = new Duration(milliseconds: 200);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    // Navigator.of(context).pushReplacementNamed(PAYMENT_SCREEN);
    Navigator.of(context).pushNamed(MENU_SCREEN);
  }

  @override
  void initState() {
    super.initState();
    Screen.setBrightness(1.0);
    nameController.addListener(_setName);
    ageController.addListener(_setAge);
    phoneController.addListener(_setPhone);
    emailController.addListener(_setEmail);
    occasionController.addListener(_setOccasion);
    peopleNumberController.addListener(_setPeopleNo);
    user = currentUser;
    user.clientName = null;
    user.clientEmail = null;
    user.clientPhone = null;
    user.occassion = null;
    user.age = null;
    user.totalpersons = null;
    ConnectionUtils.getInstance().initialize();
  }

  _setName() {
    name = nameController.text;
    user.clientName = name;
    // //debugPrint("name is ---------" + name);
  }

  _setAge() {
    age = ageController.text;
    user.age = int.tryParse(age) ?? 18;
    // //debugPrint("age is ---------" + user.age.toString());
  }

  _setPhone() {
    phoneNo = phoneController.text;
    user.clientPhone = phoneNo;
    // //debugPrint("name is ---------" + phoneNo);
  }

  _setEmail() {
    email = emailController.text;
    user.clientEmail = email;
    // //debugPrint("name is ---------" + email);
  }

  _setOccasion() {
    occasion = occasion + occasionController.text;
    user.occassion = "#" + occasion;
    occasion = "";
    // //debugPrint("name is ---------" + occasion);
  }

  _setPeopleNo() {
    peopleNo = peopleNumberController.text;
    user.totalpersons = int.tryParse(peopleNo) ?? 2;
    // //debugPrint("name is --------- " + user.totalpersons.toString());
  }

  _doneButtonPressed() {
    if (user.clientName == null || user.clientPhone == null) {
      showSnackBar1();
    } else {
      if (user.clientPhone.length == 10) {
        setState(() {
          isLoading = true;
        });
        _registerRequest();
      } else {
        showSnackBar2();
      }
      // //debugPrint("done button pressed" );
    }
  }

  // send registration request to server

  void _registerRequest() async {
    user.caffeID = currentCafe.caffeId;
    user.tableId = currentUser.tableId;
    user.currentDate = new DateFormat('dd/MM/yyyy')
        .format(DateTime.parse(DateTime.now().toString()));
    user.tableIdTimestamp =
        user.tableId + "---" + DateTime.now().millisecondsSinceEpoch.toString();
    user.timestamp = new DateFormat('dd/MM/yyyy hh:mm:ss')
        .format(DateTime.parse(DateTime.now().toString()));

    api.registerRequest(user).then((response) {
      //debugPrint("Reply in register "+ response.insertClientInfo);
      if (response.insertClientInfo.compareTo("success") == 0) {
        navigationPage();
        // client_name, client_phone and tableidtimestamp will be saved in cache
        currentUser = user;
        debugPrint(response.insertClientInfo.toString());
      } else {
        setState(() {
          isLoading = false;
        });
        showSnackBar2();
        debugPrint('failed');
        debugPrint(response.insertClientInfo.toString());
      }
    });
  }

  void showSnackBar1() {
    _scaffoldKey.currentState
      ..showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          "Please enter your name and phone number",
          style: TextStyle(
              fontFamily: UIData.font_nunito_sans,
              fontSize: 31.0,
              fontWeight: FontWeight.w300),
        ),
      ));
  }

  void showSnackBar2() {
    _scaffoldKey.currentState
      ..showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          "Phone number should be of 10 digits",
          style: TextStyle(
              fontFamily: UIData.font_nunito_sans,
              fontSize: 31.0,
              fontWeight: FontWeight.w300),
        ),
      ));
  }

  void showSnackBarNoConnection() {
    _scaffoldKey.currentState
      ..showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          "Please check your connection!",
          style: TextStyle(
              fontFamily: UIData.font_nunito_sans,
              fontSize: 31.0,
              fontWeight: FontWeight.w300),
        ),
      ));
  }

  Future<bool> _onBackPressed() async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    var size = MediaQuery.of(context).size;
    Widget loadingWidget = Image.asset('assets/infinity_loading.gif');
    // //debugPrint(" height -- " + size.height.toString());
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        key: _scaffoldKey,
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Row(
              children: <Widget>[
                SingleChildScrollView(
                  child: Container(
                    width: size.width * profileWidthScale,
                    margin: EdgeInsets.only(
                      top: (size.height * topPaddingScale),
                      left: size.width * leftPaddingScale,
                      right: size.width * leftPaddingScale,
                    ),
                    // color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Icon(
                              const IconData(0xe90b, fontFamily: 'icomoon'),
                              color: Colors.black,
                              size: 50,
                            ),
                            SizedBox(width: 16.0),
                            Expanded(
                              child: Text(
                                UIData.billing_title,
                                style: TextStyle(
                                    fontFamily: UIData.font_nunito_sans,
                                    fontSize: 31.0,
                                    fontWeight: FontWeight.w300),
                              ),
                              flex: 1,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 48,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              UIData.billing_details_title,
                              style: TextStyle(
                                  fontFamily: UIData.font_nunito_sans,
                                  fontSize: 16.0,
                                  fontStyle: FontStyle.italic),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        Container(
                          child: Stack(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    width: 10,
                                    child: Text(
                                      UIData.label_compulsory,
                                      style: TextStyle(
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width:
                                        (size.width * profileWidthScale) - 10,
                                    child: TextField(
                                      controller: nameController,
                                      style: TextStyles.TEXT_FIELD_INPUT_STYLE,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        // labelText: UIData.label_name,
                                        hintText: UIData.label_name,
                                        hintStyle:
                                            TextStyles.TEXT_FIELD_LABLE_STYLE,
                                        // labelStyle: TextStyles.TEXT_FIELD_LABLE_STYLE,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: verticalGapBetweenfields,
                        ),
                        Container(
                          child: Stack(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    width: 1,
                                    child: Text(
                                      UIData.label_compulsory,
                                      style: TextStyle(
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: (size.width * profileWidthScale) / 2,
                                    child: TextField(
                                      controller: phoneController,
                                      style: TextStyles.TEXT_FIELD_INPUT_STYLE,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        // labelText: UIData.label_name,
                                        hintText: UIData.label_Phone,
                                        hintStyle:
                                            TextStyles.TEXT_FIELD_LABLE_STYLE,
                                        // labelStyle: TextStyles.TEXT_FIELD_LABLE_STYLE,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 92,
                                  ),
                                  Container(
                                    width:
                                        (size.width * profileWidthScale) / 3 -
                                            30,
                                    child: TextField(
                                      controller: ageController,
                                      style: TextStyles.TEXT_FIELD_INPUT_STYLE,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        // labelText: UIData.label_name,
                                        hintText: UIData.label_age,
                                        hintStyle:
                                            TextStyles.TEXT_FIELD_LABLE_STYLE,
                                        // labelStyle: TextStyles.TEXT_FIELD_LABLE_STYLE,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: verticalGapBetweenfields,
                        ),
                        Container(
                          child: Stack(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    width: 10,
                                  ),
                                  Container(
                                    width:
                                        (size.width * profileWidthScale) - 10,
                                    child: TextField(
                                      controller: emailController,
                                      style: TextStyles.TEXT_FIELD_INPUT_STYLE,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        // labelText: UIData.label_name,
                                        hintText: UIData.label_email,
                                        hintStyle:
                                            TextStyles.TEXT_FIELD_LABLE_STYLE,
                                        // labelStyle: TextStyles.TEXT_FIELD_LABLE_STYLE,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: verticalGapBetweenfields,
                        ),
                        Container(
                          child: Stack(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    width: 10,
                                  ),
                                  Container(
                                    width:
                                        (size.width * profileWidthScale) - 10,
                                    child: TextField(
                                      controller: occasionController,
                                      style: TextStyles.TEXT_FIELD_INPUT_STYLE,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        // labelText: UIData.label_name,
                                        hintText: UIData.label_occasion,
                                        hintStyle:
                                            TextStyles.TEXT_FIELD_LABLE_STYLE,
                                        // labelStyle: TextStyles.TEXT_FIELD_LABLE_STYLE,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: verticalGapBetweenfields,
                        ),
                        Container(
                          child: Stack(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    width: 10,
                                  ),
                                  Container(
                                    width:
                                        (size.width * profileWidthScale) - 10,
                                    child: TextField(
                                      controller: peopleNumberController,
                                      style: TextStyles.TEXT_FIELD_INPUT_STYLE,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        // labelText: UIData.label_name,
                                        hintText: UIData.label_people_no,
                                        hintStyle:
                                            TextStyles.TEXT_FIELD_LABLE_STYLE,
                                        // labelStyle: TextStyles.TEXT_FIELD_LABLE_STYLE,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(48.0, 48.0, 0.0, 48.0),
                          alignment: Alignment.bottomRight,
//                          child: StreamBuilder<bool>(
//                            stream:
//                                ConnectionUtils.getInstance().connectionChange,
//                            builder: (context, snapshot) {
                              child: RaisedButton(
                                padding:
                                    EdgeInsets.fromLTRB(48.0, 15.0, 48.0, 15.0),
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(30.0)),
                                highlightColor: Colors.white,
                                highlightElevation: 4.0,
                                child: Text(
                                  UIData.label_done,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: UIData.font_nunito_sans,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 20.0),
                                ),
                                color: Colors.black,
                                elevation: 8.0,
                                onPressed: () {
//                                  if (snapshot != null && snapshot.hasData) {
                                      _doneButtonPressed();
//                                  } else {
//                                    showSnackBarNoConnection();
//                                  }
                                },
//                              );
//                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: size.width * intersectionWidthScale,
                  height: size.height,
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      Opacity(
                        opacity: 1,
                        child: new Image.asset(
                          UIData.image_profile_intersection,
                          fit: BoxFit.cover,
                          color: Colors.black54,
                          colorBlendMode: BlendMode.darken,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(32.0),
                            child: GestureDetector(
                              child: new Image.asset(
                                UIData.image_frinks,
                                fit: BoxFit.scaleDown,
                                width: 200,
                              ),
                              onTap: () {
                                Navigator.of(context).pushNamed(SPLASH_SCREEN);
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            isLoading
                ? Opacity(
                    opacity: 0.4,
                    child: ModalBarrier(dismissible: false, color: Colors.grey),
                  )
                : SizedBox(),
            isLoading
                ? Center(
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            SizedBox(
                              height: 65.0,
                              width: 65.0,
                              child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: loadingWidget),
                            ),
                            Text(
                              'Please wait...',
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.w700),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    phoneController.dispose();
    emailController.dispose();
    occasionController.dispose();
    peopleNumberController.dispose();
    ConnectionUtils.getInstance().dispose();
    super.dispose();
  }
}
