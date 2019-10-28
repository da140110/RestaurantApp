import 'dart:async';
import 'package:finesse/constant/Constant.dart';
import 'package:finesse/util/uidata.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:screen/screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => new SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  var _visible = true;


  final double fabIconWidthScale = .154;
  final double nobWidthScale = .459;

  AnimationController animationController;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    Screen.setBrightness(0.1);
    animationController = new AnimationController(
      vsync: this,
      duration: new Duration(seconds: 3),
    );
    animation =
        new CurvedAnimation(parent: animationController, curve: Curves.easeOut);

    animation.addListener(() => this.setState(() {}));
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.reset();
        animationController.forward();

      } else if (status == AnimationStatus.dismissed) {
        animationController.forward();

      }
    });
    animationController.forward();

    setState(() {
      _visible = !_visible;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    super.dispose();
  }

  Future<bool> _onBackPressed() async{
    return false;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Image.asset(
                UIData.image_nob,
                width: animation.value * size.width * nobWidthScale,
                height: animation.value * size.width * nobWidthScale,
              ),
            ],
          ),
          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 0.0),
                child: new Text(
                  UIData.text_arrived,
                  style: TextStyle(
                      fontSize: 38,
                      fontFamily: UIData.font_nunito_sans,
                      fontWeight: FontWeight.w300),
                 ),
              ),
              SizedBox(
                height: (size.width * fabIconWidthScale) / 2 - 20.0,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacementNamed(HOME_SCREEN);
                },
                child: Padding(
                  padding: EdgeInsets.only(bottom: 0.0),
                  child: new Image.asset(
                    UIData.image_favicon_black,
                    height: size.width * fabIconWidthScale,
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
              SizedBox(
                height: (size.width * fabIconWidthScale) / 2,
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 0.0),
                child: new Text(
                  UIData.text_tap_to_say,
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: UIData.font_nunito_sans,
                      fontStyle: FontStyle.italic),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
    );
  }
}




