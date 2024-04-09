import 'package:flutter/material.dart';
import 'package:petsguides/features/market/presentation/widgets/carousel_widget.dart';
import 'package:petsguides/features/market/presentation/widgets/category_widget.dart';
import 'package:petsguides/features/market/presentation/widgets/pets_widget.dart';
import 'package:petsguides/features/market/presentation/widgets/popular_product_widget.dart';
import 'package:petsguides/features/market/presentation/widgets/promotion_widget.dart';
import 'package:petsguides/features/market/presentation/widgets/shop_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.blue,
            floating: true,
            title: const Text("Pets Guides"),
            centerTitle: true,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(56),
              child: Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.search),
                    Expanded(child: Text("Search...."))
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
