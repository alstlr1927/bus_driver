// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerModel _$CustomerModelFromJson(Map<String, dynamic> json) =>
    CustomerModel(
      uid: json['uid'] as String,
      nickname: json['nickname'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      gameList:
          (json['gameList'] as List<dynamic>).map((e) => e as String).toList(),
      runCount: (json['runCount'] as num).toInt(),
      createdAt: DataUtils.timestampToDateTime(json['createdAt'] as Timestamp),
    );

Map<String, dynamic> _$CustomerModelToJson(CustomerModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'nickname': instance.nickname,
      'email': instance.email,
      'phone': instance.phone,
      'gameList': instance.gameList,
      'runCount': instance.runCount,
      'createdAt': instance.createdAt.toIso8601String(),
    };
