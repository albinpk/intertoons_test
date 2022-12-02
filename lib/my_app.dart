import 'package:flutter/material.dart';

import 'features/home/presentation/views/home_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Intertoons Test App',
      home: _HomePage(),
    );
  }
}

class _HomePage extends StatefulWidget {
  const _HomePage({Key? key}) : super(key: key);

  @override
  State<_HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<_HomePage> {
  /// Bottom navigation items.
  static const Set<_NavItem> _items = {
    _NavItem(label: 'Home', view: HomeView()),
    _NavItem(label: 'Menu', view: Center(child: Text('MenuView'))),
  };

  /// Currently select tab index.
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _items.elementAt(_currentIndex).view,
      bottomNavigationBar: BottomNavigationBar(
        unselectedLabelStyle: Theme.of(context).textTheme.titleMedium,
        currentIndex: _currentIndex,
        selectedLabelStyle: Theme.of(context).textTheme.titleMedium,
        onTap: (i) => setState(() => _currentIndex = i),
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