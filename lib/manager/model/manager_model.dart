import 'package:json_annotation/json_annotation.dart';

part 'manager_model.g.dart';

@JsonSerializable()
class ManagerModel {
  final String uid;
  final String nickname;
  final String email;
  final String profileImageUrl;
  final String backgroundImageUrl;
  final String grade;

  ManagerModel({
    this.uid = '',
    this.nickname = '',
    this.email = '',
    this.profileImageUrl = '',
    this.backgroundImageUrl = '',
    this.grade = '',
  });

  factory ManagerModel.fromJson(Map<String, dynamic> json) =>
      _$ManagerModelFromJson(json);

  Map<String, dynamic> toJson() => _$ManagerModelToJson(this);

  ManagerModel copyWith({
    String? uid,
    String? nickname,
    String? email,
    String? profileImageUrl,
    String? backgroundImageUrl,
    String? grade,
  }) =>
      ManagerModel(
        uid: uid ?? this.uid,
        nickname: nickname ?? this.nickname,
        email: email ?? this.email,
        profileImageUrl: profileImageUrl ?? this.profileImageUrl,
        backgroundImageUrl: backgroundImageUrl ?? this.backgroundImageUrl,
        grade: grade ?? this.grade,
      );
}
