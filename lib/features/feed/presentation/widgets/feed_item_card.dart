import 'package:flutter/material.dart';
import 'package:flutter_high_performance_feed/core/constants/app_dimens.dart';
import 'package:flutter_high_performance_feed/features/feed/presentation/widgets/like_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/post_model.dart';

class FeedItemCard extends ConsumerWidget {
  final PostModel post;
  final ImageProvider imageProvider;

  const FeedItemCard({
    super.key,
    required this.post,
    required this.imageProvider,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppDimens.md,
        vertical: AppDimens.sm,
      ),

      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(AppDimens.radiusLg),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(80),
            blurRadius: 20,
            spreadRadius: 0,
            offset: const Offset(0, 20),
          ),
        ],
        border: Border.all(color: colorScheme.outline.withAlpha(40), width: 1),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(AppDimens.radiusLg),
            ),
            child: Hero(
              tag: "feed-image-${post.id}",
              child: RepaintBoundary(
                child: _PostImage(post: post, imageProvider: imageProvider),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppDimens.md),
            child: Row(
              children: [
                RepaintBoundary(child: LikeButton(postId: post.id)),
                const SizedBox(width: AppDimens.sm),
                Text("${post.likeCount}"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PostImage extends StatelessWidget {
  final PostModel post;
  final ImageProvider imageProvider;

  const _PostImage({required this.post, required this.imageProvider});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Image(image: imageProvider, fit: BoxFit.cover),
    );
  }
}
