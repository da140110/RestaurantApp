import 'dart:async';

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

//  final double bottomBarScale = .087239;

  int itemQuantity = 1;

  static List<String> options = [];

  // <String>[
  //   'Option1',
  //   'Option2',
  //   'Option3',
  //   'Option4',
  // ];

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

  // show customize dialog

  void customizeOptionDialog(BuildContext context) {
    bool checked = true;
    addOn.clear();
    Size size = MediaQuery.of(context).size;
    Dialog customDialog = Dialog(
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
                itemCount: item.addonList.length,
                itemBuilder: (context, index) {
                  AddonArr addonarr = item.addonList[index];
                  AddonOrder addOnOrder = new AddonOrder();
                  addOnOrder.name = addonarr.name;
                  addOnOrder.addonarr = addonarr.addonarr;
                  addOnOrder.addonName = "null";
                  addOnOrder.addonPrice = 0;
                  addOnOrder.compulsory = addonarr.compulsory;
                  print(addonarr.name + addonarr.select);
                  addOn.add(addOnOrder);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: 8.0,
                          top: 8.0,
                        ),
                        child: Text(
                          addonarr.name,
                          maxLines: 1,
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: UIData.font_nunito_sans,
                              fontStyle: FontStyle.italic,
                              fontSize: 15),
                        ),
                      ),
                      new CustomizeContent(
                        select: addonarr.select,
                        options: addonarr.addonarr, //op
                        optionsBool:
                            addonarr.addonarr.map((_) => false).toList(),
                        Index: index,
                        selectedIndex: (value, addon) {
                          Addon add;
                          print(addOn.map((v) => v.addonName));
                          if (addon is Addon) {
                            add = addon;
                            addOn[value].compulsory = true;
                            addOn[value].addonPrice = add.addonPrice;
                            addOn[value].addonName = add.addonName;
                          } else {
                            List<Addon> selectedAddons = addon;
                            print(selectedAddons.map((v) => v.addonName));
                            if (selectedAddons.length != 0) {
                              print(selectedAddons.length);
                              addOn[value].compulsory = true;
                              addOn[value].addonPrice =
                                  selectedAddons[0].addonPrice;
                              addOn[value].addonName =
                                  selectedAddons[0].addonName;
                              if (selectedAddons.length > 1) {
                                for (int i = 1;
                                    i < selectedAddons.length;
                                    i++) {
                                  addOn.add(AddonOrder(
                                      addonPrice: selectedAddons[i].addonPrice,
                                      addonName: selectedAddons[i].addonName));
                                }
                              }
                            } else {
                              addOn[value].compulsory = false;
                              addOn[value].addonPrice = null;
                              addOn[value].addonName = null;
                            }
                          }
                        },
                        selectedAddOn: (addOn) {
                          Addon add = addOn;
                        },
                      ),
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
                      for (var i = 0; i < addOn.length; i++) {
                        debugPrint("ss" + addOn[i].addonName.toString());
                        if (!addOn[i].compulsory) {
                          checked = false;
                          showSnackBar3();
                          break;
                        }
                      }
                      if (checked) {
                        addItemToOrderList();
                        Navigator.of(context).pop();
                      } else {
                        checked = true;
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

    showDialog(
        context: context, builder: (BuildContext context) => customDialog);
  }
}

class CustomizeContent extends StatefulWidget {
  CustomizeContent(
      {Key key,
      this.options,
      this.optionsBool,
      this.Index,
      this.select,
      this.selectedIndex,
      this.selectedAddOn})
      : super(key: key);

  final List<Addon> options;
  final List<bool> optionsBool;
  final int Index;
  final String select;
  Function selectedIndex;
  Function selectedAddOn;

  @override
  _CustomizeContentState createState() => new _CustomizeContentState();
}

class _CustomizeContentState extends State<CustomizeContent> {
  int _selectedOptionIndex = 99;
  List<Addon> selectedAddons = List<Addon>();

  @override
  void initState() {
    super.initState();
  }

  _getContent() {
    return Column(
      children: <Widget>[
        Column(
            children: widget.select == 'single'
                ? new List<RadioListTile<int>>.generate(widget.options.length,
                    (int index) {
                    return new RadioListTile<int>(
                      activeColor: Colors.green,
                      value: index,
                      groupValue: _selectedOptionIndex,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new Text(
                            widget.options[index].addonName,
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: UIData.font_nunito_sans),
                          ),
                          new Text(
                            UIData.rupee_sign +
                                " " +
                                widget.options[index].addonPrice.toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: UIData.font_nunito_sans),
                          ),
                        ],
                      ),
                      onChanged: (int value) {
                        setState(() {
                          _selectedOptionIndex = value;
                          widget.selectedIndex(
                              widget.Index, widget.options[value]);
                          widget.selectedAddOn(widget.options[value]);
                        });
                      },
                    );
                  })
                : List<CheckboxListTile>.generate(widget.optionsBool.length,
                    (int index) {
                    return new CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      activeColor: Colors.green,
                      value: widget.optionsBool[index],
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new Text(
                            widget.options[index].addonName,
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: UIData.font_nunito_sans),
                          ),
                          new Text(
                            UIData.rupee_sign +
                                " " +
                                widget.options[index].addonPrice.toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: UIData.font_nunito_sans),
                          ),
                        ],
                      ),
                      onChanged: (value) {
                        setState(() {
                          widget.optionsBool[index] = value;

                          if (widget.optionsBool[index]) {
                            selectedAddons.add(widget.options[index]);
                          }
                          if (!widget.optionsBool[index]) {
                            selectedAddons.remove(widget.options[index]);
                          }
                        });

                        _selectedOptionIndex = index;
                        widget.selectedIndex(widget.Index, selectedAddons);
                        widget.selectedAddOn(widget.options[index]);
                      },
                    );
                  })),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _getContent();
  }
}
