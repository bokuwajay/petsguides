import 'package:flutter/foundation.dart';

class ImageDetails {
  late bool isLoaded = false;
  late int cumulativeBytesLoaded = 0;
  // not start from 0 to prevent  cumulativeBytesLoaded/0 =  infinite
  late int expectedTotalBytes = 1;
}

// ValueNotifier imported from flutter/foundation.dart which take ImageDetails
// it notify its listener when value of ImageDetails changes
class ImageNotifier extends ValueNotifier<ImageDetails> {
  late ImageDetails _imageDetails;

  // this instance will take imageDetails passed from outside
  ImageNotifier(ImageDetails imageDetails) : super(imageDetails) {
    // and in here store in _imageDetails
    // then pass to its super class ValueNotifier
    // then notify its listener that: ImageDetails changes
    _imageDetails = imageDetails;
  }

  void changeLoadingState(bool isLoaded) {
    _imageDetails.isLoaded = isLoaded;
    notifyListeners();
  }

  void changeCumulativeBytesLoaded(int cumulativeBytesLoaded) {
    _imageDetails.cumulativeBytesLoaded = cumulativeBytesLoaded;
    notifyListeners();
  }
}
