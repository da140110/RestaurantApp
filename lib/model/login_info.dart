import 'package:json_annotation/json_annotation.dart';
/// This allows the `ClientInfo` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'login_info.g.dart';

@JsonSerializable()
class LoginInfo {
  @JsonKey(name: 'caffeID')
  String caffeID;

  @JsonKey(name: 'password')
  String password;

  // client info save response

  // String insertClientInfo;  // "success"

  LoginInfo({this.caffeID,
    this.password,});

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$ClientInfoFromJson()` constructor.
  /// The constructor is named after the source class, in this case User.
  factory LoginInfo.fromJson(Map<String, dynamic> json) =>
      _$LoginInfoFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$ClientInfoToJson`.
  Map<String, dynamic> toJson() => _$LoginInfoToJson(this);

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
    return '"caffeId":${this.caffeID},"password":${this.password}';
  }
}