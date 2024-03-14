import 'package:flutter/material.dart';
import 'package:petsguides/navigation_bar.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
