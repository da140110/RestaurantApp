import 'dart:async';
import 'package:finesse/constant/Constant.dart';
import 'package:finesse/util/uidata.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThankYouScreen extends StatefulWidget {
  @override
  ThankYouScreenState createState() => new ThankYouScreenState();
}

class ThankYouScreenState extends State<ThankYouScreen>
    with SingleTickerProviderStateMixin {
  var _visible = true;

  final double logoWidthScale = .50;
  final double logoHeightScale = .12;

    final double fabIconWidthScale = .154;
  final double nobWidthScale = .459;

  AnimationController animationController;
  Animation<double> animation;

  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, hideSplash);
  }

  goToMainMenu() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }

  void hideSplash() {
    setState(() {
      _visible = !_visible;
    });
    goToMainMenu();
  }

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed(SPLASH_SCREEN);
  }

  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(
      vsync: this,
      duration: new Duration(seconds: 2),
    );
    animation =
        new CurvedAnimation(parent: animationController, curve: Curves.easeOut);

    animation.addListener(() => this.setState(() {}));

    startTime();
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
            AnimatedOpacity(
              opacity: _visible ? 1.0 : 0.0,
              duration: Duration(milliseconds: 1000),
              child: Stack(
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
                    UIData.text_thank_you,
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
                    UIData.text_bye_message,
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
          ],
        ),
      ),
    );
  }
}
