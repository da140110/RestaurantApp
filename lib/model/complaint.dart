class Complaint {

  String issue;
  String complaintTime;
  String currentStatus;


  Complaint({
      this.issue,
      this.complaintTime,
      this.currentStatus
  });

  Complaint.fromJSON(Map<String, dynamic> json)
    : issue = json["issue"],
      complaintTime =json['complaint_time'],
      currentStatus =json['current_status'];
   
Map<String, dynamic> toJson() => {
      "issue": issue,
      "complaint_time":complaintTime,
      "current_status":currentStatus,
     }; 
  
}