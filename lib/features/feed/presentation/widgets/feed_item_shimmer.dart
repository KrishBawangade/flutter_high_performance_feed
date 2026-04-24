import 'package:flutter/material.dart';
import 'package:flutter_high_performance_feed/core/constants/app_dimens.dart';
import 'package:shimmer/shimmer.dart';

class FeedItemShimmer extends StatelessWidget {
  const FeedItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsetsGeometry.symmetric(
        horizontal: AppDimens.md,
        vertical: AppDimens.sm,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppDimens.radiusLg),

        child: Shimmer.fromColors(
          baseColor: Colors.grey.shade600,
          highlightColor: Colors.grey.shade100,
          child: Container(
            decoration: BoxDecoration(
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
                color: colorScheme.outline.withAlpha(60),
                width: 1,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppDimens.radiusLg),
              child: Column(
                children: [
                  const AspectRatio(
                    aspectRatio: 1,
                    child: Icon(Icons.image, size: 60),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(AppDimens.md),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.white,
                          ),
                          height: 20,
                          width: 80,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
