import 'dart:async';
import 'package:finesse/api/FinesseApi.dart';
import 'package:finesse/logic/viewmodel/food_item_view_model.dart';
import 'package:finesse/model/food_item.dart';


class FoodItemBloc {
  final FoodItemViewModel foodItemViewModel = FoodItemViewModel();
  final foodItemController = StreamController<List<FoodItem>>();
  Stream<List<FoodItem>> get foodItems => foodItemController.stream;
  StreamSink<List<FoodItem>> get foodMenuItemsSink => foodItemController.sink;
  List<FoodItem> foodMenus = [];

  FoodItemBloc() {
    foodMenus.clear();
  }

  getfoodMenuBycategory(String category) {
  foodMenus.clear();
    api.getfoodMenuBycategory(category).then((list) {
      list.forEach((foodMenu) {
        foodMenus.add(foodMenu);
      });

      foodMenuItemsSink.add(foodMenus);
    });

  }
  
}
