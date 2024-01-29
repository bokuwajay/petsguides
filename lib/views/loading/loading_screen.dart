import 'package:flutter/material.dart';
import 'package:petsguides/views/loading/loading_screen_controller.dart';
import 'package:lottie/lottie.dart';

class LoadingScreen {
  factory LoadingScreen() => _shared;
  static final LoadingScreen _shared = LoadingScreen._sharedInstance();
  LoadingScreen._sharedInstance();

  LoadingScreenController? controller;

  void show({required BuildContext context}) {
    controller = showOverlay(context: context);
  }

  void hide() {
    controller?.close();
    controller = null;
  }

  LoadingScreenController showOverlay({required BuildContext context}) {
    final state = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    final overlay = OverlayEntry(builder: (context) {
      return Material(
        color: Colors.black.withAlpha(150),
        child: Center(
          child: Container(
              constraints: BoxConstraints(
                  maxWidth: size.width * 0.4,
                  maxHeight: size.height * 0.4,
                  minWidth: size.width * 0.2),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0)),
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),
                    Lottie.asset('assets/Loading2.json'),
                    const SizedBox(height: 10),
                  ],
                ),
              )),
        ),
      );
    });

    state.insert(overlay);

    return LoadingScreenController(close: () {
      overlay.remove();
      return true;
    });
  }
}
