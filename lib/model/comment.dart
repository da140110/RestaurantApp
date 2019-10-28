class StatusComment {

  String caffeId;
  String timeStamp;
  String foodHashtag;
  String clientName;
  String foodComment;
  String commentid;
  int like;
  String sendCommentReqResponse;


  StatusComment({
      this.caffeId,
      this.timeStamp,
      this.foodHashtag,
      this.clientName,
      this.foodComment,
      this.commentid,
      this.like
  });

  StatusComment.fromJSON(Map<String, dynamic> json)
    : commentid = json["commentid"],
      timeStamp = json["timestamp"],
      clientName =json['clientname'],
      foodComment =json['foodcomment'],
      like =json['likecount'];
   
Map<String, dynamic> toJson() => {
      "caffeID": caffeId,
      "foodhashtag":foodHashtag,
     }; 

Map<String, dynamic> toJsonMakeComment() => {
      "caffeID": caffeId,
      "timestamp": timeStamp,
      "foodhashtag":foodHashtag,
      "clientname":clientName,
      "foodcomment":foodComment,
      "like":like
     }; 

   StatusComment.fromJSONreq(Map<String, dynamic> json)
    : sendCommentReqResponse = json["insert food trending"];    
  
}