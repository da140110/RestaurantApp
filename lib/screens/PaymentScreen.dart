import 'dart:async';
import 'package:finesse/api/FinesseApi.dart';
import 'package:finesse/constant/Constant.dart';
import 'package:finesse/model/payment_request.dart';
import 'package:finesse/util/uidata.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:finesse/logic/bloc/order_bloc.dart';
import 'package:finesse/model/food_item_order.dart';

class PaymentScreen extends StatefulWidget {
  final Payment payment;
  PaymentScreen(this.payment);
  @override
  PaymentScreenState createState() => new PaymentScreenState(payment);
}

class PaymentScreenState extends State<PaymentScreen>
    with SingleTickerProviderStateMixin {

  final Payment payment;
  PaymentScreenState(this.payment);
  OrderBloc orderBloc = OrderBloc();


  final double leftWidthScale = .2872; //.557;
  final double bodyWidthScale = .7128;
  final double leftPaddingScale = 0.078125;
  final double topPaddingScale = 0.166;
  final double verticalGapBetweenfields = 12.0;

//  Payment paymentReq = new Payment();

  @override
  void initState() {
    isOrderInitiated = false;
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

  Widget bodyData() {
    var size = MediaQuery.of(context).size;
    return StreamBuilder(
        stream: orderBloc.orderItems,
        builder: (context, snapshot) {
//          currentOrderList = snapshot.data;
          if(snapshot.hasData)
          {
            gettotalPayable();
            payment.paymentAmount = (totalPayable*1.05).toInt();
//            paymentReq.ngoPayment = 0;

          }
          return snapshot.hasData
              ?Column(
            children: <Widget>[
              Container(
                width: size.width * bodyWidthScale,
                padding: EdgeInsets.only(
                  top: (size.height * topPaddingScale)/4,
                  left: size.width * leftPaddingScale/3,
                  right: (size.width * leftPaddingScale) / 4,
                ),
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "PAYMENT SUMMARY",
                      style: TextStyle(
                          fontFamily: UIData.font_nunito_sans,
                          fontSize: 29.0,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Text(
                      "CART TOTAL                                                 : " + UIData.rupee_sign + "$totalPayable",
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
                      "GST(5%)                                                         : " + UIData.rupee_sign + "${(totalPayable*.05).round()}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                          fontFamily: UIData.font_nunito_sans,
                          color: Colors.black),
                    ),
                    Text(
                      "TOTAL AMOUNT TO BE PAID                    : " + UIData.rupee_sign + "${(totalPayable+totalPayable*.05).round()}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w800,
                          fontFamily: UIData.font_nunito_sans,
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
              Container(
                  width: size.width * bodyWidthScale,
                  padding: EdgeInsets.only(
                    top: (size.height * topPaddingScale)/2,
                    left: size.width * leftPaddingScale/3,
                    right: (size.width * leftPaddingScale) / 4,
                  ),
                  // color: Colors.white,
                  child: bodyContent()
              ),

            ],
          )
              : Center(child: CircularProgressIndicator());
        });
  }

  _doneButtonPressed(String paymentMode) {

  //debugPrint("paymentButton Pressed------------------------------------------");

      payment.paymentMode = paymentMode;
//      paymentReq.caffeID = currentCafe.caffeId;
//      paymentReq.tableidtimestamp = currentUser.tableIdTimestamp;
//      debugPrint("total" + totalPayable.toString() );
      api.makePayment(payment).then(
    (response){
      //debugPrint("Reply in make order "+ response.paymentResponse);
    // if(response.paymentResponse.compareTo("success")==0)
     {
       Navigator.of(context).pushNamed(FEEDBACK_SCREEN);
      //  isOrderInitiated = false;
     }

    }
  );
  }

  Future<bool> _onBackPressed() async{
    return false;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    var size = MediaQuery.of(context).size;
    //debugPrint(" height -- " + size.height.toString());
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
//        appBar: CustomAppBar.getAppBar(context),
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                    width: size.width * leftWidthScale,
                    height: size.height,
//                  child: Opacity(
//                    opacity: 1,
                      child: new Image.asset(
                        UIData.image_left_background,
                        fit: BoxFit.cover,
//                      color: Colors.black54,
//                        colorBlendMode: BlendMode.darken,
//                    ),
                    )),
                bodyData(),
//                Column(
//                  children: <Widget>[
//                    Container(
//                      width: size.width * bodyWidthScale,
//                      padding: EdgeInsets.only(
//                        top: (size.height * topPaddingScale)/4,
//                        left: size.width * leftPaddingScale/3,
//                        right: (size.width * leftPaddingScale) / 4,
//                      ),
//                      child: bodyData(),
//                    ),
//                    Container(
//                        width: size.width * bodyWidthScale,
//                        padding: EdgeInsets.only(
//                          top: (size.height * topPaddingScale)/2,
//                          left: size.width * leftPaddingScale/3,
//                          right: (size.width * leftPaddingScale) / 4,
//                        ),
//                        // color: Colors.white,
//                        child: bodyContent()
//                    ),
//
//                  ],
//                ),
              ],
            )
          ],
        ),
      ),
    );
  }
  
  Widget bodyContent() {
    return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 0.1),
                          child: Text(
                            UIData.title_payment,
                            style: TextStyle(
                                fontFamily: UIData.font_nunito_sans,
                                fontSize: 29.0,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          UIData.subtitle_payment,
                          style: TextStyle(
                              fontFamily: UIData.font_nunito_sans,
                              fontSize: 17.0,
                              color: Color.fromRGBO(139, 139, 139, 1.0),
                              // fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 80,
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(12.0, 0.0, 96.0, 0.0),
                      alignment: Alignment.topLeft,
                      child: ConstrainedBox(
                        constraints:
                            const BoxConstraints(minWidth: double.infinity),
                        child: RaisedButton(
                          padding: EdgeInsets.fromLTRB(0.0, 10.0, 256.0, 10.0),
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                          ),
                          child: Text(
                            UIData.label_credit_debit,
                            textAlign: TextAlign.start,
                            textDirection: TextDirection.ltr,
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: UIData.font_nunito_sans,
                                fontWeight: FontWeight.w700,
                                fontSize: 14.0),
                          ),
                          color: Colors.white,
                          splashColor: Colors.white,
                          elevation: 4.0,
                          onPressed: (){
                            _doneButtonPressed("Card");
                          }
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(12.0, 0.0, 96.0, 0.0),
                      alignment: Alignment.topLeft,
                      child: ConstrainedBox(
                        constraints:
                            const BoxConstraints(minWidth: double.infinity),
                        child: RaisedButton(
                          padding: EdgeInsets.fromLTRB(0.0, 10.0, 256.0, 10.0),
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                          ),
                          child: Text(
                            UIData.label_cash,
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.ltr,
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: UIData.font_nunito_sans,
                                fontWeight: FontWeight.w700,
                                fontSize: 14.0),
                          ),
                          color: Colors.white,
                          splashColor: Colors.white,
                          elevation: 4.0,
                          onPressed: (){
                            _doneButtonPressed("Cash");
                          }
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(12.0, 0.0, 96.0, 0.0),
                      alignment: Alignment.topLeft,
                      child: ConstrainedBox(
                        constraints:
                        const BoxConstraints(minWidth: double.infinity),
                        child: RaisedButton(
                            padding: EdgeInsets.fromLTRB(0.0, 10.0, 256.0, 10.0),
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                            ),
                            child: Text(
                              UIData.label_wallet,
                              textAlign: TextAlign.center,
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: UIData.font_nunito_sans,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14.0),
                            ),
                            color: Colors.white,
                            splashColor: Colors.white,
                            elevation: 4.0,
                            onPressed: (){
                              _doneButtonPressed("Wallet");
                            }
                        ),
                      ),
                    ),
                  ],
                );
  }
}


