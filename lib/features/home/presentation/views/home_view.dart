import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/home_repository.dart';
import '../cubit/home_view_cubit.dart';
import '../widgets/best_sellers_list.dart';
import '../widgets/featured_products_list.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/slider_banner_list_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return BlocProvider<HomeViewCubit>(
      create: (context) => HomeViewCubit(
        homeRepository: context.read<HomeRepository>(),
      ),
      child: Builder(
        builder: (context) {
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

                  // Featured products
                  SliverToBoxAdapter(
                    child: SizedBox(
                      width: screenSize.width,
                      height: 230,
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
            ),
          );
        },
      ),
    );
  }
}
