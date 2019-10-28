import 'package:finesse/model/order_detail.dart';
class MakeOrder {
  List<Order> items;
  String caffeID;
  String tableidtimestamp;
  String tableid;
  String makeOrder;

  MakeOrder({this.caffeID,this.items,this.tableidtimestamp,this.tableid});


  Map<String, dynamic> toJson() => {
    "caffeID": caffeID,
    "tableidtimestamp": tableidtimestamp,
    "tableid": tableid,
    "orders":items.map((item)=>item.toJson()).toList(),
  };

  Map<String, dynamic> toClietnOrderJson() => {
    "caffeID": caffeID,
    "tableidtimestamp": tableidtimestamp,
    "tableid": tableid
  };

  MakeOrder.fromJSON(Map<String, dynamic> json)
    : makeOrder = json["makeOrder"];

}