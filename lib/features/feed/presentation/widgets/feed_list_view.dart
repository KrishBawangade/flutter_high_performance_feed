import 'package:flutter/material.dart';
import 'package:flutter_high_performance_feed/core/constants/app_dimens.dart';
import 'package:flutter_high_performance_feed/features/feed/data/models/post_model.dart';
import 'package:flutter_high_performance_feed/features/feed/presentation/providers/feed_providers.dart';
import 'package:flutter_high_performance_feed/features/feed/presentation/widgets/feed_item_card.dart';
import 'package:flutter_high_performance_feed/features/feed/presentation/widgets/feed_item_shimmer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FeedListView extends ConsumerStatefulWidget {
  final List<PostModel> posts;
  final bool isLoading;
  final bool isLoadingMore;

  const FeedListView({
    super.key,
    required this.posts,
    required this.isLoading,
    required this.isLoadingMore,
  });

  @override
  ConsumerState<FeedListView> createState() => _FeedListViewState();
}

class _FeedListViewState extends ConsumerState<FeedListView> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(feedNotifierProvider.notifier).fetchInitial();
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 400) {
      ref.read(feedNotifierProvider.notifier).fetchMore();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget child;

    // Loading State
    if (widget.posts.isEmpty && widget.isLoading) {
      child = ListView.builder(
        key: const ValueKey('loading'),
        itemCount: 6,
        itemBuilder: (_, __) => const FeedItemShimmer(),
      );
    }
    // Empty State
    else if (widget.posts.isEmpty) {
      child = const Center(
        key: ValueKey('empty'),
        child: Text("No posts available"),
      );
    }
    // Data State
    else {
      child = ListView.builder(
        key: const ValueKey('data'),
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: widget.posts.length + (widget.isLoadingMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index >= widget.posts.length) {
            return const Padding(
              padding: EdgeInsets.all(AppDimens.paddingLg),
              child: Center(child: CircularProgressIndicator()),
            );
          }

          final post = widget.posts[index];
          return FeedItemCard(post: post);
        },
      );
    }

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),

      transitionBuilder: (child, animation) {
        return FadeTransition(opacity: animation, child: child);
      },

      child: child,
    );
  }
}
