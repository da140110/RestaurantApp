import 'package:finesse/model/complaint.dart';

class ComplaintRequest {

  String caffeId;
  String tableidtimestamp;
  String tableid;
  String currentDate;
  List<Complaint> complaintList;
  String complaintResponse;



  ComplaintRequest({
      this.caffeId,
      this.tableidtimestamp,
      this.tableid,
      this.complaintList
  });

  ComplaintRequest.fromJSON(Map<String, dynamic> json)
    : complaintResponse = json["makeComplaint"];
   
Map<String, dynamic> toJson() => {
      "caffeID": caffeId,
      "tableidtimestamp": tableidtimestamp,
      "tableid": tableid,
      "currentDate": currentDate,
      "complaints":complaintList.map((item)=>item.toJson()).toList(),//complaintList,
     }; 
  
}