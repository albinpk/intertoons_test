import 'package:flutter/material.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Text('Search'),
      ),
      body: Center(
        child: Text(
          'Search',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}
