import 'dart:async';
import 'package:finesse/api/FinesseApi.dart';
import 'package:finesse/constant/Constant.dart';
import 'package:finesse/logic/bloc/order_bloc.dart';
import 'package:finesse/model/food_item_order.dart';
import 'package:finesse/model/order_detail.dart';
import 'package:finesse/screens/OnYourTableList.dart';
import 'package:finesse/util/uidata.dart';
import 'package:finesse/widgets/Appbar.dart';
import 'package:finesse/widgets/Comment.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class OnYourTableScreen extends StatefulWidget {
  @override
  OnYourTableScreenState createState() => new OnYourTableScreenState();
}

class OnYourTableScreenState extends State<OnYourTableScreen>
    with SingleTickerProviderStateMixin {
  OrderBloc orderBloc = OrderBloc();
  bool done;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final double leftWidthScale = .2872;
  final double bodyWidthScale = .7128;
  final double leftPaddingScale = 0.078125;
  final double topPaddingScale = 0.166;
  final double verticalGapBetweenfields = 12.0;
  final double listItemHeightScale = .0703125;
  final double scaleWithoutPadding = .6737375;

  static List<String> options = <String>[
    'Option1',
    'Option2',
    'Option3',
    'Option4',
  ];

  TextStyle textStyleActive = TextStyle(
      fontFamily: UIData.font_nunito_sans,
      fontSize: 15.0,
      color: Colors.black,
      fontWeight: FontWeight.w800,
      fontStyle: FontStyle.normal);

  @override
  void initState() {
    orderBloc.getOrders();
    done = true;
    super.initState();
  }

  _placeOrderButtonPressed() {
    //debugPrint("placeOrderButton Pressed");
    List<Order> current_order_list = [];

    currentOrderList.forEach(
      (order){
        if(order.order_identifier==CURRENT_ORDER_IDENTIFIER)
        current_order_list.add(order);
      }
    );

    if(current_order_list.isEmpty)
      return;

      api.makeOrderRequest().then(
    (response){
      //debugPrint("Reply in make order "+ response.makeOrder);
    if(response.makeOrder.compareTo("success")==0)
     {
      isOrderInitiated = false;
      LAST_ORDER_IDENTIFIER = CURRENT_ORDER_IDENTIFIER;
      CURRENT_ORDER_IDENTIFIER = "";

      Navigator.of(context).pushReplacementNamed(ORDER_SCREEN);
     }
    }
  );
  }

  Widget orderGrid(List<Order> orders) => GridView.count(
        crossAxisCount: 1,
        padding: EdgeInsets.only(right: 4.0, left: 4.0),
        childAspectRatio: 600.0 / 54,
        children: getOrderItemListWidget(orders),
        // orders
        //     .map(
        //       (order) => OnYourTableList(item: order),
        //     )
        //     .toList(),
      );

List<Widget> getOrderItemListWidget(List<Order> orders){

 List<Widget> list = new List<Widget>();
    for(var i = 0; i < orders.length; i++){
        if(orders[i].order_identifier==CURRENT_ORDER_IDENTIFIER){
        for(var j = 0; j < orders[i].items.length; j++){
          FoodItemOrder item = orders[i].items[j];
          list.add(OnYourTableList(item:item,order: orders[i]));
        }
        }

        // list.add(new Text(strings[i]));
       
    }
 return list;
 
}

  Widget bodyData() {
    
    return StreamBuilder<List<Order>>(
        stream: orderBloc.orderItems,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? orderGrid(snapshot.data)
              : Center(child: CircularProgressIndicator());
        });
  }

  Future<bool> _onBackPressed() async{
    return false;
  }

//  BuildContext _context;
  var size;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
//    _context = context;
    size = MediaQuery.of(context).size;
    // //debugPrint(" height -- " + size.height.toString());
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
                  top: (size.height * topPaddingScale) / 8,
                  left: (size.width * leftPaddingScale) / 4,
                  right: (size.width * leftPaddingScale) / 4,
                ),
                // color: Colors.white,
                child: bodyContent()),
          ],
        )
      ],
    );
  }

  Widget bodyContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Text(
                UIData.title_on_your_table,
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
                heroTag: DateTime.now().millisecondsSinceEpoch.toString(),
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
                ), //Image.asset(name),
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Text(
              UIData.subtitle_on_your_table,
              style: TextStyle(
                  fontFamily: UIData.font_nunito_sans,
                  fontSize: 17.0,
                  color: Color.fromRGBO(139, 139, 139, 1.0),
                  // fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal),
            ),
          ],
        ),
