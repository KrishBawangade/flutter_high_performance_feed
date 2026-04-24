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

  @JsonKey(includeFromJson: false, includeToJson: false)
  final bool isLiked;

  PostModel({
    required this.id,
    required this.createdAt,
    required this.mediaThumbUrl,
    required this.mediaMobileUrl,
    required this.mediaRawUrl,
    required this.likeCount,
    this.isLiked = false
  });

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostModelToJson(this);

  PostModel copyWith({
    int? likeCount,
    bool? isLiked,
  }) {
    return PostModel(
      id: id,
      createdAt: createdAt,
      mediaThumbUrl: mediaThumbUrl,
      mediaMobileUrl: mediaMobileUrl,
      mediaRawUrl: mediaRawUrl,
      likeCount: likeCount ?? this.likeCount,
      isLiked: isLiked ?? this.isLiked,
    );
  }

  
}