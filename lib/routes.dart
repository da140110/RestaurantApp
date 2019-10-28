import 'package:finesse/constant/Constant.dart';
import 'package:finesse/screens/loginscreen.dart';
import 'package:finesse/screens/BillingScreen.dart';
import 'package:finesse/screens/FeedbackScreen.dart';
import 'package:finesse/screens/HomeScreen.dart';
import 'package:finesse/screens/MenuScreen.dart';
import 'package:finesse/screens/OnYourTableScreen.dart';
import 'package:finesse/screens/OrderScreen.dart';
import 'package:finesse/screens/TableID.dart';
import 'package:finesse/screens/SplashScreen.dart';
import 'package:finesse/screens/ThankYouScreen.dart';
import 'package:finesse/util/uidata.dart';
import 'package:flutter/material.dart';

class Routes {
  final routes = <String, WidgetBuilder>{
    LOGIN_SCREEN: (BuildContext context) => LoginScreen(),
    TABLEID_SCREEN: (BuildContext context) => TableIDScreen(),
    SPLASH_SCREEN: (BuildContext context) => SplashScreen(),
    HOME_SCREEN: (BuildContext context) => HomeScreen(),
    BILLING_SCREEN: (BuildContext context) => BillingScreen(),
    MENU_SCREEN: (BuildContext context) => MenuScreen(),
    FEEDBACK_SCREEN: (BuildContext context) => FeedbackScreen(),
    THANK_YOU_SCREEN: (BuildContext context) => ThankYouScreen(),
    ON_YOUR_TABLE_SCREEN: (BuildContext context) => OnYourTableScreen(),
    ORDER_SCREEN: (BuildContext context) => OrderScreen(),
  };
  Routes() {
    runApp(MaterialApp(
      title: UIData.appName,
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        accentColor: Color(0xFF761322),
      ),
      routes: routes,
    ));
  }
}
