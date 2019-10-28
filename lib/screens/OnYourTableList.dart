import 'package:finesse/constant/Constant.dart';
import 'package:finesse/model/food_item_order.dart';
import 'package:finesse/model/order_detail.dart';
import 'package:finesse/util/uidata.dart';
import 'package:flutter/material.dart';

class OnYourTableList extends StatefulWidget {
  final FoodItemOrder item;
  final Order order;

  OnYourTableList({@required this.item, this.order});

  @override
  OnYourTableListState createState() => new OnYourTableListState(item:this.item,order:this.order);
}

class OnYourTableListState extends State<OnYourTableList> {
  FoodItemOrder item;
  final Order order;
  int itemQuantity = 0;

  final double bottomBarScale = .087239;
  final double scaleWithoutPadding = .6737375;

  final veg = 'veg';
  final nonveg = 'non-veg';

  OnYourTableListState({@required this.item, this.order});

  Color getColor() {
    if (item.foodType == veg) {
      return Colors.green;
    } else if(item.foodType == nonveg){
      return Colors.red;
    }
    else{
      return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ////debugPrint("item isAvailable " + item.isAvailable.toString());
    return InkWell(
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //       // builder: (context) => GridItemDetails(this.item),
          //       ),
          // );
        },
        child: Card(
          margin: const EdgeInsets.fromLTRB(0.5, 8.0, 1.0, 8.0),
          elevation: 0.0,
          clipBehavior: Clip.antiAlias,
          color: Colors.grey[50],
          shape: Border(bottom: BorderSide(color: Colors.black)),
          child: Container(
            //item name and status
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: 26,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 4.0, right: 2.0),
                    child: Icon(
                      const IconData(0xe900, fontFamily: 'icomoon'),
                      color: getColor(),
                      size: 20,
                    ),
                  ),
                ),
                Container(
                  width: (size.width * scaleWithoutPadding*0.5)-4,
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Text(
                        item.foodItem,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: UIData.font_nunito_sans,
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        )),
                  ),
                ),
//                Container(
//                  width: (size.width * scaleWithoutPadding*0.25)-2,
//                  child: Padding(
//                    padding: const EdgeInsets.fromLTRB(
//                        0.0,
//                        0.0,
//                        2.0,
//                        0.0
//                    ),
//                    child: Text(
//                        order.status,
//                        textAlign: TextAlign.center,
//                        style: TextStyle(
//                          fontFamily: UIData.font_nunito_sans,
//                          fontSize: 13,
//                          color: _getBorderColor(),
//                          fontWeight: FontWeight.w700,
//                        )),
//                  ),
//                ),
                _quantityController(context),
                Container(
                  width: (size.width * scaleWithoutPadding*0.125)-2.5,
                  child: Text(
                      (item.unitPrice + item.addonPrice).toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: UIData.font_nunito_sans,
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      )),
                ),
                Container(
                  width: (size.width * scaleWithoutPadding*0.125)-1,
                  child: Text(
                      UIData.rupee_sign + " "+ _getAmount(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: UIData.font_nunito_sans,
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      )),
                ),
                getRemoveOrAddButton(context),
              ],
            ),
          ),
