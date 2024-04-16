import 'package:flutter/material.dart';
import 'package:petsguides/core/util/secure_storage.dart';
import 'package:petsguides/features/market/presentation/widgets/carousel_widget.dart';
import 'package:petsguides/features/market/presentation/widgets/category_widget.dart';
import 'package:petsguides/features/market/presentation/widgets/pets_widget.dart';
import 'package:petsguides/features/market/presentation/widgets/popular_product_widget.dart';
import 'package:petsguides/features/market/presentation/widgets/promotion_widget.dart';
import 'package:petsguides/features/market/presentation/widgets/shop_widget.dart';

class HomeView extends StatelessWidget {
  final bool isSideBarClosed;
  final Function() toggle;

  const HomeView(
      {super.key, required this.isSideBarClosed, required this.toggle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            floating: true,
            centerTitle: true,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(12),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                        onPressed: () {
                          toggle();
                        },
                        icon: const Icon(Icons.menu, size: 36)),
                    const Expanded(
                      child: SizedBox(
                        height: 36,
                        width: 80,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search...',
                            border: InputBorder.none,
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16.0),
                            prefixIcon: Icon(Icons.search, size: 30),
                          ),
                        ),
                      ),
                    ),
                    const Icon(Icons.bookmark_add_outlined, size: 36),
                    IconButton(
                        onPressed: () async {
                          await SecureStorage.deleteSecureData('pgToken');
                          // await SecureStorage.deleteSecureData('FIRST_LAUNCH');
                        },
                        icon: const Icon(Icons.chat_bubble_outline, size: 36)),
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
