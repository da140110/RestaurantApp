class GetCommentsRequest {

  String caffeID;
  String foodHashtag;



  GetCommentsRequest({
      this.caffeID,
      this.foodHashtag
  });

  GetCommentsRequest.fromJSON(Map<String, dynamic> json)
    :caffeID = json['caffeID'],
    foodHashtag =json['foodhashtag'];
     
  Map<String, dynamic> toJson() => {
    "caffeID": caffeID,
    "foodhashtag": foodHashtag,
  };  
  
}