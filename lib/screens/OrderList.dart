import 'package:finesse/constant/Constant.dart';
import 'package:finesse/model/food_item_order.dart';
import 'package:finesse/model/order_detail.dart';
import 'package:finesse/util/uidata.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderList extends StatelessWidget {
  final FoodItemOrder item;
  final Order order;

  final double bottomBarScale = .087239;
  final double scaleWithoutPadding = .6737375;

  final veg = 'veg';
  final nonveg = 'non-veg';

  const OrderList({@required this.item, this.order});

  Color _getBorderColor() {
    Color borderColor;

    if (order.status.compareTo(ORDER_STATUS[0]) == 0)
      borderColor = Color.fromRGBO(8, 155, 25, 1);
    else if (order.status.compareTo(ORDER_STATUS[1]) == 0)
      borderColor = Colors.grey;
    else if (order.status.compareTo(ORDER_STATUS[2]) == 0)
      borderColor = Color.fromRGBO(247, 171, 27, 1);

    return borderColor;
  }

  Color getColor() {
    if (item.foodType == veg) {
      return Colors.green;
    } else if (item.foodType == nonveg) {
      return Colors.red;
    } else {
      return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ////debugPrint("item isAvailable " + item.isAvailable.toString());
    return InkWell(
        onTap: (){},
        child: Card(
          margin: const EdgeInsets.fromLTRB(0.5, 8.0, 1.0, 8.0),
          elevation: 0.0,
          clipBehavior: Clip.antiAlias,
          color: Colors.grey[50],
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              side: BorderSide(
                color: _getBorderColor(),
              )),
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
                  width: (size.width * scaleWithoutPadding * 0.25) - 2,
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Text(item.foodItem,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: UIData.font_nunito_sans,
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        )),
                  ),
                ),
                Container(
                  width: (size.width * scaleWithoutPadding * 0.25) - 2,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 0.0, 2.0, 0.0),
                    child: Text(order.status,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: UIData.font_nunito_sans,
                          fontSize: 13,
                          color: _getBorderColor(),
                          fontWeight: FontWeight.w700,
                        )),
                  ),
                ),
                _quantityController(context),
                Container(
                  width: (size.width * scaleWithoutPadding * 0.125) - 2.5,
                  child: Text(_getAmount(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: UIData.font_nunito_sans,
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      )),
                ),
                Container(
                  width: (size.width * scaleWithoutPadding * 0.125) - 1,
                  child: Text(UIData.rupee_sign + " " + ((item.unitPrice + item.addonPrice) * item.quantity).toString(),
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
        ));
  }

  Widget _quantityController(context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        width: (size.width * scaleWithoutPadding * 0.125) - 2,
        child: Text(item.quantity.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: UIData.font_nunito_sans,
              fontSize: 15,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            )));
  }

  Widget getRemoveOrAddButton(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    if (order.is_placed) {
      return Container(
        padding: EdgeInsets.only(top: 6.0, bottom: 8.0),
        width: (size.width * scaleWithoutPadding * 0.125) - 26,
        child: FloatingActionButton(
          heroTag: null,
          backgroundColor: Color(0xFF000000),
          child: GestureDetector(
            onTap: () {
              addItemToOrder(context);
            },
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Icon(
                  const IconData(0xe902, fontFamily: 'icomoon'),
                  color: Colors.white,
                  size: 18,
                ),
              ],
            ),
          ),
        ),
      );
    } else if (isOrderInitiated &&
        order.order_identifier.compareTo(CURRENT_ORDER_IDENTIFIER) == 0) {
      return Container(
        padding: EdgeInsets.only(top: 6.0, bottom: 8.0),
        width: (size.width * scaleWithoutPadding * 0.125) - 26,
        child: FloatingActionButton(
          heroTag: null,
          backgroundColor: Color(0xFF000000),
          child: GestureDetector(
            onTap: () {
              cancelItemDialog(context);
            },
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Icon(
                  const IconData(0xe907, fontFamily: 'icomoon'),
                  color: Colors.white,
                  size: 18,
                ),
              ],
            ),
          ),
        ),
      );
    } else
      return SizedBox(
        width: (size.width * scaleWithoutPadding * 0.125) - 26,
      );
  }

  String _getAmount() {
    //  return (item.quantity * item.item.price).toString();
    item.addonPrice = 0;
    for (int i=0;i<item.addon.length;i++){
      item.addonPrice = item.addonPrice + item.addon[i].addonPrice;
    }
    return (item.unitPrice + item.addonPrice).toString();
  }

  void addItemToOrder(BuildContext context) {

    bool itemUpdated = false;

    Order order;

    if (isOrderInitiated == true) {
      order = currentOrderList.last;
      List<FoodItemOrder> itemList = order.items;
      for (var i = 0; i < itemList.length; i++) {
        bool sameaddon = true;
        FoodItemOrder foodItem = itemList[i];
        if (foodItem.foodId.compareTo(item.foodId) == 0) {
          for(int j =0; j < addOn.length ; j++){
            if (foodItem.addon[j].addonName != item.addon[j].addonName){
              sameaddon = false;
              break;
            }
          }
          if (sameaddon){
            debugPrint(foodItem.foodId);
            foodItem.quantity = foodItem.quantity + 1;
            itemUpdated = true;
          }
        }
      }
    }

    if (isOrderInitiated == false) {
      isOrderInitiated = true;
      order = Order();
      List<FoodItemOrder> its = [];
      order.order_identifier = "Order000" + orderIdentifierNumber.toString();
      CURRENT_ORDER_IDENTIFIER = order.order_identifier;
      orderIdentifierNumber++;
      order.items = its;
      currentOrderList.add(order);
    }

    if (itemUpdated == false) {
      order.items.add(item);
      order.status = ORDER_STATUS[1];
      order.is_placed = false;
      order.order_time = new DateFormat('dd/MM/yyyy hh:mm:ss')
          .format(DateTime.parse(DateTime.now().toString()));
    }

//-----------

    Navigator.of(context).pushNamed(ORDER_SCREEN);
  }

  // show customize dialog

  void cancelItemDialog(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Dialog customDialog = Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.0),
        // side: BorderSide(color: Colors.black),
      ), //this right here
      child: Container(
        width: size.width / 3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.0),
          color: Color.fromRGBO(0, 0, 0, .85),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                top: 12.0,
                bottom: 12.0,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Are you sure you want to cancel \n ${item.foodItem} ?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: UIData.font_nunito_sans,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                FlatButton(
                    color: Colors.black,
                    padding: const EdgeInsets.all(8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    onPressed: () {
                      List<FoodItemOrder> orderedItems =
                          currentOrderList.last.items;
                      int removeIndex;
                      for (var i = 0; i < orderedItems.length; i++) {
                        if (orderedItems[i].foodId.compareTo(item.foodId) ==
                            0) {
                          removeIndex = i;
                        }
                      }
                      //  debugPrint("current order item size "+ currentOrderList.last.items.length.toString());
                      currentOrderList.last.items.removeAt(removeIndex);
                      //  debugPrint("current order item size after reomve"+ currentOrderList.last.items.length.toString());

                      Navigator.of(context).pushNamed(ORDER_SCREEN);

                      // Navigator.of(context).pop();
                      // issueRaiseDialogConfirmation(context);
                    },
                    child: Text(
                      UIData.label_yes,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.0,
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
                      UIData.label_no,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.0,
                          fontFamily: UIData.font_nunito_sans,
                          fontWeight: FontWeight.w700),
                    )),
              ],
            ),
            SizedBox(
              height: 24,
            ),
          ],
        ),
      ),
    );

    showDialog(
        context: context, builder: (BuildContext context) => customDialog);
  }

  // repeat order dialog

  void reepatOrderDialog(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Dialog customDialog = Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.0),
        // side: BorderSide(color: Colors.black),
      ), //this right here
      child: Container(
        width: size.width / 3,
        // width: size.width / 2,
        // padding: EdgeInsets.all(
        //    48.0,
        // ),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.0),
          color: Color.fromRGBO(0, 0, 0, .85),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                top: 12.0,
                bottom: 12.0,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    UIData.label_repeat_order,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: UIData.font_nunito_sans,
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  item.foodItem,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: UIData.font_nunito_sans,
                      fontSize: 12,
                      fontWeight: FontWeight.w700),
                ),
                RepeaDialogContent(),
                Text(
                  item.unitPrice.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: UIData.font_nunito_sans,
                      fontSize: 12,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
            SizedBox(
              height: 24,
            ),
          ],
        ),
      ),
    );

    showDialog(
        context: context, builder: (BuildContext context) => customDialog);
  }

