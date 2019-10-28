import 'package:json_annotation/json_annotation.dart';
/// This allows the `ClientInfoResponse` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
// part 'clientInfo.g.dart';
part 'client_info_response.g.dart';

@JsonSerializable()
class ClientInfoResponse {

  
  String insertClientInfo;  // "success"

  ClientInfoResponse(
      {this.insertClientInfo}
      );

        /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$ClientInfoResponseFromJson()` constructor.
  /// The constructor is named after the source class, in this case User.
  factory ClientInfoResponse.fromJson(Map<String, dynamic> json) => _$ClientInfoResponseFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$ClientInfoResponseToJson`.
  Map<String, dynamic> toJson() => _$ClientInfoResponseToJson(this);

}
