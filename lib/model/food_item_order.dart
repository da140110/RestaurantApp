import 'package:finesse/model/addon_order.dart';

class FoodItemOrder {

  String foodId;
  String foodItem;
  String foodType;
  String foodCategory;
  List<AddonOrder> addon;
  double addonPrice;
  String foodHashTag;
  int cgst;
  int sgst;
  int quantity;
  double unitPrice;
  double totalBill;
  

  FoodItemOrder({
    this.foodId,
    this.foodItem,
    this.foodType, 
    this.foodCategory,
    this.addon,
    this.foodHashTag,
    this.cgst,
    this.sgst,
    this.quantity,
    this.unitPrice,
    this.totalBill

    });


  FoodItemOrder.fromJSON(Map<String, dynamic> json)
  : foodId = json["foodid"],
    foodItem = json['food_item'],
    foodType = json['food_type'],
    foodCategory = json['food_category'],
    addon = (json["addon"] as List).map((json)=> AddonOrder.fromJSON(json)).toList().cast<AddonOrder>(),
    foodHashTag = json['food_hashtag'],
    cgst = json['cgst'],
    sgst = json['sgst'],
    quantity = json['quantity'],
    unitPrice = (json['unit_price']as int).toDouble(),
    totalBill =(json['total']as int).toDouble();


  Map<String, dynamic> toJson() => {
      "foodid": foodId,
      "food_item":foodItem,
      "food_type":foodType,
      "food_category":foodCategory,
      "addon":addon.map((item)=>item.toJson()).toList(),
      "food_hashtag":foodHashTag,
      "cgst":cgst,
      "sgst":sgst,
      "quantity":quantity,
      "unit_price":unitPrice,
      "total":totalBill
     }; 

}
