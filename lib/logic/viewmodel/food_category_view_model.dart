import 'package:finesse/model/menu_category.dart';
import 'package:finesse/util/uidata.dart';

class FoodCategoryViewModel {
  List<FoodCategory> categoryItems;

  FoodCategoryViewModel({this.categoryItems});

  getCategories() => <FoodCategory>[
    FoodCategory(
      id: 1,
      title: "Breakfast",
      subtitle: "100% off on exciting combo offers",
      image: UIData.image_breakfast,
    ),
    FoodCategory(
      id: 1,
      title: "Coffee",
      subtitle: "100% off on exciting combo offers",
      image: UIData.image_breakfast,
    ),    
    FoodCategory(
      id: 1,
      title: "Main course",
      subtitle: "100% off on exciting combo offers",
      image: UIData.image_breakfast,
    ),
    FoodCategory(
      id: 1,
      title: "Mocktail",
      subtitle: "100% off on exciting combo offers",
      image: UIData.image_breakfast,
    ),
    FoodCategory(
      id: 1,
      title: "Desert",
      subtitle: "100% off on exciting combo offers",
      image: UIData.image_breakfast,
    ),        
  ];
}