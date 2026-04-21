import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repository/feed_repository.dart';
import 'feed_state.dart';

class FeedNotifier extends StateNotifier<FeedState> {
  final FeedRepository repository;

  static const int pageSize = 10;

  int _page = 0;
  bool _hasMoreData = true;

  FeedNotifier(this.repository) : super(const FeedState());

  // Initial Load
  Future<void> fetchInitial() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      _page = 0;

      final posts = await repository.fetchPosts(
        from: 0,
        to: pageSize - 1,
      );

      _hasMoreData = posts.length == pageSize;

      state = state.copyWith(
        posts: posts,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  // Pagination
  Future<void> fetchMore() async {
    if (state.isLoadingMore || !_hasMoreData) return;

    state = state.copyWith(isLoadingMore: true);

    try {
      _page++;

      final posts = await repository.fetchPosts(
        from: _page * pageSize,
        to: (_page * pageSize) + pageSize - 1,
      );

      _hasMoreData = posts.length == pageSize;

      state = state.copyWith(
        posts: [...state.posts, ...posts],
        isLoadingMore: false,
      );
    } catch (_) {
      state = state.copyWith(isLoadingMore: false);
    }
  }

  // Pull to Refresh
  Future<void> refresh() async {
    await fetchInitial();
  }
}