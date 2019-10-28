import 'package:finesse/model/feedback.dart';

class FeedbackRequest {

  String caffeID;
  String tableidtimestamp;
  List<FeedbackInfo> feedbackList;
  String feedback_comment;

  String feedbackResponse;


  FeedbackRequest({
      this.caffeID,
      this.tableidtimestamp,
      this.feedbackList,
      this.feedback_comment
  });

  FeedbackRequest.fromJSON(Map<String, dynamic> json)
    : feedbackList = (json["feedback"] as List).map((json)=> FeedbackInfo.fromJSON(json)).toList(),
    caffeID = json['caffeID'],
    feedback_comment =json['feedback_comment'],
    tableidtimestamp = json['tableidtimestamp'];

  FeedbackRequest.fromJSONresponse(Map<String, dynamic> json)
    : feedbackResponse = json['makeFeedback'];  
     
  Map<String, dynamic> toJson() => {
    "caffeID": caffeID,
    "feedback_comment": feedback_comment,
    "tableidtimestamp": tableidtimestamp,
    "feedback":feedbackList.map((item)=>item.toJson()).toList()
  };  
  
}