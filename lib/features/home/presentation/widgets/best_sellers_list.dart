import 'package:flutter/material.dart';

/// Best seller products.
class BestSellersList extends StatelessWidget {
  const BestSellersList({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: 10,
        (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [
                SizedBox.square(
                  dimension: 80,
                  child: ColoredBox(color: Colors.green),
                ),
                SizedBox(width: 10),
                Text('Item'),
              ],
            ),
          );
        },
      ),
    );
  }
}
