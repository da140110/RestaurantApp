import 'dart:async';
import 'package:finesse/constant/Constant.dart';
import 'package:finesse/logic/bloc/category_bloc.dart';
import 'package:finesse/logic/bloc/food_item_bloc.dart';
import 'package:finesse/model/food_item.dart';
import 'package:finesse/model/menu_category.dart';
import 'package:finesse/screens/ItemList..dart';
import 'package:finesse/util/uidata.dart';
import 'package:finesse/widgets/Appbar.dart';
import 'package:finesse/widgets/Comment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FoodMenuScreen extends StatefulWidget {
  final String categoryName;
  FoodMenuScreen(this.categoryName);
  @override
  FoodMenuScreenState createState() => new FoodMenuScreenState(categoryName);
}

class FoodMenuScreenState extends State<FoodMenuScreen>
    with SingleTickerProviderStateMixin {
  final String categoryName;
  FoodMenuScreenState(this.categoryName);

  CategoryBloc categoryBloc = CategoryBloc();
  FoodItemBloc foodItemBloc = FoodItemBloc();

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
  TextStyle textStyleInActive = TextStyle(
      fontFamily: UIData.font_nunito_sans,
      fontSize: 17.0,
      color: Colors.grey,
      fontWeight: FontWeight.w800,
      fontStyle: FontStyle.normal);
  TextStyle textStyleNormal = TextStyle(
      fontFamily: UIData.font_nunito_sans,
      fontSize: 17.0,
      color: Color.fromRGBO(139, 139, 139, 1.0),
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal);

  bool categoryNamePressed = true;

  @override
  void initState() {
    categoryBloc.getfoodcategory();
    foodItemBloc.getfoodMenuBycategory(categoryName);
    super.initState();
  }

  Widget foodItemGrid(List<FoodItem> products) => GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.only(right: 5.0, left: 5.0),
        childAspectRatio: 300.0 / 120.0,
        children: products
            .map(
              (product) => FoodItemList(item: product),
            )
            .toList(),
      );

  Widget bodyData() {
    return StreamBuilder<List<FoodItem>>(
        stream: foodItemBloc.foodItems,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? foodItemGrid(snapshot.data)
              : Center(child: CircularProgressIndicator());
        });
  }

  Widget horizontalCategoryList(List<FoodCategory> products) => GridView.count(
        crossAxisCount: 1,
        padding: EdgeInsets.only(right: 4.0, left: 4.0),
        childAspectRatio: 1 / 7,
        scrollDirection: Axis.horizontal,
        children: products
            .map((category) => InkWell(
                  onTap: () {
                    setState(() {
                      foodItemBloc.getfoodMenuBycategory(category.title);
                      currentCategory.title = category.title;
                    });
                  },
                  child: Text(
                    category.title,
                    style: currentCategory.title == category.title
                        ? textStyleActive
                        : textStyleInActive,
                  ),
                ))
            .toList(),
      );

  Widget listRowData() {
    return StreamBuilder<List<FoodCategory>>(
        stream: categoryBloc.fodoCategorytItems,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? horizontalCategoryList(snapshot.data)
              : Center(child: CircularProgressIndicator());
        });
  }

  Future<bool> _onBackPressed() async {
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
                              padding: EdgeInsets.only(right: 10, left: 10),
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
                  top: (size.height * topPaddingScale) / 8,
                  left: (size.width * leftPaddingScale) / 4,
                  right: (size.width * leftPaddingScale) / 4,
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
            Container(
              child: Text(
                currentCafe.caffename,
                style: TextStyle(
                    fontFamily: UIData.font_nunito_sans,
                    fontSize: 29.0,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              padding: EdgeInsets.only(right: 30),
              height: 40,
              width: 70,
              child: FloatingActionButton(
                backgroundColor: Color(0xFF000000),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Icon(
                        const IconData(0xe909, fontFamily: 'icomoon'),
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
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
        // Cafe info ---------end
        new Container(
          width: size.width,
          height: 28,
          child: listRowData(),
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
          height: 60,
        ),
      ],
    );
  }
}
