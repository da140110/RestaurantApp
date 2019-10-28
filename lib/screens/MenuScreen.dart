import 'dart:async';
import 'dart:ui';
import 'package:finesse/constant/Constant.dart';
import 'package:finesse/logic/bloc/category_bloc.dart';
import 'package:finesse/model/menu_category.dart';
import 'package:finesse/screens/CategoryList.dart';
import 'package:finesse/util/uidata.dart';
import 'package:finesse/widgets/Appbar.dart';
import 'package:finesse/widgets/Comment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MenuScreen extends StatefulWidget {
  @override
  MenuScreenState createState() => new MenuScreenState();
}

class MenuScreenState extends State<MenuScreen>
    with SingleTickerProviderStateMixin {

  CategoryBloc categoryBloc = CategoryBloc();

  final double leftWidthScale = .2872;
  final double bodyWidthScale = .7128;
  final double leftPaddingScale = 0.078125;
  final double topPaddingScale = 0.166;
  final double verticalGapBetweenfields = 12.0;

  static List<String> options = <String>[
    'Comment1',
    'Comment2',
    'Comment3',
    'Comment4',
  ];

  TextStyle textStyleActive = TextStyle(
      fontFamily: UIData.font_nunito_sans,
      fontSize: 17.0,
      color: Colors.black,
      fontWeight: FontWeight.w800,
      fontStyle: FontStyle.normal);



//  bool foodMenuPressed = true;
//  bool ngoMenuPressed = false;

  @override
  void initState() {
    categoryBloc.getfoodcategory();
    super.initState();
  }

  Widget categoryGrid(List<FoodCategory> products){
    currentCategory = products[0];
    return GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.only(right: 10.0, left: 10.0),
        childAspectRatio: 300.0 / 220.0,
        children: products
            .map(
              (product) => CategoryList(item: product),
            )
            .toList(),
      );
      }

  Widget bodyData() {
    return StreamBuilder<List<FoodCategory>>(
        stream: categoryBloc.fodoCategorytItems,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? categoryGrid(snapshot.data)
              : Center(child: CircularProgressIndicator());
        });
  }

  Future<bool> _onBackPressed() async{
    return false;
  }

  var size;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: CustomAppBar.getAppBar(context),
        body: scaffoldBody(),
      ),
    );
  }

  Widget scaffoldBody() {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
                width: size.width * leftWidthScale,
                height: size.height,
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: Opacity(
                        opacity: .99,
                        child: new Image.asset(
                          UIData.image_hashtag,
                          fit: BoxFit.cover,
                          color: Colors.black54,
                          colorBlendMode: BlendMode.darken,
                        ),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              UIData.label_trending_in_food,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: UIData.font_nunito_sans,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 19),
                            ),
                          ),
                          flex: 1,
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(right: 10,left: 10),
                              child: new CommentContent(comments: options)),
                          flex: 9,
                        ),
                      ],
                    )
                  ],
                )),
            Container(
                width: size.width * bodyWidthScale,
                padding: EdgeInsets.only(
                  top: (size.height * topPaddingScale)/8,
                  left: (size.width * leftPaddingScale)/4,
                  right: (size.width * leftPaddingScale)/4,
                ),
                child: bodyContent()),
          ],
        )
      ],
    );
  }

  Widget bodyContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              currentCafe.caffename,
              style: TextStyle(
                  fontFamily: UIData.font_nunito_sans,
                  fontSize: 29.0,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Text(
              '${currentCafe.caffeAddress} | ${currentCafe.type}',
              style: TextStyle(
                fontFamily: UIData.font_nunito_sans,
                fontSize: 17.0,
                color: Color(0xFF8B8B8B),
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 5.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              UIData.label_categories,
              style: textStyleActive ,
            ),

//            GestureDetector(
//              onTap: _foodMenuTapped,
//              child: Text(
//                UIData.label_food_menu,
//                style: foodMenuPressed ? textStyleActive : textStyleNormal,
//              ),
//            ),
//            GestureDetector(
//              onTap: _ngoMenuTapped,
//              child: Text(
//                UIData.label_ngos,
//                style: ngoMenuPressed ? textStyleActive : textStyleNormal,
//              ),
//            ),
          ],
        ),
        Divider(
          color: Colors.grey,
          height: 4.0,
        ),
        SizedBox(
          height: 10,
        ),
        Expanded(
            child: Scrollbar(
              child: bodyData(),
        )),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

//  _foodMenuTapped() {
//    setState(() {
//      foodMenuPressed = true;
//      ngoMenuPressed = false;
//    });
//  }
//
//  _ngoMenuTapped() {
//    setState(() {
//      foodMenuPressed = false;
//      ngoMenuPressed = true;
//    });
//  }
}
