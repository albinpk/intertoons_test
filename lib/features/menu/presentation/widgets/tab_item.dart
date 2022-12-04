import 'package:flutter/material.dart';

import '../../../../core/models/category_model.dart';

/// Tab with category image and name.
class TabItem extends StatelessWidget {
  const TabItem({
    super.key,
    required this.category,
  });

  final Category category;

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Row(
        children: [
          // Category image.
          Padding(
            padding: const EdgeInsets.all(5).copyWith(right: 10),
            child: ClipOval(
              child: AspectRatio(
                aspectRatio: 1,
                child: ColoredBox(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Image.network(
                      category.imageUrl,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Category name.
          Text(category.name),
        ],
      ),
    );
  }
}
