import 'dart:async';
import 'package:finesse/constant/Constant.dart';
import 'package:finesse/logic/bloc/order_bloc.dart';
import 'package:finesse/model/food_item_order.dart';
import 'package:finesse/model/order_detail.dart';
import 'package:finesse/model/payment_request.dart';
import 'package:finesse/screens/OrderList.dart';
import 'package:finesse/screens/PaymentScreen.dart';
import 'package:finesse/util/uidata.dart';
import 'package:finesse/widgets/Appbar.dart';
import 'package:finesse/widgets/Comment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OrderScreen extends StatefulWidget {
  @override
  OrderScreenState createState() => new OrderScreenState();
}

class OrderScreenState extends State<OrderScreen>
    with SingleTickerProviderStateMixin {

  OrderBloc orderBloc = OrderBloc();

  final double leftWidthScale = .2872; //.557;
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

  var isStatusScreen = false;
  bool fetched = true;

  @override
  void initState() {
    orderBloc.getOrders();
    super.initState();
  }


  gettotalPayable() {
    totalPayable = 0.0;
    currentOrderList.forEach((o) {
      for (var j = 0; j < o.items.length; j++) {
        FoodItemOrder item = o.items[j];
        debugPrint("order list iss: " + item.foodItem.toString());
        item.addonPrice = 0.0;
        for (int i=0;i<item.addon.length;i++){
          item.addonPrice = item.addonPrice + item.addon[i].addonPrice;
        }
        totalPayable =
            totalPayable + ((item.unitPrice + item.addonPrice) * item.quantity);
      }
    });
    debugPrint("if else" + totalPayable.toString());
  }

  _endSessionButtonPressed() {
    Payment paymentReq = new Payment();
    paymentReq.caffeID = currentCafe.caffeId;
    paymentReq.tableidtimestamp = currentUser.tableIdTimestamp;
    paymentReq.tableid = currentUser.tableId;
    paymentReq.ngoPayment = ngoAmount.toInt();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentScreen(paymentReq),
      ),
    );
  }

  Widget orderGrid(List<Order> orders) =>
      GridView.count(
        crossAxisCount: 1,
        padding: EdgeInsets.only(right: 4.0, left: 4.0),
        childAspectRatio: 600.0 / 54,
        children: getOrderItemListWidget(orders),
        // orders
        //     .map(
        //       (order) => OrderList(item: order),
        //     )
        //     .toList(),
      );

  List<Widget> getOrderItemListWidget(List<Order> orders) {
    List<OrderList> list = [];
    //debugPrint("orders length " + orders.length.toString());
    for (var i = 0; i < orders.length; i++) {
      //debugPrint("items length " + orders[i].items.length.toString());
      // Order order = orders[i];
      // if(order.is_placed){
      //   order.status = ORDER_STATUS[];
      // }
      for (var j = 0; j < orders[i].items.length; j++) {
        FoodItemOrder item = orders[i].items[j];
        // totalPayable =
        // totalPayable + item.unitPrice * item.quantity + item.addonPrice;
        list.add(OrderList(item: item, order: orders[i]));
      }

      //debugPrint("toatl payable  " + totalPayable.toString());
      // list.add(new Text(strings[i]));

    }
    //debugPrint("FoodItem list size " + list.length.toString());
    return list;
  }

  Widget bodyData() {
    return StreamBuilder<List<Order>>(
        stream: orderBloc.orderItems,
        builder: (_context, snapshot) {
          if(snapshot.hasData){
            gettotalPayable();
          }
          return snapshot.hasData
//              ? orderGrid(snapshot.data)
              ? Container(
              width: size.width * bodyWidthScale,
              padding: EdgeInsets.only(
                top: (size.height * topPaddingScale) / 8,
                left: (size.width * leftPaddingScale) / 4,
                right: (size.width * leftPaddingScale) / 4,
              ),
              // color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Text(
                          UIData.title_order_status,
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
                          heroTag: 'fab',
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
                        UIData.subtitle_order_status,
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
                  Container(
                    margin: const EdgeInsets.fromLTRB(0.5, 0.0, 1.0, 0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        SizedBox(
                          width: 26,
                        ),
                        Container(
                          width: (size.width * scaleWithoutPadding * 0.25) - 2,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              UIData.label_item,
                              textAlign: TextAlign.left,
                              style: textStyleActive,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: (size.width * scaleWithoutPadding * 0.25) - 2,
                        ),
                        Container(
                          width: (size.width * scaleWithoutPadding * 0.125) - 2,
                          child: Text(
                            UIData.label_quantity,
                            textAlign: TextAlign.center,
                            style: textStyleActive,
                          ),
                        ),
                        Container(
                          width: (size.width * scaleWithoutPadding * 0.125) -
                              2.5,
                          child: Text(
                            UIData.label_price,
                            textAlign: TextAlign.center,
                            style: textStyleActive,
                          ),
                        ),
                        Container(
                          width: (size.width * scaleWithoutPadding * 0.125) - 1,
                          child: Text(
                            UIData.label_amount,
                            textAlign: TextAlign.center,
                            style: textStyleActive,
                          ),
                        ),
                        SizedBox(
                          width: ((size.width * scaleWithoutPadding) * 0.125) -
                              26,
                        ),
                      ],
                    ),
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
                        child: orderGrid(snapshot.data),
                      )),
                  SizedBox(
                    height: 5,
                  ),
                  ngoAndTotal(),
                  SizedBox(
                    height: 10,
                  ),
                  bottomButtons(),
                  SizedBox(
                    height: 20,
                  ),
                ],
              )
          )
              : Center(child: CircularProgressIndicator());
        });
  }

  Future<bool> _onBackPressed() async {
    return false;
  }

  BuildContext _context;
  var size;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    _context = context;
    size = MediaQuery
        .of(_context)
        .size;
