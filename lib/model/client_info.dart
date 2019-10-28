import 'package:json_annotation/json_annotation.dart';
/// This allows the `ClientInfo` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
// part 'clientInfo.g.dart';
part 'client_info.g.dart';

@JsonSerializable()
class ClientInfo {
  @JsonKey(name: 'caffeID')
  String caffeID;

  @JsonKey(name: 'tableid')
  String tableId;

  @JsonKey(name: 'currentDate')
  String currentDate;

  @JsonKey(name: 'tableidtimestamp')
  String tableIdTimestamp;

  @JsonKey(name: 'client_name')
  String clientName;

  @JsonKey(name: 'client_phone')
  String clientPhone;

  @JsonKey(name: 'occassion')
  String occassion;

  @JsonKey(name: 'age')
  int age;

  @JsonKey(name: 'client_email')
  String clientEmail;

  @JsonKey(name: 'timestamp')
  String timestamp;

  @JsonKey(name: 'totalpersons')
  int totalpersons;

  // client info save response
  
  // String insertClientInfo;  // "success"

  ClientInfo(
      {this.caffeID,
      this.tableId,
      this.currentDate,
      this.tableIdTimestamp,
      this.clientName,
      this.clientPhone,
      this.occassion,
      this.age,
      this.clientEmail,
      this.timestamp,
      this.totalpersons});

        /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$ClientInfoFromJson()` constructor.
  /// The constructor is named after the source class, in this case User.
  factory ClientInfo.fromJson(Map<String, dynamic> json) => _$ClientInfoFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$ClientInfoToJson`.
  Map<String, dynamic> toJson() => _$ClientInfoToJson(this);

  // ClientInfo.fromJSON(Map<String, dynamic> json)
  //   : insertClientInfo = json["insertClientInfo"];

  //  Map<String, dynamic> toJson() => {
  //   "caffeID": caffeID,
  //   "tableid": tableId,
  //   "currentDate": currentDate,
  //   "tableidtimestamp": tableIdTimestamp,
  //   "client_name": clientName,
  //   "client_phone": clientPhone,
  //   "occassion": occassion,
  //   "age":age,
  //   "client_email":clientEmail,
  //   "timestamp": timestamp,
  //   "totalpersons": totalpersons

  // };

  String toString() {

    return '"caffeId":${this.caffeID},"tableId":${this.tableId},"currentDate":${this.currentDate},"tableIdTimestamp":${this.tableIdTimestamp},"clientName":${this.clientName},"clientPhone":${this.clientPhone},"occassion":${this.occassion},"age":${this.age.toString()},"client_email":${this.clientEmail},"timestamp":${this.timestamp},"totalpersons":${this.totalpersons.toString()}';

  }






}
