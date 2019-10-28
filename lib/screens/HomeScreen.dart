import 'dart:async';
import 'package:finesse/constant/Constant.dart';
import 'package:finesse/util/uidata.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => new HomeScreenState();
}

class HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  var _visible = true;

  final double logoWidthScale = .50;
  final double logoHeightScale = .12;

  AnimationController animationController;
  Animation<double> animation;

  startTime() async {
    var _duration = new Duration(milliseconds: 1000);
    return new Timer(_duration, hideSplash);
    // return new Timer(_duration, navigationPage);
  }

  goToMainMenu() async {
    var _duration = new Duration(milliseconds: 200);
    return new Timer(_duration, navigationPage);
  }

  void hideSplash() {
    setState(() {
      _visible = !_visible;
    });
    goToMainMenu();
  }

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed(BILLING_SCREEN);
  }

  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(
      vsync: this,
      duration: new Duration(milliseconds: 1000),
    );
    animation =
        new CurvedAnimation(parent: animationController, curve: Curves.easeOut);

    animation.addListener(() => this.setState(() {}));
    // animationController.forward();
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        //animationController.reverse();
        Navigator.of(context).pushReplacementNamed(BILLING_SCREEN);
      } else if (status == AnimationStatus.dismissed) {
        //animationController.forward();
        Navigator.of(context).pushReplacementNamed(BILLING_SCREEN);

      }
    });
    //animationController.forward();
    startTime();
  }

  Future<bool> _onBackPressed() async{
    return false;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
//    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            AnimatedOpacity(
              opacity: _visible ? 1.0 : 0.0,
              duration: Duration(milliseconds: 10000),
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Opacity(
                    opacity: 1,
                                    child: new Image.asset(
                      UIData.image_home_splash,
                      fit: BoxFit.cover,
                      color: Colors.black54,
                      colorBlendMode: BlendMode.darken,
                    ),
                  ),
                  new Image.asset(
                    UIData.image_frinks,
                    fit: BoxFit.none,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