//        SizedBox(
//          height: 5.0,
//        ),
        Container(
          margin: const EdgeInsets.fromLTRB(0.5, 0.0, 1.0, 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(
                width: 26,
              ),
              Container(
                width: (size.width * scaleWithoutPadding*0.25)-2,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    UIData.label_item,
                    textAlign: TextAlign.left,
                    style: textStyleActive ,
                  ),
                ),
              ),
              SizedBox(
                width: (size.width * scaleWithoutPadding*0.25)-2,
              ),
              Container(
                width: (size.width * scaleWithoutPadding*0.125)-2,
                child: Text(
                  UIData.label_quantity,
                  textAlign: TextAlign.center,
                  style: textStyleActive ,
                ),
              ),
              Container(
                width: (size.width * scaleWithoutPadding*0.125)-2.5,
                child: Text(
                  UIData.label_price,
                  textAlign: TextAlign.center,
                  style: textStyleActive ,
                ),
              ),
              Container(
                width: (size.width * scaleWithoutPadding*0.125) -1,
                child: Text(
                  UIData.label_amount,
                  textAlign: TextAlign.center,
                  style: textStyleActive ,
                ),
              ),
              SizedBox(
                width: ((size.width * scaleWithoutPadding)*0.125)-26,
              ),
            ],
          ),
        ),
//        Row(
//          mainAxisAlignment: MainAxisAlignment.spaceAround,
//          children: <Widget>[
//            Expanded(
//              child: Padding(
//                padding: const EdgeInsets.only(
//                  left: 48.0
//                ),
//                child: Text(UIData.label_item,
//                    textAlign: TextAlign.left,
//                    style: TextStyle(
//                      fontFamily: UIData.font_nunito_sans,
//                      fontSize: 13,
//                      color: Colors.black,
//                      fontWeight: FontWeight.w900,
//                    )),
//              ),
//            ),
//            Expanded(
//              child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceAround,
//                children: <Widget>[
//                  Expanded(
//                    child: Text(UIData.label_quantity,
//                        style: TextStyle(
//                          fontFamily: UIData.font_nunito_sans,
//                          fontSize: 13,
//                          color: Colors.black,
//                          fontWeight: FontWeight.w900,
//                        )),
//                  ),
//                  Spacer(),
//                  Expanded(
//                    child: Text(UIData.label_price,
//                        style: TextStyle(
//                          fontFamily: UIData.font_nunito_sans,
//                          fontSize: 13,
//                          color: Colors.black,
//                          fontWeight: FontWeight.w900,
//                        )),
//                  ),
//                  Spacer(),
//                  Expanded(
//                    child: Text(UIData.label_amount,
//                        style: TextStyle(
//                          fontFamily: UIData.font_nunito_sans,
//                          fontSize: 13,
//                          color: Colors.black,
//                          fontWeight: FontWeight.w900,
//                        )),
//                  ),
//                ],
//              ),
//            ),
//            Row(
//              mainAxisAlignment: MainAxisAlignment.end,
//              children: <Widget>[
//                FlatButton(
//                  child: Icon(
//                    const IconData(0xe907, fontFamily: 'icomoon'),
//                    color: Colors.grey[50],
//                    size: 16,
//                  ), //Image.asset(name),
//                  shape: CircleBorder(),
//                  color: Colors.grey[50],
//                  onPressed: () {},
//                ),
//              ],
//            )
//          ],
//        ),
        Divider(
          color: Colors.grey,
          height: 1.0,
        ),
        SizedBox(
          height: 10,
        ),
        Expanded(
            child: Scrollbar(
          child: bodyData(),
        )),
        SizedBox(
          height: 10,
        ),
        bottomButtons(),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget bottomButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
//        FlatButton(
//            color: Colors.black,
//            padding: const EdgeInsets.fromLTRB(32.0,8.0,32.0,8.0),
//            shape: RoundedRectangleBorder(
//              borderRadius: BorderRadius.circular(16.0),
//            ),
//            onPressed: () {
//              Navigator.of(context).pushNamed(MENU_SCREEN);
//              // issueRaiseDialogConfirmation(context);
//            },
//            child: Text(
//              UIData.label_add_more,
//              style: TextStyle(
//                  color: Colors.white,
//                  fontSize: 16.0,
//                  fontFamily: UIData.font_nunito_sans,
//                  fontWeight: FontWeight.w700),
//            )),
        Container(
          height: 60,
          width: 150,
          child: FlatButton(
              color: Colors.green,
              padding: const EdgeInsets.fromLTRB(28.0,4.0,28.0,4.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              onPressed: () {
                if(done) {
                  _placeOrderButtonPressed();
                  done = false;
                }
              },
              child: Text(
                "Confirm",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontFamily: UIData.font_nunito_sans,
                    fontWeight: FontWeight.w700),
              )),
        ),
      ],
    );
  }
}