//     debugPrint(" width 1 -- " + (size.width * bodyWidthScale).toString());
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: CustomAppBar.getAppBar(_context),
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
            bodyData(),
            //            Container(
//                width: size.width * bodyWidthScale,
//                padding: EdgeInsets.only(
//                  top: (size.height * topPaddingScale) / 8,
//                  left: (size.width * leftPaddingScale) / 4,
//                  right: (size.width * leftPaddingScale) / 4,
//                ),
//                // color: Colors.white,
//                child: bodyContent(_context)),
          ],
        )
      ],
    );
  }

//  Widget bodyContent(BuildContext cntxt) {
//    return Column(
//      mainAxisAlignment: MainAxisAlignment.start,
//      children: <Widget>[
//        Row(
//          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//          children: <Widget>[
//            Container(
//              child: Text(
//                UIData.title_order_status,
//                style: TextStyle(
//                    fontFamily: UIData.font_nunito_sans,
//                    fontSize: 29.0,
//                    fontWeight: FontWeight.w600),
//              ),
//            ),
//            Container(
//              padding: EdgeInsets.only(right: 30),
//              height: 40,
//              width: 70,
//              child: FloatingActionButton(
//                heroTag: 'btn5',
//                backgroundColor: Color(0xFF000000),
//                child: GestureDetector(
//                  onTap: () {
//                    Navigator.of(context).pop();
//                  },
//                  child: Stack(
//                    alignment: Alignment.center,
//                    children: <Widget>[
//                      Icon(
//                        const IconData(0xe909, fontFamily: 'icomoon'),
//                        color: Colors.white,
//                      ),
//                    ],
//                  ),
//                ), //Image.asset(name),
//              ),
//            ),
//          ],
//        ),
//        Row(
//          children: <Widget>[
//            Text(
//              UIData.subtitle_order_status,
//              style: TextStyle(
//                  fontFamily: UIData.font_nunito_sans,
//                  fontSize: 17.0,
//                  color: Color(0xFF8B8B8B),
//                  fontWeight: FontWeight.w400,
//                  ),
//            ),
//          ],
//        ),
//        SizedBox(
//          height: 5.0,
//        ),
//        Container(
//          margin: const EdgeInsets.fromLTRB(0.5, 0.0, 1.0, 0.0),
//          child: Row(
//            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//            children: <Widget>[
//              SizedBox(
//                width: 26,
//              ),
//              Container(
//                width: (size.width * scaleWithoutPadding*0.25)-2,
//                child: Padding(
//                  padding: const EdgeInsets.all(4.0),
//                  child: Text(
//                      UIData.label_item,
//                      textAlign: TextAlign.left,
//                      style: textStyleActive ,
//                  ),
//                ),
//              ),
//              SizedBox(
//                width: (size.width * scaleWithoutPadding*0.25)-2,
//              ),
//              Container(
//                width: (size.width * scaleWithoutPadding*0.125)-2,
//                child: Text(
//                  UIData.label_quantity,
//                  textAlign: TextAlign.center,
//                  style: textStyleActive ,
//                ),
//              ),
//              Container(
//                width: (size.width * scaleWithoutPadding*0.125)-2.5,
//                child: Text(
//                  UIData.label_price,
//                  textAlign: TextAlign.center,
//                  style: textStyleActive ,
//                ),
//              ),
//              Container(
//                width: (size.width * scaleWithoutPadding*0.125) -1,
//                child: Text(
//                  UIData.label_amount,
//                  textAlign: TextAlign.center,
//                  style: textStyleActive ,
//                ),
//              ),
//              SizedBox(
//                  width: ((size.width * scaleWithoutPadding)*0.125)-26,
//              ),
//            ],
//          ),
//        ),
//        Divider(
//          color: Colors.grey,
//          height: 4.0,
//        ),
//        SizedBox(
//          height: 10,
//        ),
//        Expanded(
//           child: Scrollbar(
//             child: bodyData(),
//        )),
//        SizedBox(
//          height: 5,
//        ),
//        ngoAndTotal(cntxt),
//        SizedBox(
//          height: 10,
//        ),
//        bottomButtons(cntxt),
//        SizedBox(
//          height: 20,
//        ),
//      ],
//    );
//  }

  Widget ngoAndTotal() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[ngoWidget(), cartTotalWidget()],
    );
  }


  Widget cartTotalWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "CART TOTAL: " + UIData.rupee_sign + "$totalPayable",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
              fontFamily: UIData.font_nunito_sans,
              color: Colors.black),
        ),
        SizedBox(
          width: 8.0,
        ),
        Text(
          "        GST(5%): " + UIData.rupee_sign +
              "${(totalPayable * .05).round()}",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
              fontFamily: UIData.font_nunito_sans,
              color: Colors.black),
        ),
        Text(
          "CART TOTAL: " + UIData.rupee_sign +
              "${(totalPayable + totalPayable * .05).round()}",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w800,
              fontFamily: UIData.font_nunito_sans,
              color: Colors.black),
        ),
      ],
    );
  }

  Widget ngoWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
