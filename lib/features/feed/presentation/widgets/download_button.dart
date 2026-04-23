import 'package:flutter/material.dart';
import 'package:flutter_high_performance_feed/core/constants/app_dimens.dart';
import 'package:flutter_high_performance_feed/core/utils/snackbar_utils.dart';
import 'package:flutter_high_performance_feed/features/feed/data/models/post_model.dart';

class DownloadButton extends StatefulWidget {
  final PostModel post;

  const DownloadButton({super.key, required this.post});

  @override
  State<DownloadButton> createState() => _DownloadButtonState();
}

class _DownloadButtonState extends State<DownloadButton> {
  bool _isLoading = false;

  Future<void> _download() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      await precacheImage(NetworkImage(widget.post.mediaRawUrl), context);

      if (mounted) {
        SnackBarUtils.showSuccess(context, "High-Res image loaded");
      }
    } catch (_) {
      if (mounted) {
        SnackBarUtils.showError(context, "Failed to load the image");
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimens.radiusMd),
          side: BorderSide(color: colorScheme.outline.withAlpha(40)),
        ),
      ),
      onPressed: _isLoading ? null : _download,
      icon: _isLoading
          ? SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : Icon(Icons.download),
      label: Text(_isLoading ? "Loading..." : "Download High-Res"),
    );
  }
}
