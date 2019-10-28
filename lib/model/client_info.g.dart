// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClientInfo _$ClientInfoFromJson(Map<String, dynamic> json) {
  return ClientInfo(
      caffeID: json['caffeID'] as String,
      tableId: json['tableid'] as String,
      currentDate: json['currentDate'] as String,
      tableIdTimestamp: json['tableidtimestamp'] as String,
      clientName: json['client_name'] as String,
      clientPhone: json['client_phone'] as String,
      occassion: json['occassion'] as String,
      age: json['age'] as int,
      clientEmail: json['client_email'] as String,
      timestamp: json['timestamp'] as String,
      totalpersons: json['totalpersons'] as int);
}

Map<String, dynamic> _$ClientInfoToJson(ClientInfo instance) =>
    <String, dynamic>{
      'caffeID': instance.caffeID,
      'tableid': instance.tableId,
      'currentDate': instance.currentDate,
      'tableidtimestamp': instance.tableIdTimestamp,
      'client_name': instance.clientName,
      'client_phone': instance.clientPhone,
      'occassion': instance.occassion,
      'age': instance.age,
      'client_email': instance.clientEmail,
      'timestamp': instance.timestamp,
      'totalpersons': instance.totalpersons
    };
