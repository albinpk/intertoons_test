import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../../core/constants.dart';
import '../../../../core/models/best_seller_product_model.dart';
import '../../../../core/widgets/add_to_cart_button.dart';
import '../cubit/home_view_cubit.dart';
import 'veg_symbol.dart';

/// Best seller products.
class BestSellersList extends StatelessWidget {
  const BestSellersList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeViewCubit, HomeViewState>(
      builder: (context, state) {
        if (state.status == HomeViewStatus.failure) {
          return SliverToBoxAdapter(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0).copyWith(bottom: 30),
                child: Text(
                  'An error has occurred.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ),
          );
        }

        final isLoading = state.status == HomeViewStatus.loading ||
            state.status == HomeViewStatus.initial;

        return SliverFixedExtentList(
          itemExtent: 90,
          delegate: SliverChildBuilderDelegate(
            childCount: isLoading ? 3 : state.bestSellerProducts.length,
            (context, index) {
              return _ListItem(
                product: isLoading ? null : state.bestSellerProducts[index],
              );
            },
          ),
        );
      },
    );
  }
}

class _ListItem extends StatelessWidget {
  const _ListItem({
    Key? key,
    required this.product,
  }) : super(key: key);

  final BestSellerProduct? product;

  static final text = ClipRRect(
    borderRadius: BorderRadius.circular(8),
    child: const ColoredBox(color: Colors.black12),
  );

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(10).copyWith(top: 0),
      child: product == null
          ? text
          : Row(
              children: [
                // Product image
                SizedBox(
                  width: 100,
                  height: 80,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: product!.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // const SizedBox(width: 10),

                // Product details
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(5).copyWith(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            VegSymbol(isVeg: product!.isVeg),
                            const SizedBox(width: 8),

                            // Product name
                            Expanded(
                              child: Text(
                                product!.name,
                                style: textTheme.titleMedium!.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),

                        // Product description
                        Expanded(
                          child: Text(
                            product!.description,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                        // ADD button and price
                        Row(
                          children: [
                            AddToCartButton(
                              product: product!,
                              minimumSize: const Size(50, 25),
                            ),
                            const SizedBox(width: 10),

                            // Product price
                            Text(
                              '\$${product!.price}',
                              style: textTheme.titleSmall!.copyWith(
                                color: primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
