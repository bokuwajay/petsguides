import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      key: _bottomNavigationKey,
      index: 0,
      height: 75.0,
      color: MediaQuery.of(context).platformBrightness == Brightness.light
          ? Colors.white
          : Colors.black,
      items: const <Widget>[
        Icon(Icons.perm_identity, size: 40),
        Icon(Icons.groups_2_outlined, size: 40),
        Icon(Icons.shopping_cart_outlined, size: 40),
        Icon(Icons.map_outlined, size: 40),
        Icon(Icons.message_outlined, size: 40),
      ],
      buttonBackgroundColor:
          MediaQuery.of(context).platformBrightness == Brightness.light
              ? Colors.white
              : Colors.black,
      backgroundColor: Colors.transparent,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 600),
    );
  }
}
