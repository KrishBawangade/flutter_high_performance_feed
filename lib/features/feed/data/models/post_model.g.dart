// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostModel _$PostModelFromJson(Map<String, dynamic> json) => PostModel(
  id: json['id'] as String,
  createdAt: DateTime.parse(json['created_at'] as String),
  mediaThumbUrl: json['media_thumb_url'] as String,
  mediaMobileUrl: json['media_mobile_url'] as String,
  mediaRawUrl: json['media_raw_url'] as String,
  likeCount: (json['like_count'] as num).toInt(),
);

Map<String, dynamic> _$PostModelToJson(PostModel instance) => <String, dynamic>{
  'id': instance.id,
  'created_at': instance.createdAt.toIso8601String(),
  'media_thumb_url': instance.mediaThumbUrl,
  'media_mobile_url': instance.mediaMobileUrl,
  'media_raw_url': instance.mediaRawUrl,
  'like_count': instance.likeCount,
};
