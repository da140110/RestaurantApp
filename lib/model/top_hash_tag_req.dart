class HashTagRequest {

  String caffeID;
  String currentdate;

  HashTagRequest({
    this.caffeID,
    this.currentdate
  });


     Map<String, dynamic> toJson() => {
      "caffeID": caffeID,
      "currentdate": currentdate
     };    
  
}