import 'package:finesse/model/food_item_order.dart';

class Order {
  List<FoodItemOrder> items;
//  int quantity;
  String status;
  String order_identifier;
  String order_time;
  bool is_placed;

  Order({this.order_identifier,this.items,this.status});

    Order.fromJSON(Map<String, dynamic> json)
  : is_placed = json["is_placed"],
    order_identifier = json["order_identifier"],
    order_time = "order_time",
    items = (json["food_items"] as List).map((json)=> FoodItemOrder.fromJSON(json)).toList().cast<FoodItemOrder>();
  

    Map<String, dynamic> toJson() => {
    "order_identifier": order_identifier,
    "is_placed": is_placed,
    "order_time":order_time,
    "food_items":items.map((item)=>item.toJson()).toList(),

  };


}