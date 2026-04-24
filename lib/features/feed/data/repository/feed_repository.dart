import '../datasource/feed_remote_datasource.dart';
import '../models/post_model.dart';

class FeedRepository {
  final FeedRemoteDatasource datasource;
  final String userId;

  FeedRepository(this.datasource, this.userId);

  Future<List<PostModel>> fetchPosts({
    required int from,
    required int to,
  }) async {
    final response = await datasource.fetchPosts(
      from: from,
      to: to,
    );

    return response.map<PostModel>((json) {
      final likes = json['user_likes'] as List?;

      final isLiked = likes?.any(
            (like) => like['user_id'] == userId,
          ) ??
          false;

      final post = PostModel.fromJson(json);

      return post.copyWith(isLiked: isLiked);
    }).toList();
  }

  Future<void> toggleLike({required String postId}){
    return datasource.toggleLike(postId: postId, userId: userId);
  }
}