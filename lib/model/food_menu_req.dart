class FoodMenuRequest {

  String caffeID;
  String foodcategory;

  FoodMenuRequest({
    this.caffeID,
    this.foodcategory,
  });


     Map<String, dynamic> toJson() => {
      "caffeID": caffeID,
      "foodcategory": foodcategory
     };    
  
}