import 'package:finesse/model/food_item.dart';
import 'package:finesse/util/uidata.dart';

class FoodItemViewModel {
  List<FoodItem> categoryItems;

  FoodItemViewModel({this.categoryItems});

  getItems() => <FoodItem>[
        FoodItem(
            caffeId: 1,
            isAvail: false,
            foodName: "English Breakfast",
            foodType: "Breakfast",
            foodDesc: "100% off on exciting combo offers 100% off on exciting combo offers 100% off on exciting combo offers",
            foodImage: UIData.image_breakfast,
            price: "₹ 450"),
        FoodItem(
            caffeId: 1,
            isAvail: false,
            foodName: "English Breakfast",
            foodType: "Breakfast",
            foodDesc: "100% off on exciting combo offers 100% off on exciting combo offers 100% off on exciting combo offers",
            foodImage: UIData.image_breakfast,
            price: "₹ 450"),
        FoodItem(
            caffeId: 1,
            isAvail: false,
            foodName: "English Breakfast",
            foodType: "Breakfast",
            foodDesc: "100% off on exciting combo offers 100% off on exciting combo offers 100% off on exciting combo offers",
            foodImage: UIData.image_breakfast,
            price: "₹ 450"),
        FoodItem(
            caffeId: 1,
            isAvail: false,
            foodName: "English Breakfast",
            foodType: "Breakfast",
            foodDesc: "100% off on exciting combo offers 100% off on exciting combo offers 100% off on exciting combo offers",
            foodImage: UIData.image_breakfast,
            price: "₹ 450"),
        FoodItem(
            caffeId: 1,
            isAvail: false,
            foodName: "English Breakfast",
            foodType: "Breakfast",
            foodDesc: "100% off on exciting combo offers 100% off on exciting combo offers 100% off on exciting combo offers",
            foodImage: UIData.image_breakfast,
            price: "₹ 450"),
        FoodItem(
            caffeId: 1,
            isAvail: false,
            foodName: "English Breakfast",
            foodType: "Breakfast",
            foodDesc: "100% off on exciting combo offers 100% off on exciting combo offers 100% off on exciting combo offers",
            foodImage: UIData.image_breakfast,
            price: "₹ 450"),
      ];
}
