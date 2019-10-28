class CafeInfo {

  String caffeId;
  String caffeAddress;
  String caffename;
  String type;

  CafeInfo({
    this.caffeId,
    this.caffename,
    this.caffeAddress,
    this.type
  });

  CafeInfo.fromJSON(Map<String, dynamic> json)
    : caffeAddress = json["caffeAddress"],
      caffename = json['caffename'],
      type = json['type'];

     Map<String, dynamic> toJson() => {
      "caffeID": caffeId
     };    
  
}