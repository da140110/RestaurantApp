class FoodCategory {
  int id;
  String title;
  String image;
  String subtitle;

  FoodCategory({
    this.id,
    this.title,
    this.subtitle,
    this.image
  }
  );

    FoodCategory.fromJSON(Map<String, dynamic> json)
    : title = json["foodcategory"],
      image = json['foodcategoryimage'],
      subtitle = json['foodcategorydesc'];

}