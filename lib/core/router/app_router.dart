import 'package:flutter_high_performance_feed/core/router/route_names.dart';
import 'package:flutter_high_performance_feed/core/router/route_paths.dart';
import 'package:flutter_high_performance_feed/features/feed/presentation/pages/feed_detail_page.dart';
import 'package:flutter_high_performance_feed/features/feed/presentation/pages/feed_page.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final appRouter = GoRouter(
    initialLocation: RoutePaths.feed,

    routes: [
      GoRoute(
        path: RoutePaths.feed,
        name: RouteNames.feed,
        builder: (context, state) => const FeedPage(),
      ),
      GoRoute(
        path: RoutePaths.postDetail,
        name: RouteNames.postDetail,
        builder: (context, state) {
          final postId = state.pathParameters["id"]!;

          return FeedDetailPage(postId: postId);
        },
      ),
    ],
  );
}
