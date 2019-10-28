import 'package:finesse/model/addon.dart';
import 'package:finesse/model/addonarr.dart';

class FoodItem {
  int caffeId;
  List<AddonArr> addonList;
  String foodCategory;
  String foodDesc;
  String foodId;
  String foodImage;
  String foodName;
  String foodType;
  String hashTag;
  bool isAvail;
  bool isDeleted;
  String price;

  FoodItem(
      {this.caffeId,
      this.addonList,
      this.foodCategory,
      this.foodDesc,
      this.foodId,
      this.foodImage,
      this.foodName,
      this.foodType,
      this.hashTag,
      this.isAvail,
      this.isDeleted,
      this.price});

  FoodItem.fromJSON(Map<String, dynamic> json) {
    caffeId = json["caffeid"];
//    addonList = getaddonList(json['addon']).cast<Addon>();
    foodCategory = json['foodcategory'];
    foodDesc = json['fooddesc'];
    foodId = json['foodid'];
    foodImage = json['foodimage'];
    foodName = json['foodname'];
    foodType = json['foodtype'];
    hashTag = json['hashtag'];
    isAvail = json['isavail'];
    isDeleted = json['isdeleted'];
    price = json['price'];

    addonList = new List();
    List<dynamic> listAddon = json['addon'];
    listAddon.forEach((item) {
      addonList.add(AddonArr.fromJson(item));
    });
  }

  static List<Addon> getaddonList(list) {
    List<Addon> itemsList = [];
    try {
      list.map((i) => Addon.fromJSON(i)).toList().cast<Addon>();
      itemsList = list.map((i) => Addon.fromJSON(i)).toList().cast<Addon>();
    } catch (e) {} finally {}
    return itemsList;
  }

}
