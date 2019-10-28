import 'dart:async';
import 'package:finesse/api/FinesseApi.dart';
import 'package:finesse/model/menu_category.dart';
import 'package:finesse/logic/viewmodel/food_category_view_model.dart';

class CategoryBloc {
  final FoodCategoryViewModel foodCategoryViewModel = FoodCategoryViewModel();
  final foodCategoryController = StreamController<List<FoodCategory>>();
  Stream<List<FoodCategory>> get fodoCategorytItems => foodCategoryController.stream;
  StreamSink<List<FoodCategory>> get fodoCategorytItemsSink => foodCategoryController.sink;
  List<FoodCategory> categories = [];
  CategoryBloc() {
    categories.clear();
  }

    getfoodcategory() {

    api.getfoodcategory().then((list) {
      categories.clear();
      list.forEach((category) {
        categories.add(category);
      });

      fodoCategorytItemsSink.add(categories);
    });
  }

}
