// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'run_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RunModel _$RunModelFromJson(Map<String, dynamic> json) => RunModel(
      id: json['id'] as String,
      nickname: json['nickname'] as String,
      customerUid: json['customerUid'] as String,
      managerUid: json['managerUid'] as String,
      runState: json['runState'] as String,
      completedCount: (json['completedCount'] as num).toInt(),
      remainingCount: (json['remainingCount'] as num).toInt(),
      totalCount: (json['totalCount'] as num).toInt(),
      gameName: json['gameName'] as String,
      createdAt: DataUtils.timestampToDateTime(json['createdAt'] as Timestamp),
      completedAt:
          DataUtils.timestampToDateTimeNull(json['completedAt'] as Timestamp?),
      deletedAt:
          DataUtils.timestampToDateTimeNull(json['deletedAt'] as Timestamp?),
    );

Map<String, dynamic> _$RunModelToJson(RunModel instance) => <String, dynamic>{
      'id': instance.id,
      'nickname': instance.nickname,
      'customerUid': instance.customerUid,
      'managerUid': instance.managerUid,
      'runState': instance.runState,
      'completedCount': instance.completedCount,
      'remainingCount': instance.remainingCount,
      'totalCount': instance.totalCount,
      'gameName': instance.gameName,
      'createdAt': instance.createdAt.toIso8601String(),
      'completedAt': instance.completedAt?.toIso8601String(),
      'deletedAt': instance.deletedAt?.toIso8601String(),
    };
