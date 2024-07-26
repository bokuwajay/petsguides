import 'package:flutter/material.dart';
import 'package:petsguides/features/shop/presentation/widgets/carousel_widget.dart';
import 'package:petsguides/features/shop/presentation/widgets/category_widget.dart';
import 'package:petsguides/features/shop/presentation/widgets/pets_widget.dart';
import 'package:petsguides/features/shop/presentation/widgets/popular_product_widget.dart';
import 'package:petsguides/features/shop/presentation/widgets/promotion_widget.dart';
import 'package:petsguides/features/shop/presentation/widgets/shop_widget.dart';

class ShopItemListView extends StatelessWidget {
  final Function() toggle;

  const ShopItemListView({super.key, required this.toggle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: SizedBox.expand(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            toggle();
                          },
                          icon: const Icon(
                            Icons.menu,
                          ),
                        ),
                        const Expanded(
                          child: SizedBox(
                            height: 32,
                            child: TextField(
                              maxLines: 1,
                              decoration: InputDecoration(
                                hintText: 'Search...',
                                prefixIcon: Icon(Icons.search),
                              ),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () async {},
                              icon: const Icon(
                                Icons.map_outlined,
                              ),
                            ),
                            IconButton(
                              onPressed: () async {},
                              icon: const Icon(
                                Icons.bookmark_add_outlined,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: CarouselWidget()),
          const SliverToBoxAdapter(child: PromotionWidget()),
          const SliverToBoxAdapter(child: PetsWidget()),
          const SliverToBoxAdapter(child: CategoryWidget()),
          const SliverToBoxAdapter(child: PopularProductWidget()),
          const SliverToBoxAdapter(child: ShopWidget()),
          const SliverToBoxAdapter(child: SizedBox(height: 80)),
        ],
      ),
    );
  }
}
