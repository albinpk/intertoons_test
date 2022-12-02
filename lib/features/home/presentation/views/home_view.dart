import 'package:flutter/material.dart';

import '../widgets/slider_banner_page_view.dart';
import '../widgets/best_sellers_list.dart';
import '../widgets/featured_products_list.dart';
import '../widgets/home_app_bar.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: CustomScrollView(
        slivers: [
          // Delivery address
          const HomeAppBar(),

          // Slider banners page view
          SliverToBoxAdapter(
            child: SizedBox(
              width: screenSize.width,
              height: 200,
              child: const SliderBannerPageView(),
            ),
          ),

          // Featured products
          SliverToBoxAdapter(
            child: SizedBox(
              width: screenSize.width,
              height: 150,
              child: const FeaturedProductsList(),
            ),
          ),

          // Additional banners
          SliverToBoxAdapter(
            child: SizedBox(
              width: screenSize.width,
              height: 150,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: ColoredBox(color: Colors.red),
              ),
            ),
          ),

          // Best seller products
          const SliverToBoxAdapter(
            child: Text('Best sellers'),
          ),
          const BestSellersList(),
        ],
      ),
    );
  }
}
