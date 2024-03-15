import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:petsguides/components/bottomNavigationBar/navigation_bar.dart';
import 'package:petsguides/components/sidebar/side_bar.dart';
import 'package:petsguides/components/sidebar/side_bar_btn.dart';
import 'package:petsguides/views/google_map.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView>
    with SingleTickerProviderStateMixin {
  bool isSideBarClosed = true;

  late AnimationController _animationController;
  late Animation<double> animation;
  late Animation<double> scalAnimation;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200))
      ..addListener(() {
        setState(() {});
      });

    animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.fastOutSlowIn,
      ),
    );

    scalAnimation = Tween<double>(begin: 1, end: 0.8).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.fastOutSlowIn,
      ),
    );

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HexColor('#192038'),
        resizeToAvoidBottomInset: false,
        extendBody: true,
        body: Stack(
          children: [
            AnimatedPositioned(
                duration: const Duration(milliseconds: 200),
                curve: Curves.fastOutSlowIn,
                width: 288,
                left: isSideBarClosed ? -288 : 0,
                height: MediaQuery.of(context).size.height,
                child: const SideBar()),
            Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(animation.value - 30 * animation.value * pi / 180),
              child: Transform.translate(
                  offset: Offset(animation.value * 265, 0),
                  child: Transform.scale(
                    scale: scalAnimation.value,
                    child: const ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(24)),
                        child: GoogleMapView()),
                  )),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              curve: Curves.fastOutSlowIn,
              left: isSideBarClosed ? 0 : 220,
              top: 16,
              child: SideBarBtn(
                press: () {
                  if (isSideBarClosed) {
                    _animationController.forward();
                  } else {
                    _animationController.reverse();
                  }
                  setState(() {
                    isSideBarClosed = !isSideBarClosed;
                  });
                },
              ),
            ),
          ],
        ),
        bottomNavigationBar: Transform.translate(
            offset: Offset(0, 100 * animation.value),
            child: const BottomNavBar()));
  }
}
