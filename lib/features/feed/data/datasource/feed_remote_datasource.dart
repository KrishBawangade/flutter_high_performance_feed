import 'package:supabase_flutter/supabase_flutter.dart';

class FeedRemoteDatasource {
  final SupabaseClient client;

  FeedRemoteDatasource(this.client);

  // returning the post fields and also returning the matched user id list for this post from user likes table
  Future<List<Map<String, dynamic>>> fetchPosts({
    required int from,
    required int to,
  }) async {
    final response = await client
        .from('posts')
        .select('''
          id,
          created_at,
          media_thumb_url,
          media_mobile_url,
          media_raw_url,
          like_count,
          user_likes!left(user_id)
        ''')
        .order('created_at', ascending: false)
        .range(from, to);

    return List<Map<String, dynamic>>.from(response);
  }

  // calls the toggle like function stored on remote
  Future<void> toggleLike({required String postId, required String userId}) async{
    await client.rpc(
      "toggle_like",
      params: {
        "p_post_id": postId,
        "p_user_id": userId
      }
    );
  }
}