//        Row(
//          children: <Widget>[
//            UIData.buttonRow(Icons.check_box, Colors.green,
//                UIData.label_donate_to_ngo, Colors.white),
//            SizedBox(
//              width: 8.0,
//            ),
//            Text(
//              UIData.rupee_sign,
//              textAlign: TextAlign.center,
//              style: TextStyle(
//                  fontSize: 16.0,
//                  fontWeight: FontWeight.w800,
//                  fontFamily: UIData.font_nunito_sans,
//                  color: Colors.black),
//            ),
//            SizedBox(
//              width: 8.0,
//            ),
//            ngoAmountController(),
//          ],
//        ),
//        Text(
//          UIData.label_know_more_about_ngo,
//          style: TextStyle(
//              color: Colors.black,
//              fontSize: 16.0,
//              fontStyle: FontStyle.italic,
//              fontFamily: UIData.font_nunito_sans,
//              fontWeight: FontWeight.w700),
//        )
        SizedBox(
          width: 500.0,
        ),
      ],
    );
  }

  double ngoAmount = 0.0;

//  Widget ngoAmountController() {
//    return Container(
//      height: 30,
//      width: 96,
//      padding: EdgeInsets.all(2.0),
//      decoration: BoxDecoration(
//        border: Border.all(color: Colors.black),
//        borderRadius: BorderRadius.circular(16),
//        color: Colors.black,
//      ),
//      child: Row(
//        mainAxisSize: MainAxisSize.min,
//        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//        crossAxisAlignment: CrossAxisAlignment.center,
//        children: <Widget>[
//          Expanded(
//            child: Container(
//              padding: EdgeInsets.all(0),
//              // height: 18,
//              // width: 16,
//              child: FlatButton(
//                child: Icon(
//                  const IconData(0xe904, fontFamily: 'icomoon'),
//                  color: Colors.white,
//                  size: 3,
//                ), //Image.asset(name),
//                shape: CircleBorder(),
//                color: Colors.black,
//                splashColor: Colors.white,
//                disabledColor: Colors.black,
//                padding: EdgeInsets.all(
//                  0.0,
//                ),
//                onPressed: () {
//                  ngoAmountStateChanged = true;
//                  setState(() {
//
//                    ngoAmount >= 10
//                        ? ngoAmount = ngoAmount - 10
//                        : ngoAmount = 0;
//                  });
//                },
//              ),
//            ),
//          ),
//          Expanded(
//            child: Text(
//              ngoAmount.toString(),
//              textAlign: TextAlign.center,
//              style: TextStyle(
//                  fontSize: 10.0,
//                  fontWeight: FontWeight.w800,
//                  fontFamily: UIData.font_nunito_sans,
//                  color: Colors.white),
//            ),
//          ),
//          Expanded(
//            child: Container(
//              padding: EdgeInsets.all(2),
//              height: 18,
//              // width: 16,
//              child: FlatButton(
//                child: Icon(
//                  const IconData(0xe902, fontFamily: 'icomoon'),
//                  color: Colors.white,
//                  size: 18,
//                ), //Image.asset(name),
//                shape: CircleBorder(),
//                color: Colors.black,
//                splashColor: Colors.white,
//                disabledColor: Colors.black,
//                padding: EdgeInsets.all(
//                  0.0,
//                ),
//                onPressed: () {
//                  //Navigator.of(context).pop();
//                    ngoAmountStateChanged = true;
//                  setState(() {
//                    ngoAmount = ngoAmount + 10;
//                  });
//                },
//              ),
//            ),
//          )
//        ],
//      ),
//    );
//  }

  Widget bottomButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        FlatButton(
            color: Colors.black,
            padding: const EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 8.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(MENU_SCREEN);
            },
            child: Text(
              UIData.label_add_more,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontFamily: UIData.font_nunito_sans,
                  fontWeight: FontWeight.w700),
            )),
        FlatButton(
            color: Colors.black,
            padding: const EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 8.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            onPressed: () {
              ngoAmountStateChanged = false;
              Navigator.of(_context).pushNamed(ON_YOUR_TABLE_SCREEN);
            },
            child: Text(
              UIData.label_place_order,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontFamily: UIData.font_nunito_sans,
                  fontWeight: FontWeight.w700),
            )),
        FlatButton(
            color: Colors.deepOrange,
            padding: const EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 8.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            onPressed: () {
              _endSessionButtonPressed();
            },
            child: Text(
              UIData.label_exit,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontFamily: UIData.font_nunito_sans,
                  fontWeight: FontWeight.w700),
            )),
      ],
    );
  }
}
