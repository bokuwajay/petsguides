import 'package:flutter/foundation.dart' show immutable;

typedef CloseGenericOverlay = bool Function();

@immutable
class GenericOverlayController {
  final CloseGenericOverlay close;

  const GenericOverlayController({required this.close});
}
