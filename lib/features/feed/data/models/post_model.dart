import 'package:json_annotation/json_annotation.dart';

part 'post_model.g.dart';

@JsonSerializable()
class PostModel {
  final String id;

  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @JsonKey(name: 'media_thumb_url')
  final String mediaThumbUrl;

  @JsonKey(name: 'media_mobile_url')
  final String mediaMobileUrl;

  @JsonKey(name: 'media_raw_url')
  final String mediaRawUrl;

  @JsonKey(name: 'like_count')
  final int likeCount;

  PostModel({
    required this.id,
    required this.createdAt,
    required this.mediaThumbUrl,
    required this.mediaMobileUrl,
    required this.mediaRawUrl,
    required this.likeCount,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostModelToJson(this);
}