import 'package:flutter/material.dart';
import 'package:flutter_high_performance_feed/shared/widgets/custom_app_bar.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Feed",),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: const Center(child: Text("Feed Page")),
    );
  }
}
