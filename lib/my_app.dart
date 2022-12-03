import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/home/presentation/views/home_view.dart';
import 'features/home/repositories/home_repository.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => HomeRepository(),
      child: const MaterialApp(
        title: 'Intertoons Test App',
        home: _HomePage(),
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
    _NavItem(label: 'Home', view: HomeView()),
    _NavItem(label: 'Menu', view: Center(child: Text('MenuView'))),
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
    return Scaffold(
      // Using PageView to avoid creating all widgets at the start.
      // And preserving state on each page by using the AutomaticKeepAliveClientMixin.
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: _items.map((e) => e.view).toList(),
      ),

      bottomNavigationBar: BottomNavigationBar(
        unselectedLabelStyle: Theme.of(context).textTheme.titleMedium,
        currentIndex: _currentIndex,
        selectedLabelStyle: Theme.of(context).textTheme.titleMedium,
        onTap: _onPageChange,
        items: _items
            .map(
              (e) => BottomNavigationBarItem(
                icon: const SizedBox.shrink(),
                label: e.label,
              ),
            )
            .toList(),
      ),
    );
  }

  void _onPageChange(int i) {
    // Calling setState to update bottom navigation bar
    setState(() => _currentIndex = i);
    // Change page
    _pageController.animateToPage(
      i,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeInOutCubic,
    );
  }
}

/// Just a model to group tab label and tab view.
class _NavItem {
  const _NavItem({
    required this.label,
    required this.view,
  });

  /// Tab label
  final String label;

  /// Tab view.
  final Widget view;
}
