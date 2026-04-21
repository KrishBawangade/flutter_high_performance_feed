// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_like_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserLikeModel _$UserLikeModelFromJson(Map<String, dynamic> json) =>
    UserLikeModel(
      userId: json['user_id'] as String,
      postId: json['post_id'] as String,
    );

Map<String, dynamic> _$UserLikeModelToJson(UserLikeModel instance) =>
    <String, dynamic>{'user_id': instance.userId, 'post_id': instance.postId};
