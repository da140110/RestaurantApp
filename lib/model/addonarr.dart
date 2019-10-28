import 'package:finesse/model/addon.dart';

class AddonArr {
  int index;
  String name;
  List<Addon> addonarr;
  bool compulsory;
  String select;
  AddonArr(
      {this.index, this.name, this.select, this.addonarr, this.compulsory});
  AddonArr.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    compulsory = json['compulsory'];
    select = json['select'];
    List<dynamic> listData = json['addonarr'];
    addonarr = new List();
    listData.forEach((item) {
      addonarr.add(Addon.fromJSON(item));
    });
  }
}