////                Row(
////                  mainAxisAlignment: MainAxisAlignment.end,
////                  children: <Widget>[
////                    FlatButton(
////                      child: Icon(
////                        const IconData(0xe907, fontFamily: 'icomoon'),
////                        color: Colors.white,
////                        size: 16,
////                      ), //Image.asset(name),
////                      shape: CircleBorder(),
////                      color: Colors.white,
////                      splashColor: Colors.white,
////                      disabledColor: Colors.black,
////                      onPressed: () {
////                        // Navigator.of(context).pop();
////                      },
////                    ),
////                  ],
////                )
//              ],
//            ),
//          ),
        ));
  }

  Widget _quantityController(context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: (size.width * scaleWithoutPadding*0.125)-2,
           child: Container(
             height: 25,
             width: 75,
             decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(12.5),
             color: Colors.black54,
           ),
            child: Row(
             mainAxisSize: MainAxisSize.min,
             mainAxisAlignment:
             MainAxisAlignment.spaceEvenly,
             crossAxisAlignment:
             CrossAxisAlignment.center,
             children: <Widget>[
             Container(
               child: Container(
                 height: 25,
                 width: 25,
                 child: RaisedButton(
                   child: Icon(
                     const IconData(0xe904, fontFamily: 'icomoon'),
                     color: Colors.white,
                     size: 16,
                   ),
                  //Image.asset(name),
                   shape: CircleBorder(),
                   color: Colors.black,
                   splashColor: Colors.white,
                   disabledColor: Colors.black,
                   padding: EdgeInsets.only(right: 0),
                   elevation: 2.0,
                   onPressed: () {
                     itemQuantity--;
                     changeItemQuantityInOrderList();
                   },
                 ),
               ),
             ),
             Expanded(
              // ------  item quantity
               child: Text(
                 item.quantity.toString(), //item.orderedAmount,
                 textAlign: TextAlign.center,
                 style: TextStyle(
                     fontSize: 10.0,
                     fontWeight: FontWeight.w800,
                     fontFamily:
                     UIData.font_nunito_sans,
                     color: Colors.white),
               ),
             ),
             // ----------------------- add quantity
             Container(
               child: Container(
                 height: 25,
                 width: 25,
                 child: RaisedButton(
                   child: Icon(
                     const IconData(0xe902, fontFamily: 'icomoon'),
                     color: Colors.white,
                     size: 16,
                   ),
                   //Image.asset(name),
                   shape: CircleBorder(),
                   color: Colors.black,
                   splashColor: Colors.white,
                   disabledColor: Colors.black,
                   elevation: 2.0,
                   padding: EdgeInsets.only(right: 0.0),
                   onPressed: () {
                     itemQuantity++;
                     changeItemQuantityInOrderList();
                   },
                 ),
               ),
             ),
           ],
         ),
       ),
     );
   }

    void changeItemQuantityInOrderList() {
    
    //debugPrint("item quantity changed for " + item.foodItem);
      int newQnty = item.quantity + itemQuantity;
      item.quantity = newQnty < 1? 1: newQnty;

    if (currentOrderList.isNotEmpty) {
      List<FoodItemOrder> itemList = currentOrderList.last.items;
      for (var i = 0; i < itemList.length; i++) {
        FoodItemOrder foodItem = itemList[i];
        if ( foodItem.foodId == item.foodId ) {
          foodItem.quantity = item.quantity;
        }
      }
    setState(() {
      itemQuantity = 0;
    });

    }

    }

  String _getAmount() {
    //  return (item.quantity * item.item.price).toString();
    return (( item.addonPrice + item.unitPrice) * item.quantity).toString();
  }
  // show customize dialog

  Widget getRemoveOrAddButton(BuildContext context){
    Size size = MediaQuery.of(context).size;
      return SizedBox(
        width: (size.width * scaleWithoutPadding*0.125)-26,
      );
  }

  void cancelItemDialog(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Dialog customDialog = Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.0),
        // side: BorderSide(color: Colors.black),
      ), //this right here
      child: Container(
        width: size.width / 3,
        // width: size.width / 2,
        padding: EdgeInsets.only(
          left: 48.0,
        ),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.0),
          color: Color.fromRGBO(0, 0, 0, .85),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                bottom: 8.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Are you sure you want to cancel $item.(item.title) ?",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: UIData.font_nunito_sans,
                        fontSize: 19,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 48,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                FlatButton(
                    color: Colors.black,
                    padding: const EdgeInsets.all(8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      // issueRaiseDialogConfirmation(context);
                    },
                    child: Text(
                      UIData.label_done,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 13.0,
                          fontFamily: UIData.font_nunito_sans,
                          fontWeight: FontWeight.w700),
                    )),
                FlatButton(
                    color: Colors.black,
                    padding: const EdgeInsets.all(8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      // issueRaiseDialogConfirmation(context);
                    },
                    child: Text(
                      UIData.label_done,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 13.0,
                          fontFamily: UIData.font_nunito_sans,
                          fontWeight: FontWeight.w700),
                    )),
              ],
            ),
            SizedBox(
              height: 48,
            )
          ],
        ),
      ),
    );

    showDialog(
        context: context, builder: (BuildContext context) => customDialog);
  }
}