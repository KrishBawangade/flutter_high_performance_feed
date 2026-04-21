import '../datasource/feed_remote_datasource.dart';
import '../models/post_model.dart';

class FeedRepository {
  final FeedRemoteDatasource datasource;

  FeedRepository(this.datasource);

  // repository function that fetches the posts by calling the data source function
  Future<List<PostModel>> fetchPosts({
    required int from,
    required int to,
  }) {
    return datasource.fetchPosts(from: from, to: to);
  }
}