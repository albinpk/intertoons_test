import 'package:flutter/material.dart';

import '../../../../core/constants.dart';
import '../../../../core/models/product_model.dart';

/// The product price section.
///
/// If the [product] has a special price, it appears first,
/// followed by the regular price in line-through style.
class PriceSection extends StatelessWidget {
  const PriceSection({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    if (product.specialPrice == null) {
      return Text(
        '\$${product.price}',
        style: textTheme.titleSmall!.copyWith(
          color: primaryColor,
          fontWeight: FontWeight.bold,
        ),
      );
    }

    return Row(
      children: [
        Text(
          '\$${product.specialPrice!}',
          style: textTheme.titleSmall!.copyWith(
            color: primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          '\$${product.price}',
          style: textTheme.titleSmall!.copyWith(
            color: Colors.grey,
            fontSize: 13,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.lineThrough,
          ),
        ),
      ],
    );
  }
}
