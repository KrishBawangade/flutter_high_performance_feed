import 'package:flutter/material.dart';
import 'package:flutter_high_performance_feed/features/feed/presentation/providers/feed_providers.dart';
import 'package:flutter_high_performance_feed/features/feed/presentation/widgets/feed_list_view.dart';
import 'package:flutter_high_performance_feed/shared/widgets/custom_app_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FeedPage extends ConsumerWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(
      feedNotifierProvider.select((state) => state.posts),
    );
    final isLoading = ref.watch(
      feedNotifierProvider.select((state) => state.isLoading),
    );
    final isLoadingMore = ref.watch(
      feedNotifierProvider.select((state) => state.isLoadingMore),
    );

    return Scaffold(
      appBar: const CustomAppBar(title: "Feed"),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.read(feedNotifierProvider.notifier).refresh();
        },
        child: FeedListView(
          posts: posts,
          isLoading: isLoading,
          isLoadingMore: isLoadingMore,
        ),
      ),
    );
  }
}