// repeat order dialog content

}

//------------------------------------- repeat order dialog content

class RepeaDialogContent extends StatefulWidget {
  RepeaDialogContent({
    Key key,
    this.options,
    this.customOptions,
  }) : super(key: key);

  final List<String> options;
  final List<String> customOptions;

  @override
  _RepeaDialogContentState createState() => new _RepeaDialogContentState();
}

class _RepeaDialogContentState extends State<RepeaDialogContent> {
  TextEditingController additionalcommentController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  _getContent() {
    if (widget.options.length == 0) {
      return new Container();
    }

    return Column(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Container(
            height: 30,
            // width: 48,
            padding: EdgeInsets.all(2.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(16),
              color: Colors.black,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(0),
                    // height: 18,
                    // width: 16,
                    child: FlatButton(
                      child: Icon(
                        const IconData(0xe904, fontFamily: 'icomoon'),
                        color: Colors.white,
                        size: 3,
                      ),
                      //Image.asset(name),
                      shape: CircleBorder(),
                      color: Colors.black,
                      splashColor: Colors.white,
                      disabledColor: Colors.black,
                      padding: EdgeInsets.all(
                        0.0,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    "0", //item.orderedAmount,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 10.0,
                        fontWeight: FontWeight.w800,
                        fontFamily: UIData.font_nunito_sans,
                        color: Colors.white),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(2),
                    height: 18,
                    // width: 16,
                    child: FlatButton(
                      child: Icon(
                        const IconData(0xe902, fontFamily: 'icomoon'),
                        color: Colors.white,
                        size: 18,
                      ),
                      //Image.asset(name),
                      shape: CircleBorder(),
                      color: Colors.black,
                      splashColor: Colors.white,
                      disabledColor: Colors.black,
                      padding: EdgeInsets.all(
                        0.0,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _getContent();
  }
}
