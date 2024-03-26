import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petsguides/features/market/presentation/widgets/sidebar/info_card.dart';
import 'package:petsguides/features/market/presentation/widgets/sidebar/side_bar_title.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 288,
        height: double.infinity,
        color: const Color(0xFF17203A),
        child: SafeArea(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const InfoCard(
              name: 'Jay',
              profession: 'developer',
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24, top: 32, bottom: 16),
              child: Text(
                "Browse".toUpperCase(),
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Colors.white70),
              ),
            ),
            SideBarTitle(
              press: () {},
              isActive: false,
            ),
            SideBarTitle(
              press: () {},
              isActive: false,
            ),
            SideBarTitle(
              press: () {},
              isActive: false,
            ),
            SideBarTitle(
              press: () {},
              isActive: false,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24, top: 32, bottom: 16),
              child: Text(
                "Browse".toUpperCase(),
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Colors.white70),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}