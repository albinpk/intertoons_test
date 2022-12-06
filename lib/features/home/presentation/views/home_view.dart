import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants.dart';
import '../../../../core/cubit/navigation_cubit.dart';
import '../../../menu/presentation/cubit/menu_view_cubit.dart';
import '../cubit/home_view_cubit.dart';
import '../widgets/additional_banners_list.dart';
import '../widgets/best_sellers_list.dart';
import '../widgets/categories_list.dart';
import '../widgets/featured_products_list.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/slider_banner_list_view.dart';
import '../widgets/view_all_button.dart';
import 'products_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with AutomaticKeepAliveClientMixin<HomeView> {
  final _navigatorKey = GlobalKey<NavigatorState>(debugLabel: 'home-navigator');

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return WillPopScope(
      onWillPop: () async {
        final navigationCubit = context.read<NavigationCubit>();
        if (navigationCubit.state.currentTab == 0) {
          return !await _navigatorKey.currentState!.maybePop();
        }
        navigationCubit.changeTab(0);
        return false;
      },
      child: Navigator(
        key: _navigatorKey,
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/products':
              return MaterialPageRoute(
                builder: (context) => const ProductsView(),
              );

            default:
              return MaterialPageRoute(
                builder: (context) => const _Home(),
              );
          }
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _Home extends StatelessWidget {
  const _Home({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: RefreshIndicator(
        color: primaryColor,
        onRefresh: () async {
          context.read<HomeViewCubit>().refresh();
          context.read<MenuViewCubit>().refresh();
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
                child: Row(
                  children: [
                    Text(
                      'Best sellers',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Spacer(),
                    const ViewAllButton(),
                  ],
                ),
              ),
            ),
            const BestSellersList(),
          ],
        ),
      ),
    );
  }
}
