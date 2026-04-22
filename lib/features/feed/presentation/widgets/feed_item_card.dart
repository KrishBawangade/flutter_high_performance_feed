import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_high_performance_feed/core/constants/app_dimens.dart';

import '../../data/models/post_model.dart';

class FeedItemCard extends StatelessWidget {
  final PostModel post;

  const FeedItemCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return RepaintBoundary(
      child: Container(
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
              blurRadius: 40, 
              spreadRadius: 1,
              offset: const Offset(0, 20),
            ),
          ],
          border: Border.all(
            color: colorScheme.outline.withAlpha(40),
            width: 1,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppDimens.radiusLg),
          child: Column(
            children: [
              _PostImage(post: post),
              Padding(
                padding: const EdgeInsets.all(AppDimens.md),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.favorite_border_outlined),
                    ),
                    const SizedBox(width: AppDimens.sm),
                    Text("${post.likeCount}"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PostImage extends StatelessWidget {
  final PostModel post;

  const _PostImage({required this.post});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return AspectRatio(
      aspectRatio: 1,
      child: CachedNetworkImage(
        memCacheWidth: width.toInt(),
        imageUrl: post.mediaThumbUrl,
        fit: BoxFit.cover,
        placeholder: (_, _) {
          return const SizedBox(child: Icon(Icons.image));
        },

        errorWidget: (context, url, error) {
          return const Icon(Icons.error);
        },
      ),
    );
  }
}
