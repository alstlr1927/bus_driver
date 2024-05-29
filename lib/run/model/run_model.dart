import 'package:json_annotation/json_annotation.dart';
import "package:cloud_firestore/cloud_firestore.dart";

import '../../common/utils/data_utils.dart';

part 'run_model.g.dart';

abstract class RunBase {}

class EmptyRun extends RunBase {}

@JsonSerializable()
class RunModel extends RunBase {
  final String id;
  final String nickname;
  final String customerUid;
  final String managerUid;
  final String runState;
  final int completedCount;
  final int remainingCount;
  final int totalCount;
  final String gameName;
  @JsonKey(fromJson: DataUtils.timestampToDateTime)
  final DateTime createdAt;
  @JsonKey(fromJson: DataUtils.timestampToDateTimeNull)
  final DateTime? completedAt;
  @JsonKey(fromJson: DataUtils.timestampToDateTimeNull)
  final DateTime? deletedAt;

  RunModel({
    required this.id,
    required this.nickname,
    required this.customerUid,
    required this.managerUid,
    required this.runState,
    required this.completedCount,
    required this.remainingCount,
    required this.totalCount,
    required this.gameName,
    required this.createdAt,
    required this.completedAt,
    required this.deletedAt,
  });

  factory RunModel.fromJson(Map<String, dynamic> json) =>
      _$RunModelFromJson(json);

  Map<String, dynamic> toJson() => _$RunModelToJson(this);

  RunModel copyWith({
    String? uid,
    String? nickname,
    String? customerUid,
    String? managerUid,
    String? runState,
    int? completedCount,
    int? remainingCount,
    int? totalCount,
    String? gameName,
    DateTime? createdAt,
    DateTime? completedAt,
    DateTime? deletedAt,
  }) =>
      RunModel(
        id: uid ?? this.id,
        nickname: nickname ?? this.nickname,
        customerUid: customerUid ?? this.customerUid,
        managerUid: managerUid ?? this.managerUid,
        runState: runState ?? this.runState,
        completedCount: completedCount ?? this.completedCount,
        remainingCount: remainingCount ?? this.remainingCount,
        totalCount: totalCount ?? this.totalCount,
        gameName: gameName ?? this.gameName,
        createdAt: createdAt ?? this.createdAt,
        completedAt: completedAt ?? this.completedAt,
        deletedAt: deletedAt ?? this.deletedAt,
      );
}
