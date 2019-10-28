import 'dart:async';
import 'dart:convert';

import 'package:finesse/constant/Constant.dart';
import 'package:finesse/model/addon.dart';
import 'package:finesse/model/addon_order.dart';
import 'package:finesse/model/addonarr.dart';
import 'package:finesse/model/food_item.dart';
import 'package:finesse/model/food_item_order.dart';
import 'package:finesse/model/order_detail.dart';
import 'package:finesse/util/text_styles.dart';
import 'package:finesse/util/uidata.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FoodItemList extends StatefulWidget {
  // RegisterPage(this.transferDetails);
  final FoodItem item;

  FoodItemList({@required this.item});

  @override
  FoodItemListState createState() => new FoodItemListState(item: this.item);
}

class FoodItemListState extends State<FoodItemList> {
  final FoodItem item;

  BuildContext _context;

  FoodItemListState({@required this.item});

  final veg = 'veg';
  final nonveg = 'non-veg';

  int itemQuantity = 1;

  static List<String> options = [];
  bool onChangeCustomeOption = false;
  List<AddonArr> addOnTemp = [];
  List<int> selectedOptionIndex = [];

  @override
  void initState() {
    super.initState();
  }

  void addCustomizationValues() {
    options.clear();
    item.addonList.forEach((addon) {
      options.add(addon.name);
    });
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
  void dispose() {
    super.dispose();
  }

  void showSnackBar1() {
    Scaffold.of(_context).hideCurrentSnackBar();
    Scaffold.of(_context).showSnackBar(SnackBar(
      // scaffoldKey.currentState.showSnackBar(SnackBar(
      backgroundColor: Colors.green,
      duration: const Duration(seconds: 1),
      content: Text(
        "${item.foodName} has been added to the cart",
        style: TextStyle(
            fontFamily: UIData.font_nunito_sans,
            fontSize: 31.0,
            fontWeight: FontWeight.w300),
      ),
    ));
  }

  void showSnackBar2() {
    Scaffold.of(_context).hideCurrentSnackBar();
    Scaffold.of(_context).showSnackBar(SnackBar(
      // scaffoldKey.currentState.showSnackBar(SnackBar(
      backgroundColor: Colors.red,
      duration: const Duration(seconds: 1),
      content: Text(
        "Please customise first!!",
        style: TextStyle(
            fontFamily: UIData.font_nunito_sans,
            fontSize: 31.0,
            fontWeight: FontWeight.w300),
      ),
    ));
  }

  void showSnackBar3() {
    Scaffold.of(_context).hideCurrentSnackBar();
    Scaffold.of(_context).showSnackBar(SnackBar(
      // scaffoldKey.currentState.showSnackBar(SnackBar(
      backgroundColor: Colors.red,
      duration: const Duration(seconds: 1),
      content: Text(
        "Please select any option of your choice!!",
        style: TextStyle(
            fontFamily: UIData.font_nunito_sans,
            fontSize: 31.0,
            fontWeight: FontWeight.w300),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    addCustomizationValues();
    _context = context;
    ////debugPrint("item isAvailable " + item.isAvailable.toString());
    return InkWell(
//      onTap: () {
//      },
      child: Card(
        margin: const EdgeInsets.fromLTRB(4.0, 8.0, 4.0, 8.0),
        elevation: 0.0,
//        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // ----------------------------------------left box image
                Container(
                  height: 140,
                  width: 140,
                  // color: Colors.black,
                  child: Padding(
                    padding: const EdgeInsets.all(0.01),
                    child: Image.network(
                      item.foodImage,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                // ---------------------------------------------- right detail part
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // -------------------------title---------------------------
                        Container(
                          height: 20,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Icon(
                                  const IconData(0xe900, fontFamily: 'icomoon'),
                                  color: getColor(),
                                  size: 20,
                                ),
                                Text(
                                  item.foodName.toUpperCase(),
                                  textAlign: TextAlign.right,
                                  style: TextStyles.FOOD_ITEMS_TITLE_TEXT_STYLE,
                                )
                              ],
                            ),
                          ),
                        ),
                        // -------------------------subtitle---------------------------
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  item.foodDesc,
                                  maxLines: 5,
                                  textAlign: TextAlign.right,
                                  // textDirection: TextDirection.ltr,
                                  style: TextStyles.FOOD_ITEMS_TEXT_STYLE,
                                ),
                              )
                            ],
                          ),
                        ),
                        // price , order size ---------------------------------------------------
                        Container(
                          height: 40,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 2.0,
                                      left: 4.0,
                                      top: 2.0,
                                      bottom: 2.0),
                                  child: Text(
                                    " ₹ ${item.price}",
                                    textAlign: TextAlign.left,
                                    style: TextStyles.FOOD_ITEMS_TEXT_STYLE,
                                  ),
                                ),
                              ),
                              // --------------------------------------customize------------------------------
                              SizedBox(
                                width: 5,
                              ),
                              Visibility(
                                visible: !(options.isEmpty),
//                                child: Expanded(
//                                  flex: 3,
                                child: Container(
                                  height: 25,
                                  width: 75,
                                  padding: EdgeInsets.only(right: 0.0),
                                  child: Text(
                                    UIData.label_customize,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: UIData.font_nunito_sans,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 11),
                                  ),
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
//                              ----------- add reduce item -0+   ------------------------------------------------
                              Container(
                                child: Container(
                                  height: 30,
                                  width: 80,
//                                  padding: EdgeInsets.only(right: 3.0, left: 3.0),
                                  decoration: BoxDecoration(
//                                    border: Border.all(color: Colors.black54),
                                    borderRadius: BorderRadius.circular(15),
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
                                          height: 30,
                                          width: 30,
                                          child: RaisedButton(
//                                      materialTapTargetSize:
//                                          MaterialTapTargetSize.shrinkWrap,
                                            child: Icon(
                                              const IconData(0xe904,
                                                  fontFamily: 'icomoon'),
                                              color: Colors.white,
                                              size: 17,
                                            ),
                                            //Image.asset(name),
                                            shape: CircleBorder(),
                                            color: Colors.black,
                                            splashColor: Colors.white,
                                            disabledColor: Colors.black,
                                            padding: EdgeInsets.only(right: 0),
                                            elevation: 2.0,
                                            onPressed: () {
                                              setState(() {
                                                if (itemQuantity > 0)
                                                  itemQuantity--;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        // ------  item quantity
                                        child: Text(
                                          itemQuantity.toString(),
                                          //item.orderedAmount,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 10.0,
                                              fontWeight: FontWeight.w800,
                                              fontFamily:
                                                  UIData.font_nunito_sans,
                                              color: Colors.white),
                                        ),
                                      ),
                                      // ------------------------ add quantity
                                      Container(
                                        child: Container(
                                          height: 30,
                                          width: 30,
                                          child: RaisedButton(
                                            child: Icon(
                                              const IconData(0xe902,
                                                  fontFamily: 'icomoon'),
                                              color: Colors.white,
                                              size: 17,
                                            ),
                                            shape: CircleBorder(),
                                            color: Colors.black,
                                            splashColor: Colors.white,
                                            disabledColor: Colors.black,
                                            elevation: 2.0,
                                            padding:
                                                EdgeInsets.only(right: 0.0),
                                            onPressed: () {
                                              setState(() {
                                                itemQuantity++;
                                              });
                                            },
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              // ------------------------add to cart------
                              Container(
                                child: Container(
                                  height: 30,
                                  padding:
                                      EdgeInsets.only(right: 2.0, left: 8.0),
                                  width: 40,
                                  child: RaisedButton(
//                                      materialTapTargetSize:
//                                          MaterialTapTargetSize.shrinkWrap,
                                    child: Icon(
                                      const IconData(0xe908,
                                          fontFamily: 'icomoon'),
                                      color: item.isAvail
                                          ? Colors.white
                                          : Colors.grey,
                                      size: 18,
                                    ),
                                    shape: CircleBorder(),
                                    color: Colors.black,
                                    splashColor: Colors.white,
                                    disabledColor: Colors.black,
                                    padding: EdgeInsets.only(right: 0),
                                    elevation: 2.0,
                                    onPressed: () {
                                      // Navigator.of(context).pop();
                                      if (item.isAvail) {
                                        if (item.addonList.isNotEmpty) {
                                          customizeOptionDialog(context);
                                        } else {
                                          addOn.clear();
                                          addItemToOrderList();
                                        }
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            Visibility(
              visible: !item.isAvail,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: 300 / 105,
                    child: Image.asset(
                      UIData.image_unavailable,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
//            Visibility(
//              visible: !item.isAvail,
//              child: Row(
//                children: <Widget>[
//                  Padding(
//                    padding: const EdgeInsets.all(0.0),
//                    child: Image.asset(
//                      UIData.image_unavailable,
//                      fit: BoxFit.cover,
//                    ),
//                  ),
//                ],
//              ),
//            ),
          ],
        ),
      ),
    );
  }

  // add food to currentorder

  void addItemToOrderList() {
    bool itemUpdated = false;
    Order order;

    if (currentOrderList.isNotEmpty && isOrderInitiated == true) {
      debugPrint("currentOrderList.isNotEmpty");
      order = currentOrderList.last;
      List<FoodItemOrder> itemList = order.items;
      for (var i = 0; i < itemList.length; i++) {
        bool sameaddon = true;
        FoodItemOrder foodItem = itemList[i];
        if (foodItem.foodId.compareTo(item.foodId) == 0) {
          for (int j = 0; j < addOn.length; j++) {
            if (foodItem.addon[j].addonName != addOn[j].addonName) {
              sameaddon = false;
              break;
            }
          }
          if (sameaddon) {
            debugPrint(foodItem.foodId);
            foodItem.quantity = foodItem.quantity + itemQuantity;
            itemUpdated = true;
          }
        }
      }
    }

    if (isOrderInitiated == false || currentOrderList.isEmpty) {
      debugPrint("hreee:isOrderInitiated==false");
      isOrderInitiated = true;
      //currentOrderList = [];
      order = Order();
      List<FoodItemOrder> its = [];
      order.order_identifier = "Order000" + orderIdentifierNumber.toString();
      CURRENT_ORDER_IDENTIFIER = order.order_identifier;
      orderIdentifierNumber++;
      order.items = its;
      currentOrderList.add(order);
    }

    if (itemUpdated == false) {
      FoodItemOrder foodItemOrder = FoodItemOrder();
      foodItemOrder.foodHashTag = item.hashTag;
      foodItemOrder.foodType = item.foodType;
      foodItemOrder.foodCategory = currentCategory.title;
      foodItemOrder.quantity = itemQuantity;
      foodItemOrder.addon = [];
      for (int i = 0; i < addOn.length; i++) {
        foodItemOrder.addon.add(addOn[i]);
      }
      foodItemOrder.foodId = item.foodId;
      foodItemOrder.unitPrice = double.parse(item.price);
      itemAddOnPrice = 0;
      for (int i = 0; i < foodItemOrder.addon.length; i++) {
        itemAddOnPrice = itemAddOnPrice + foodItemOrder.addon[i].addonPrice;
      }
      foodItemOrder.addonPrice = itemAddOnPrice;
      foodItemOrder.totalBill =
          (foodItemOrder.unitPrice + itemAddOnPrice) * foodItemOrder.quantity;
      foodItemOrder.sgst = (foodItemOrder.totalBill * .025).toInt();
      foodItemOrder.cgst = (foodItemOrder.totalBill * .025).toInt();
      itemAddOnName = " ";
      itemAddOnPrice = 0;

      foodItemOrder.foodItem = item.foodName;

      order.items.add(foodItemOrder);
//      order.quantity = itemQuantity;
      order.status = ORDER_STATUS[1];
      order.is_placed = false;
      order.order_time = new DateFormat('dd/MM/yyyy hh:mm:ss')
          .format(DateTime.parse(DateTime.now().toString()));
    }
    showSnackBar1();
  }

  Widget customizeOptionDialog(BuildContext context) {
    addOn.clear();
    Size size = MediaQuery.of(context).size;
    int _addonArryIndex = 0;
    int _addonIndex = 0;
    int _optionIndex = 0;
    if (!onChangeCustomeOption) {
      item.addonList.forEach((_addon) {
        List<Addon> _templistaddonarr = [];
        _addon.addonarr.forEach((_addonarr) {
          _templistaddonarr.add(new Addon(
              index: _addonIndex,
              addonName: _addonarr.addonName,
              addonPrice: _addonarr.addonPrice,
              isCheck: false));
          _addonIndex = _addonIndex + 1;
        });
        addOnTemp.add(new AddonArr(
            index: _optionIndex,
            name: _addon.name,
            addonarr: _templistaddonarr,
            compulsory: _addon.compulsory,
            select: _addon.select));
        if (_addon.select == 'single') {
          selectedOptionIndex.add(_optionIndex);
          _optionIndex = _optionIndex + 1;
        }
      });
    }
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.0),
                side: BorderSide(
                    color: Colors.black, width: 2.0, style: BorderStyle.solid),
              ), //this right here
              child: Container(
                width: size.width / 3,
                // width: size.width / 2,
                padding: EdgeInsets.only(
                  left: 24.0,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24.0),
                  color: Colors.black87,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        FlatButton(
                          child: Icon(
                            const IconData(0xe907, fontFamily: 'icomoon'),
                            color: Colors.white,
                            size: 16,
                          ),
                          //Image.asset(name),
                          shape: CircleBorder(),
                          color: Colors.black,
                          splashColor: Colors.white,
                          disabledColor: Colors.black,
                          onPressed: () {
                            addOn.clear();
                            addOnTemp.clear();
                            onChangeCustomeOption = false;
                            selectedOptionIndex.clear();
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: 8.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Customise ${item.foodName}",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: UIData.font_nunito_sans,
                                fontSize: 25,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: size.height - 300.0,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: addOnTemp.length,
                        itemBuilder: (context, indexaddOnTemp) {
                          AddonArr _addonarr = addOnTemp[indexaddOnTemp];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(
                                  bottom: 8.0,
                                  top: 8.0,
                                ),
                                child: Text(
                                  _addonarr.name,
                                  maxLines: 1,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: UIData.font_nunito_sans,
                                      fontStyle: FontStyle.italic,
                                      fontSize: 15),
                                ),
                              ),
                              Column(
                                  children: _addonarr.select == 'single'
                                      ? new List<RadioListTile<int>>.generate(
                                          _addonarr.addonarr.length,
                                          (int indexaddonarr) {
                                          return new RadioListTile<int>(
                                            activeColor: Colors.green,
                                            value: _addonarr
                                                .addonarr[indexaddonarr].index,
                                            groupValue: selectedOptionIndex[
                                                _addonarr.index],
                                            title: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                new Text(
                                                  _addonarr
                                                      .addonarr[indexaddonarr]
                                                      .addonName,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: UIData
                                                          .font_nunito_sans),
                                                ),
                                                new Text(
                                                  UIData.rupee_sign +
                                                      " " +
                                                      _addonarr
                                                          .addonarr[
                                                              indexaddonarr]
                                                          .addonPrice
                                                          .toString(),
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: UIData
                                                          .font_nunito_sans),
                                                ),
                                              ],
                                            ),
                                            onChanged: (int value) {
                                              int _addonindex = 0;
                                              addOnTemp[indexaddOnTemp]
                                                  .addonarr
                                                  .forEach((addon) {
                                                if (addon.index == value)
                                                  addOnTemp[indexaddOnTemp]
                                                      .addonarr[_addonindex]
                                                      .isCheck = true;
                                                else
                                                  addOnTemp[indexaddOnTemp]
                                                      .addonarr[_addonindex]
                                                      .isCheck = false;
                                                _addonindex = _addonindex + 1;
                                              });
                                              selectedOptionIndex[
                                                  _addonarr.index] = value;
                                              setState(() {});
                                            },
                                          );
                                        })
                                      : List<CheckboxListTile>.generate(
                                          _addonarr.addonarr.length,
                                          (int indexaddonarr) {
                                          bool isItemCheck =
                                              addOnTemp[indexaddOnTemp]
                                                  .addonarr[indexaddonarr]
                                                  .isCheck;
                                          return new CheckboxListTile(
                                            controlAffinity:
                                                ListTileControlAffinity.leading,
                                            activeColor: Colors.green,
                                            value: isItemCheck,
                                            title: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                new Text(
                                                  _addonarr
                                                      .addonarr[indexaddonarr]
                                                      .addonName,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: UIData
                                                          .font_nunito_sans),
                                                ),
                                                new Text(
                                                  UIData.rupee_sign +
                                                      " " +
                                                      _addonarr
                                                          .addonarr[
                                                              indexaddonarr]
                                                          .addonPrice
                                                          .toString(),
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: UIData
                                                          .font_nunito_sans),
                                                ),
                                              ],
                                            ),
                                            onChanged: (bool value) {
                                              onChangeCustomeOption = true;
                                              addOnTemp[indexaddOnTemp]
                                                  .addonarr[indexaddonarr]
                                                  .isCheck = value;
                                              setState(() {});
                                            },
                                          );
                                        })),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    // Padding(padding: EdgeInsets.only(top: 50.0)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 60,
                          width: 120,
                          margin: EdgeInsets.only(bottom: 10.0),
                          child: FlatButton(
                            color: Colors.black,
                            padding: const EdgeInsets.all(8.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            onPressed: () {
                              bool checked = false;
                              for (var i = 0; i < addOnTemp.length; i++) {
                                checked = false;
                                if (!addOnTemp[i].compulsory) {
                                  addOnTemp[i].addonarr.forEach((_addon) {
                                    if (_addon.isCheck == true) checked = true;
                                  });
                                } else
                                  checked = true;
                                if (!checked) break;
                              }
                              if (!checked) {
                                showSnackBar3();
                              } else {
                                addOnTemp.forEach((_addon) {
                                  _addon.addonarr.forEach((_addonarr) {
                                    if (_addonarr.isCheck == true)
                                      addOn.add(new AddonOrder(
                                          name: _addon.name,
                                          addonName: _addonarr.addonName,
                                          addonPrice: _addonarr.addonPrice));
                                  });
                                });
                                print(addOn);
                                addItemToOrderList();
                                Navigator.of(context).pop();
                              }
                            },
                            child: Text(
                              UIData.label_done,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontFamily: UIData.font_nunito_sans,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }
}
