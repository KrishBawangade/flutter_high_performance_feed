import 'package:flutter/material.dart';
import 'package:flutter_high_performance_feed/features/feed/presentation/providers/feed_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LikeButton extends ConsumerWidget {
  final String postId;

  const LikeButton({super.key, required this.postId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final post = ref.watch(
      feedNotifierProvider.select(
        (state) =>
            state.posts.firstWhere((p) => p.id == postId),
      ),
    );

    return IconButton(
      onPressed: () {
        ref.read(feedNotifierProvider.notifier).toggleLike(postId: postId);
      },
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        switchInCurve: Curves.easeOutBack,
        switchOutCurve: Curves.easeIn,
        transitionBuilder: (child, animation) {
          return ScaleTransition(scale: animation, child: child);
        },
        child: Icon(
          post.isLiked ? Icons.favorite : Icons.favorite_outline,
          key: ValueKey(post.isLiked),
          color: post.isLiked ? Colors.red : Colors.grey,
        ),
      ),
    );
  }
}
