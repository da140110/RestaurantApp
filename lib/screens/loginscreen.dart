import 'dart:async';
import 'package:battery/battery.dart';
import 'package:finesse/constant/Constant.dart';
import 'package:finesse/util/text_styles.dart';
import 'package:finesse/util/uidata.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:finesse/model/login_info.dart';
import 'package:finesse/api/FinesseApi.dart';
import 'package:screen/screen.dart';
//import 'package:battery/battery.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => new LoginScreenState();
}

class LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Battery _battery = Battery();
  BatteryState _batteryState;
  StreamSubscription<BatteryState> _batteryStateSubscription;
  LoginInfo user;
  String cafeID = "";
  String password = "";
  bool _showBatteryNotify = false;
  final TextEditingController cafeIDController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  @override
  void initState() {
    Screen.keepOn(true);
    _batteryStateSubscription =
        _battery.onBatteryStateChanged.listen((BatteryState state) async {
      _batteryState = state;
      final int batteryLevel = await _battery.batteryLevel;
      if (batteryLevel < 20 &&
          !_showBatteryNotify &&
          _batteryState != BatteryState.charging) {
        openNotification(
            context,
            "Battery may run out soon",
            "Please connect device to charger",
            Icon(
              Icons.battery_alert,
              size: 35.0,
              color: Colors.redAccent,
            ));
        _showBatteryNotify = true;
      }
      print(batteryLevel.toString());
      print(_batteryState.toString());
      setState(() {});
    });
    super.initState();
    Screen.setBrightness(0.2);
    cafeIDController.addListener(_setcafeID);
    passwordController.addListener(_setpassword);
    user = loginUser;
  }

  @override
  void dispose() {
    super.dispose();
    if (_batteryStateSubscription != null) {
      _batteryStateSubscription.cancel();
    }
  }

  _setcafeID() {
    cafeID = cafeIDController.text;
    currentCafe.caffeId = cafeID;
    user.caffeID = cafeID;
    debugPrint("cafeiD is ---------" + cafeID);
  }

  _setpassword() {
    password = passwordController.text;
    user.password = password;
    debugPrint("password is ---------" + password);
  }

  _doneButtonPressed() {
    if (cafeID == null || password == null) {
      showSnackBar1();
    } else {
      _registerRequest();
      // //debugPrint("done button pressed" );
    }
  }

  void _registerRequest() {
    api.loginRequest(user).then((response) {
      debugPrint("login " + response.valid.toString());
      if (response.valid == true) {
        Navigator.of(context).pushNamed(TABLEID_SCREEN);
        user.caffeID = cafeID;
      } else {
        showSnackBar2();
      }
    });
  }

  void showSnackBar1() {
    _scaffoldKey.currentState
      ..showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          "Please Enter Username and password",
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
          "Username or password incorrect",
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
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        key: _scaffoldKey,
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(300.0, 100.0, 300.0, 0.0),
                  child: TextField(
                    controller: cafeIDController,
                    style: TextStyles.TEXT_FIELD_INPUT_STYLE,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      // labelText: UIData.label_name,
                      hintText: "Username",
                      hintStyle: TextStyles.TEXT_FIELD_LABLE_STYLE,
                      // labelStyle: TextStyles.TEXT_FIELD_LABLE_STYLE,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(300.0, 20.0, 300.0, 0.0),
                  child: TextField(
                    controller: passwordController,
                    style: TextStyles.TEXT_FIELD_INPUT_STYLE,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    decoration: InputDecoration(
                      // labelText: UIData.label_name,
                      hintText: "Password",
                      hintStyle: TextStyles.TEXT_FIELD_LABLE_STYLE,
                      // labelStyle: TextStyles.TEXT_FIELD_LABLE_STYLE,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(300.0, 30.0, 300.0, 0.0),
                  alignment: Alignment.bottomRight,
                  child: RaisedButton(
                    padding: EdgeInsets.fromLTRB(48.0, 15.0, 48.0, 15.0),
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
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
                      debugPrint('The user wants to login with ' +
                          cafeID +
                          ' and ' +
                          password);
                      user.caffeID = cafeID;
                      user.password = password;
                      debugPrint('The user wants to login with ' +
                          user.password +
                          ' and ' +
                          user.caffeID);
                      _doneButtonPressed();
//                      Navigator.of(context).pushNamed(TABLEID_SCREEN);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<Null> openNotification(
      BuildContext context, String title, String body, Icon icon) async {
    final themeColor = Color(0xfff5a623);
    final primaryColor = Color(0xff203152);
    final greyColor = Color(0xffaeaeae);
    final greyColor2 = Color(0xffE8E8E8);
    switch (await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            contentPadding:
                EdgeInsets.only(left: 0.0, right: 0.0, top: 0.0, bottom: 0.0),
            children: <Widget>[
              Container(
                color: Colors.black,
                margin: EdgeInsets.all(0.0),
                padding: EdgeInsets.only(bottom: 10.0, top: 10.0),
                height: 170.0,
                child: Column(
                  children: <Widget>[
                    Container(
                      child: icon,
                      margin: EdgeInsets.only(bottom: 10.0),
                    ),
                    Text(
                      title,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      body,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(color: Colors.yellowAccent, fontSize: 20.0),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SimpleDialogOption(
                    onPressed: () {
                      Navigator.pop(context, 0);
                    },
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: Icon(
                            Icons.check_circle,
                            color: primaryColor,
                          ),
                          margin: EdgeInsets.only(right: 10.0),
                        ),
                        Text(
                          'OK',
                          style: TextStyle(
                              color: primaryColor, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          );
        })) {
      case 0:
        _showBatteryNotify = false;
        break;
    }
  }
}
