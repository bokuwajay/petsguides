import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:petsguides/core/util/overlay/generic_overlay_controller.dart';

class GenericOverlay {
  factory GenericOverlay() => _shared;
  static final GenericOverlay _shared = GenericOverlay._sharedInstance();
  GenericOverlay._sharedInstance();

  GenericOverlayController? controller;

  void show({required BuildContext context, required WidgetBuilder builder}) {
    hide();
    controller = showOverlay(context: context, builder: builder);
  }

  void hide() {
    controller?.close();
    controller = null;
  }

  GenericOverlayController showOverlay({
    required BuildContext context,
    required WidgetBuilder builder,
  }) {
    final state = Overlay.of(context);

    final overlay = OverlayEntry(builder: builder);

    state.insert(overlay);

    return GenericOverlayController(close: () {
      overlay.remove();
      return true;
    });
  }
}
