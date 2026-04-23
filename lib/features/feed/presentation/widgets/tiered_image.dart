import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_high_performance_feed/features/feed/data/models/post_model.dart';

class TieredImage extends StatefulWidget {
  final PostModel post;

  const TieredImage({super.key, required this.post});

  @override
  State<TieredImage> createState() => _TieredImageState();
}

class _TieredImageState extends State<TieredImage> {
  double _opacity = 0;

  bool _isLoaded = false;
  ImageStream? _imageStream;
  ImageStreamListener? _imageStreamListener;

  @override
  void initState() {
    super.initState();

    _loadImage();
  }

  void _loadImage() {
    final imageProvider = NetworkImage(widget.post.mediaMobileUrl);

    final stream = imageProvider.resolve(ImageConfiguration());

    _imageStreamListener = ImageStreamListener(
      (image, synchronousCall) {
        if (mounted && !_isLoaded) {
          setState(() {
            _isLoaded = true;
          });
        }
      },

      onError: (_, _) {
        // fail silently if any error occurres (keed the thumbnail)
      },
    );

    stream.addListener(_imageStreamListener!);
    _imageStream = stream;
  }

  @override
  void dispose() {
    if (_imageStream != null && _imageStreamListener != null) {
      _imageStream?.removeListener(_imageStreamListener!);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        CachedNetworkImage(
          imageUrl: widget.post.mediaThumbUrl,
          memCacheWidth: 300,
          fit: BoxFit.cover,
        ),

        AnimatedOpacity(
          opacity: _isLoaded ? 1 : 0,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeIn,
          child: _isLoaded
              ? Image.network(
                  widget.post.mediaMobileUrl,
                  fit: BoxFit.cover,
                  cacheWidth: 1080,
                )
              : const SizedBox.shrink(),
    
        ),
      ],
    );
  }
}
