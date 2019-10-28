class Addon {
  int index;
  String addonName;
  int addonPrice;
  bool isCheck;
  Addon({this.index, this.addonName, this.addonPrice, this.isCheck});

  Addon.fromJSON(Map<String, dynamic> json)
      : addonName = json["addonname"],
        addonPrice = json["addonprice"];
}
