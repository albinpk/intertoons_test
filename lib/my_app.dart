import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/constants.dart';
import 'core/cubit/cart_cubit.dart';
import 'core/cubit/navigation_cubit.dart';
import 'core/cubit/products_cubit.dart';
import 'core/repositories/products_repository.dart';
import 'core/widgets/bottom_cart_bar.dart';
import 'features/account/presentation/views/account_view.dart';
import 'features/home/presentation/cubit/home_view_cubit.dart';
import 'features/home/presentation/views/home_view.dart';
import 'features/home/repositories/home_repository.dart';
import 'features/menu/presentation/cubit/menu_view_cubit.dart';
import 'features/menu/presentation/views/menu_view.dart';
import 'features/menu/repositories/menu_repository.dart';
import 'features/search/presentation/views/search_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => ProductsRepository()),
        RepositoryProvider(create: (context) => HomeRepository()),
        RepositoryProvider(create: (context) => MenuRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => NavigationCubit()),
          BlocProvider(
            create: (context) => ProductsCubit(
              productsRepository: context.read<ProductsRepository>(),
            ),
          ),
          BlocProvider(create: (context) => CartCubit()),
          BlocProvider(
            create: (context) => HomeViewCubit(
              homeRepository: context.read<HomeRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => MenuViewCubit(
              menuRepository: context.read<MenuRepository>(),
            ),
          ),
        ],
        child: const MaterialApp(
          title: 'Intertoons Test App',
          home: _HomePage(),
        ),
      ),
    );
  }
}

class _HomePage extends StatefulWidget {
  const _HomePage({Key? key}) : super(key: key);

  @override
  State<_HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<_HomePage> {
  final _pageController = PageController();

  /// Bottom navigation items.
  static const Set<_NavItem> _items = {
    _NavItem(label: 'Home', iconData: Icons.home, view: HomeView()),
    _NavItem(label: 'Menu', iconData: Icons.menu, view: MenuView()),
    _NavItem(label: 'Search', iconData: Icons.search, view: SearchView()),
    _NavItem(label: 'Account', iconData: Icons.person, view: AccountView()),
  };

  /// Currently select tab index.
  int _currentIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NavigationCubit, NavigationState>(
      listenWhen: (previous, current) {
        return previous.currentTab != current.currentTab;
      },
      listener: _navigationBlocListener,
      child: Scaffold(
        // Using PageView to avoid creating all widgets at the start.
        // And preserving state on each page by using the AutomaticKeepAliveClientMixin.
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: _items.map((e) => e.view).toList(),
        ),

        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const BottomCartBar(),
            BottomNavigationBar(
              currentIndex: _currentIndex,
              selectedItemColor: primaryColor,
              selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
              unselectedFontSize: 14,
              onTap: (i) => context.read<NavigationCubit>().changeTab(i),
              type: BottomNavigationBarType.fixed,
              items: _items
                  .map(
                    (e) => BottomNavigationBarItem(
                      icon: Icon(e.iconData),
                      label: e.label,
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  void _navigationBlocListener(BuildContext context, NavigationState state) {
    setState(() {
      // Calling setState to update bottom navigation bar
      _currentIndex = state.currentTab;
      // Change page
      _pageController.animateToPage(
        state.currentTab,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeInOutCubic,
      );
    });
  }
}

/// Just a model to group tab label and tab view.
class _NavItem {
  const _NavItem({
    required this.iconData,
    required this.label,
    required this.view,
  });

  /// Tab icon.
  final IconData iconData;

  /// Tab label.
  final String label;

  /// Tab view.
  final Widget view;
}
