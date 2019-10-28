import 'dart:ui';

import 'package:flutter/material.dart';

class UIData {
  static String name = "Dharmgya";
  static  String label_welcome = "Welcome to Beyond Coffe, " + name + "!";
  //strings
  static const String appName = "Finesse";

  static const String text_arrived = "Arrived ?";
  static const String text_tap_to_say = "Tap to say yes!";
  static const String text_thank_you = "Thank you for your visit!";
  static const String text_bye_message = "Hope to see you again soon!";
  static const String billing_title = "We would like to know you!";
  static const String billing_details_title = "Billing details";
  static const String label_compulsory = "*";
  static const String label_name = "Name";
  static const String label_age = "Age";
  static const String label_Phone = "Phone No.";
  static const String label_email = "Email";
  static const String label_occasion = "# Ocassion for the visit";
  static const String label_people_no = "Number of people on the table";
  static const String label_done = "Done";
  static const String label_exit = "Exit Table";
  static const String label_credit_debit = "Credit/Debit CARD";
  static const String label_cash = "CASH";
  static const String label_wallet = "Wallet: Paytm, GooglePay, PhonePay, BhimUPI";
  static const String label_feedback_one = "Overall Experience *";
  static const String label_feedback_two = "FRINKS Digital Menu *";
  static const String label_feedback_three = "Ambience";
  static const String label_feedback_four = "Food Quality";
  static const String label_feedback_five = "Service";
  static const String label_food_menu = "FOOD MENU";
  static const String label_categories = "CATEGORIES";
  static const String label_ngos = "NGOS";
  static const String label_customize = "Customizable";
  static const String label_select_option = "Please select any one option";
  static const String label_add_extra = "Add extra";
  static const String label_item = "ITEM";
  static const String label_quantity = "QUANTITY";
  static const String label_price = "PRICE";
  static const String label_amount = "AMOUNT";
  static const String label_trending_in_food = "Trending in Food";
  static const String label_what_are_you_thinking = "What are you thinking?";
  static const String label_add_more = "Add more";
  static const String label_place_order = "Place order";
  static const String label_edit_order = "Edit order";
  static const String label_yes = "Yes";
  static const String label_no = "No";
  static const String label_repeat_order = "Repeat Order?";
  static const String title_beyond_coffee = "Beyond Coffee";
  static const String subtitle_beyond_coffee = "Jubilee Hills | Cafe";
  static const String title_order_status = "Order Status";
  static const String subtitle_order_status = "Delicious food on your way!";
  static const String title_on_your_table = "Send order to kitchen";
  static const String subtitle_on_your_table = "Would you like to add/delete something from your platter!";
  static const String rupee_sign = "₹";

  static const String label_donate_to_ngo = "DONATE TO NGO:";


  static const String label_know_more_about_ngo = "Know more about NGO";

  static const String title_issue_dialoge = "Raise an issue";
  static const String subtitle_issue_dialoge = "Please select from below any issue that you would \n like to notify to the manager";
  static const String label_issue_comment = "Any other issue ? Please type here";
  static const String title_raise_another = "Raise another issue";
  static const String msg_issue_raised = "Issue raised";
  
  static const String title_payment = "PAYMENT OPTIONS";
  static const String subtitle_payment = "Choose your preferred payment options";
  static const String title_feedback = "Feedback";
  static const String subtitle_feedback = "Your request for payment has been recieved.\nOur Executive will arrive at your table soon.\n\nKindly let us know about your experience till then.";
  static const String title_additional_comments = "Any additional comments?";

 // image path

  static const String image_nob = 'assets/images/nob.png';
  static const String image_home_splash = 'assets/images/home_splash.png';
  static const String image_favicon_black = 'assets/images/favicon_black.png';
  static const String image_frinks = 'assets/images/frinksBig.png';
  static const String image_profile_intersection = 'assets/images/intersection1.png';
  static const String image_star_off = "assets/images/off2x.png";
  static const String image_star_on = "assets/images/on2x.png";
  static const String image_hashtag = "assets/images/Rectangle11.png";
  static const String image_breakfast = "assets/images/Rectangle11.png";
  static const String image_left_background = "assets/images/leftbackground.jpg";
  static const String image_unavailable = "assets/images/Unavailable.png";

//fonts
  static const String font_nunito_sans = "Nunito Sans";

// color gradients
  static  LinearGradient color_grid_item_bkg  = LinearGradient(
          // Where the linear gradient begins and ends
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          // Add one stop for each color. Stops should increase from 0 to 1
          stops: [0.1, 0.5, 0.7, 0.9],
          
          colors: [
            // Colors are easy thanks to Flutter's Colors class.
            Colors.black87,
            Colors.black54,
            Colors.black45,
            Colors.black38,

            
          ],
        );





  static Widget buttonRow(icon,iconColor,label,bkgColor) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            // color: Colors.blue,
            decoration: new BoxDecoration(
            color: bkgColor,
            borderRadius: BorderRadius.circular(5.0),
            ),
            child: Icon(
              icon,
              size: 32.0,
              color: iconColor,
            ),
          ),
          SizedBox(
            width: 5.0,
          ),
          Text(
            label,
            style: TextStyle(
      fontSize: 18.0, color: Colors.black, fontWeight: FontWeight.bold),
          )
        ],
      );  

}