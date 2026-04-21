import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/post_model.dart';

class FeedRemoteDatasource {
  final SupabaseClient client;

  FeedRemoteDatasource(this.client);

  /*
    function to fetch the posts from remote datasource (supabase) 
    and return the List of posts including pagination(range (from, to))
  */
  Future<List<PostModel>> fetchPosts({
    required int from,
    required int to,
  }) async {
    final response = await client
        .from('posts')
        .select()
        .order('created_at', ascending: false)
        .range(from, to);

    return (response as List)
        .map((e) => PostModel.fromJson(e))
        .toList();
  }
}