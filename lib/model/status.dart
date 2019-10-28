class Status {

  String hashtag;
  int orderCount;
  int likeCount;
  String topCommentId;
  String topComment;

  Status({
    this.hashtag,
    this.orderCount,
    this.likeCount,
    this.topCommentId,
    this.topComment
  });

  Status.fromJSON(Map<String, dynamic> json)
    : hashtag = json["hashtag"],
      orderCount = json['ordercount'],
      likeCount = json['likecount'],
      topCommentId = json['topcommentid'],
      topComment =json['topcomment'];
 
  
}