import 'package:finesse/model/status.dart';

class HashTag {

  List<Status> statusList;

  HashTag({
      this.statusList
  });

  HashTag.fromJSON(Map<String, dynamic> json)
    : statusList = (json["status"] as List).map((json)=> Status.fromJSON(json)).toList();
   
  
}