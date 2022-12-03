import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/home_view_cubit.dart';
import '../widgets/additional_banners_list.dart';
import '../widgets/best_sellers_list.dart';
import '../widgets/categories_list.dart';
import '../widgets/featured_products_list.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/slider_banner_list_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with AutomaticKeepAliveClientMixin<HomeView> {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    final screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          context.read<HomeViewCubit>().refresh();
        },
        child: CustomScrollView(
          slivers: [
            // Delivery address
            const HomeAppBar(),

            // Slider banners page view
            SliverToBoxAdapter(
              child: SizedBox(
                width: screenSize.width,
                height: 150,
                child: const SliderBannerListView(),
              ),
            ),

            // Explore menu
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 200,
                child: CategoriesList(),
              ),
            ),

            // Featured products
            SliverToBoxAdapter(
              child: SizedBox(
                width: screenSize.width,
                height: 230,
                child: const FeaturedProductsList(),
              ),
            ),

            // Additional banners
            const AdditionalBannersList(),

            // Best seller products
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 15,
                ),
                child: Text(
                  'Best sellers',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
            const BestSellersList(),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
