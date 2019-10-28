import 'addon.dart';

class AddonOrder {
  String name;
  String addonName;
  int addonPrice;
  List<Addon> addonarr;
  bool compulsory;
  AddonOrder(
      {this.addonName,
      this.name,
      this.addonarr,
      this.addonPrice,
      this.compulsory});

  AddonOrder.fromJSON(Map<String, dynamic> json)
      : name = json["name"],
        addonName = json["addonname"],
        addonPrice = json["addonprice"];

  Map<String, dynamic> toJson() =>
      {"name": name, "addonname": addonName, "addonprice": addonPrice};
}
