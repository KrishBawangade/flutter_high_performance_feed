import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_high_performance_feed/core/constants/app_dimens.dart';
import 'package:flutter_high_performance_feed/core/utils/snackbar_utils.dart';
import 'package:flutter_high_performance_feed/features/feed/data/models/post_model.dart';
import 'package:flutter_high_performance_feed/features/feed/presentation/providers/feed_providers.dart';
import 'package:flutter_high_performance_feed/features/feed/presentation/widgets/download_button.dart';
import 'package:flutter_high_performance_feed/features/feed/presentation/widgets/like_button.dart';
import 'package:flutter_high_performance_feed/features/feed/presentation/widgets/tiered_image.dart';
import 'package:flutter_high_performance_feed/shared/widgets/custom_app_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FeedDetailPage extends ConsumerWidget {
  final String postId;

  const FeedDetailPage({super.key, required this.postId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    ref.listen(feedNotifierProvider.select((state) => state.error), (
      previous,
      next,
    ) {
      if (next != null) {
        SnackBarUtils.showError(context, next);

        ref.read(feedNotifierProvider.notifier).clearError();
      }
    });

    final posts = ref.watch(
      feedNotifierProvider.select((state) => state.posts),
    );

    final post = posts.firstWhereOrNull((element) {
      return element.id == postId;
    });

    if (post == null) {
      return Scaffold(body: Center(child: Text("Post Not Found!")));
    }

    return _FeedDetailView(post: post);
  }
}

class _FeedDetailView extends StatelessWidget {
  final PostModel post;

  const _FeedDetailView({required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Post"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Hero(
              tag: "feed-image-${post.id}",
              child: TieredImage(post: post),
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: AppDimens.md),
                  Padding(
                    padding: const EdgeInsets.all(AppDimens.md),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            LikeButton(postId: post.id,),
                            const SizedBox(width: AppDimens.sm),
                            Text("${post.likeCount}"),
                          ],
                        ),

                        DownloadButton(post: post)
                      ],
                    ),
                  ),
                  // SizedBox(height: AppDimens.xl),
                  // _DownloadButton(post: post),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
