class FeedbackInfo {

  String question;
  String answer;
  FeedbackInfo({
      this.question,
      this.answer
  });

  FeedbackInfo.fromJSON(Map<String, dynamic> json)
    : question = json["Question1"],
      answer =json["Answer"];
   
Map<String, dynamic> toJson() => {
      "Question1": question,
      "Answer": answer,
     }; 
  
}