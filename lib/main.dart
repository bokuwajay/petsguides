import 'package:flutter/material.dart';
import 'package:petsguides/navigation_bar.dart';
import 'package:petsguides/views/google_map.dart';

void main() {
  runApp(MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      // home: const HomePage(),
      home: const GoogleMapView()));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
