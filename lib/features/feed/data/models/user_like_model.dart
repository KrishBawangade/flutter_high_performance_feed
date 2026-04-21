import 'package:json_annotation/json_annotation.dart';

part 'user_like_model.g.dart';

@JsonSerializable()
class UserLikeModel {
  @JsonKey(name: 'user_id')
  final String userId;

  @JsonKey(name: 'post_id')
  final String postId;

  UserLikeModel({
    required this.userId,
    required this.postId,
  });

  factory UserLikeModel.fromJson(Map<String, dynamic> json) =>
      _$UserLikeModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserLikeModelToJson(this);
}