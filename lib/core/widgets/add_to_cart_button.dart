import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants.dart';
import '../cubit/cart_cubit.dart';
import '../models/featured_product_model.dart';

class AddToCartButton extends StatelessWidget {
  const AddToCartButton({
    super.key,
    required this.product,
    required this.minimumSize,
  });

  final FeaturedProduct product;

  /// Minimum size for the button.
  final Size minimumSize;

  @override
  Widget build(BuildContext context) {
    final buttonStyle = TextButton.styleFrom(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      minimumSize: minimumSize,
      padding: EdgeInsets.zero,
    );

    final count = context.select(
      (CartCubit bloc) {
        final list = bloc.state.items.where(
          (item) => item.productId == product.id,
        );
        if (list.isEmpty) return 0;
        assert(list.length == 1);
        return list.first.productCount;
      },
    );

    if (count == 0) {
      return TextButton(
        style: buttonStyle,
        onPressed: () => _onAdd(context),
        child: const Text('ADD'),
      );
    }

    return TextButtonTheme(
      data: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: Colors.black87,
          side: const BorderSide(color: Colors.black26),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          minimumSize: Size(minimumSize.width / 3, minimumSize.height),
          padding: EdgeInsets.zero,
        ),
      ),
      child: IconTheme(
        data: const IconThemeData(size: 24),
        child: Row(
          children: [
            TextButton(
              child: const Icon(Icons.remove),
              onPressed: () => _onRemove(context),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                '$count',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            TextButton(
              child: const Icon(Icons.add),
              onPressed: () => _onAdd(context),
            ),
          ],
        ),
      ),
    );
  }

  void _onAdd(BuildContext context) {
    context.read<CartCubit>().addToCart(product);
  }

  _onRemove(BuildContext context) {
    context.read<CartCubit>().removeFromCart(product);
  }
}
