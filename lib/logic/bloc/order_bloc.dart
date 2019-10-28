import 'dart:async';

import 'package:finesse/api/FinesseApi.dart';
import 'package:finesse/constant/Constant.dart';
import 'package:finesse/logic/viewmodel/order_view_model.dart';
import 'package:finesse/model/order_detail.dart';
import 'package:flutter/material.dart';

class OrderBloc {
  final OrderViewModel orderViewModel = OrderViewModel();
  final orderController = StreamController<List<Order>>();
  Stream<List<Order>> get orderItems => orderController.stream;
  StreamSink<List<Order>> get orderItemsSink => orderController.sink;
  List<Order> orders = [];
  OrderBloc() {
    // orderController.add(orderViewModel.getOrders());
   // orderController.add(currentOrderList);
  }

  getOrders() {
  if(ngoAmountStateChanged)
    {
      ngoAmountStateChanged = false;
       return;
    }
  orders.clear();


    if(isOrderInitiated == true){
      orders = currentOrderList;
      orderItemsSink.add(orders);
      debugPrint("if" );
    }
    else if (isOrderInitiated == false){
      getCleintOrderFromApi();
    }

  }

  getCleintOrderFromApi() {
      orders.clear();
      api.getCleintOrder().then((list) {
      // debugPrint("number of food menu " + list.length.toString());
       list.forEach((order) {

        if(order.is_placed){
          order.status = ORDER_STATUS[0];
        }else if(!order.is_placed){
          order.status = ORDER_STATUS[2];
        }
        debugPrint("ORDER_STATUS from remote" + order.status);
        orders.add(order);
         debugPrint(" items in order "+orders.last.items.length.toString());
      });

     currentOrderList.clear();
      currentOrderList.addAll(orders);
      //  categoryController.add(categories);
      orderItemsSink.add(orders);
    });
  }
}




