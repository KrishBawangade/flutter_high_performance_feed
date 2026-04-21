
import 'package:flutter_high_performance_feed/features/feed/data/datasource/feed_remote_datasource.dart';
import 'package:flutter_high_performance_feed/features/feed/data/repository/feed_repository.dart';
import 'package:flutter_high_performance_feed/features/feed/presentation/notifier/feed_notifier.dart';
import 'package:flutter_high_performance_feed/features/feed/presentation/notifier/feed_state.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final supabaseClient = Provider<SupabaseClient>((ref) {
    return Supabase.instance.client;
  });

  final datasource = Provider<FeedRemoteDatasource>((ref) {
    return FeedRemoteDatasource(ref.read(supabaseClient));
  });

  
  final repository = Provider<FeedRepository>((ref) {
    return FeedRepository(ref.read(datasource));
  });

  
  final notifier =
      StateNotifierProvider<FeedNotifier, FeedState>((ref) {
    return FeedNotifier(ref.read(repository));
  });
