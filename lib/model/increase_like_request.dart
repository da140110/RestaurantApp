class LikeRequest {

  String caffeID;
  String commentId;
  String status;



  LikeRequest({
      this.caffeID,
      this.commentId
  });

  LikeRequest.fromJSON(Map<String, dynamic> json)
    :status = json['status'];
     
  Map<String, dynamic> toJson() => {
    "caffeID": caffeID,
    "commentid": commentId,
  };  
  
}