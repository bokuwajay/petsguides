import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:petsguides/features/market/presentation/widgets/product_model.dart';

class PopularProductWidget extends StatelessWidget {
  const PopularProductWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          child: Text(
            "Popular Product",
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        SizedBox(
          height: 320,
          width: MediaQuery.of(context).size.width,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
            itemCount: products.length,
            separatorBuilder: (_, __) {
              return const SizedBox(
                width: 16,
              );
            },
            itemBuilder: (context, index) {
              return Container(
                width: 220,
                height: 320,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.grey,
                          blurRadius: 1,
                          spreadRadius: 1,
                          offset: Offset(1, 1))
                    ]),
                child: Column(
                  children: [
                    Container(
                      width: 220,
                      height: 180,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                        image: DecorationImage(
                            image: AssetImage(products[index].image),
                            fit: BoxFit.cover),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: products[index].brand,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium),
                                  TextSpan(
                                      text: " ${products[index].name}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall)
                                ]),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.star_rounded),
                                      Text(
                                        products[index].rating,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Icon(Icons.wallet),
                                      Text(
                                        products[index].price,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
