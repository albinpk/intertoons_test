import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../../core/constants.dart';
import '../../../../core/models/category_model.dart';
import '../../../../core/models/featured_product_model.dart';
import '../../../home/presentation/cubit/home_view_cubit.dart';
import '../../../home/presentation/widgets/veg_symbol.dart';

class MenuTabBarView extends StatelessWidget {
  const MenuTabBarView({
    super.key,
    required this.category,
  });

  final Category category;

  @override
  Widget build(BuildContext context) {
    final Iterable<FeaturedProduct> products = context.select(
      (HomeViewCubit bloc) => bloc.state.featuredProducts.where(
        (p) => p.categoryId == category.id,
      ),
    );

    if (products.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.inbox, size: 70, color: Colors.black26),
            SizedBox(height: 10),
            Text(
              'No items were found in this category.',
              style: TextStyle(color: Colors.black38),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: products.length,
      itemExtent: 300,
      padding: const EdgeInsets.only(bottom: 30),
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return _ListItem(product: products.elementAt(index));
      },
    );
  }
}

class _ListItem extends StatelessWidget {
  const _ListItem({
    Key? key,
    required this.product,
  }) : super(key: key);

  final FeaturedProduct product;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.all(10).copyWith(bottom: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Product image
          Expanded(
            child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              fit: BoxFit.cover,
              image: product.imageUrl,
            ),
          ),

          // Product details
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    VegSymbol(isVeg: product.isVeg),
                    const SizedBox(width: 10),

                    // Product name
                    Expanded(
                      child: Text(
                        product.name,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    // Product price
                    Expanded(
                      child: _buildPriceSection(Theme.of(context).textTheme),
                    ),

                    // ADD button
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: primaryColor,
                        foregroundColor: Colors.white,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        minimumSize: const Size(70, 20),
                      ),
                      onPressed: () {},
                      child: const Text('ADD'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Build price widget.
  Widget _buildPriceSection(TextTheme textTheme) {
    final mainStyle = textTheme.titleMedium!.copyWith(
      fontWeight: FontWeight.bold,
      color: primaryColor,
    );

    // Return the actual price if there is no discount.
    if (!product.hasDiscount) {
      return Text('\$${product.price}', style: mainStyle);
    }

    // If the product has a discount, display both the discounted and the actual price.
    return Row(
      children: [
        Text('\$${product.specialPrice}', style: mainStyle),
        const SizedBox(width: 10),

        // Actual price
        Text(
          '\$${product.price}',
          style: textTheme.titleSmall!.copyWith(
            color: Colors.grey,
            decoration: TextDecoration.lineThrough,
          ),
        ),
      ],
    );
  }
}
