import 'package:flutter/material.dart';

import '../../../../core/models/category_model.dart';

class MenuTabBarView extends StatelessWidget {
  const MenuTabBarView({
    super.key,
    required this.category,
  });

  final Category category;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        category.name,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}
