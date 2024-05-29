import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../common/utils/data_utils.dart';

part 'customer_model.g.dart';

@JsonSerializable()
class CustomerModel {
  final String uid;
  final String nickname;
  final String email;
  final String phone;
  final List<String> gameList;
  final int runCount;
  @JsonKey(fromJson: DataUtils.timestampToDateTime)
  final DateTime createdAt;

  CustomerModel({
    required this.uid,
    required this.nickname,
    required this.email,
    required this.phone,
    required this.gameList,
    required this.runCount,
    required this.createdAt,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) =>
      _$CustomerModelFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerModelToJson(this);

  CustomerModel copyWith({
    String? uid,
    String? nickname,
    String? email,
    String? phone,
    List<String>? gameList,
    int? runCount,
    DateTime? createdAt,
  }) =>
      CustomerModel(
        uid: uid ?? this.uid,
        nickname: nickname ?? this.nickname,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        gameList: gameList ?? this.gameList,
        runCount: runCount ?? this.runCount,
        createdAt: createdAt ?? this.createdAt,
      );
}
