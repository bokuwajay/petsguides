import 'package:flutter/material.dart';
import 'package:petsguides/components/bottomNavigationBar/navigation_bar.dart';
import 'package:petsguides/components/sidebar/side_bar_btn.dart';
import 'package:petsguides/views/google_map.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        extendBody: true,
        body: Stack(
          children: [
            const GoogleMapView(),
            SideBarBtn(
              press: () {},
            ),
          ],
        ),
        bottomNavigationBar: const BottomNavBar());
  }
}
