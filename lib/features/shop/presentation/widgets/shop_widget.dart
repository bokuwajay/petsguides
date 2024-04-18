import 'package:flutter/material.dart';

class ShopWidget extends StatelessWidget {
  const ShopWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text(
              "Looking for a new pet ?",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          const SizedBox(
            height: 100,
            child: Image(
              image: AssetImage('assets/pets/puppy_shop.png'),
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          const SizedBox(
            height: 100,
            child: Image(
              image: AssetImage('assets/pets/kitten_shop.png'),
              fit: BoxFit.cover,
            ),
          )
        ],
      ),
    );
  }
}
