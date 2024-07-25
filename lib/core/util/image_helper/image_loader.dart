import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:petsguides/core/util/image_helper/image_notifier.dart';

class ImageLoader extends StatefulWidget {
  final String imageURL;
  final double parentWidgetHeight;
  final double parentWidgetWidth;
  const ImageLoader({super.key, required this.imageURL, required this.parentWidgetHeight, required this.parentWidgetWidth});

  @override
  State<ImageLoader> createState() => _ImageLoaderState();
}

// _ImageLoaderState manages state of ImageLoader widget
// it uses TickerProviderStateMixin to provide vsync for animation
class _ImageLoaderState extends State<ImageLoader> with TickerProviderStateMixin {
  // control animation timing
  late AnimationController _controller;
  // define animation effect, in below use-case transit from height of 600 to 400
  late Animation<double> _animation;

  late ImageStream _imageStream;
  late ImageInfo _imageInfo;

  late ImageDetails _imageDetails;
  late ImageNotifier _imageNotifier;

  @override
  void initState() {
    _imageDetails = ImageDetails();
    _imageNotifier = ImageNotifier(_imageDetails);

    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 700));
    _animation = Tween<double>(begin: widget.parentWidgetWidth * 1.2, end: widget.parentWidgetHeight)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    super.initState();

    _imageStream = NetworkImage(widget.imageURL).resolve(const ImageConfiguration());

    _imageStream.addListener(ImageStreamListener(
      (image, synchronousCall) {
        _imageInfo = image;
        _imageNotifier.changeLoadingState(true);
        _controller.forward();
      },
      onChunk: (event) {
        _imageNotifier.changeCumulativeBytesLoaded(event.expectedTotalBytes!);
        _imageNotifier.changeCumulativeBytesLoaded(event.cumulativeBytesLoaded);
      },
    ));
  }

  @override
  void dispose() {
    _imageInfo.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _imageNotifier,
      builder: (context, ImageDetails value, child) {
        return !value.isLoaded
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Center(
                child: AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return OverflowBox(
                      minHeight: widget.parentWidgetHeight,
                      minWidth: widget.parentWidgetWidth,
                      maxHeight: widget.parentWidgetHeight * 2,
                      maxWidth: widget.parentWidgetWidth * 2,
                      child: SizedBox(
                          height: _animation.value,
                          width: _animation.value,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                image: DecorationImage(image: NetworkImage(widget.imageURL), fit: BoxFit.cover),
                              ),
                            ),
                          )),
                    );
                  },
                  child: RawImage(
                    image: _imageInfo.image,
                    fit: BoxFit.cover,
                  ),
                ),
              );
      },
    );
  }
}
