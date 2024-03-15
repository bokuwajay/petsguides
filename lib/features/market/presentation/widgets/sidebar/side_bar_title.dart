import 'package:flutter/material.dart';

class SideBarTitle extends StatelessWidget {
  const SideBarTitle({
    super.key,
    required this.isActive,
    required this.press,
  });

  final VoidCallback press;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 24),
          child: Divider(
            color: Colors.white24,
            height: 1,
          ),
        ),
        Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.fastOutSlowIn,
              height: 56,
              width: isActive ? 288 : 0,
              left: 0,
              child: Container(
                decoration: const BoxDecoration(
                    color: Color(0xFF6792FF),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
            ),
            ListTile(
              onTap: press,
              leading: const SizedBox(
                height: 34,
                width: 34,
                child: Icon(Icons.accessible_rounded),
              ),
              title: const Text("Home", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ],
    );
  }
}
