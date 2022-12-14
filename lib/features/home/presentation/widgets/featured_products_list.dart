import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../../core/models/featured_product_model.dart';
import '../../../../core/widgets/add_to_cart_button.dart';
import '../cubit/home_view_cubit.dart';
import 'price_section.dart';
import 'veg_symbol.dart';
import 'view_all_button.dart';

/// Featured products list view.
class FeaturedProductsList extends StatelessWidget {
  const FeaturedProductsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10).copyWith(top: 15),
          child: Row(
            children: [
              Text(
                'Featured',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Spacer(),
              const ViewAllButton(),
            ],
          ),
        ),
        Expanded(
          child: BlocBuilder<HomeViewCubit, HomeViewState>(
            builder: (context, state) {
              if (state.status == HomeViewStatus.failure) {
                return Center(
                  child: Text(
                    'An error has occurred.',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                );
              }

              final isLoading = state.status == HomeViewStatus.loading ||
                  state.status == HomeViewStatus.initial;

              return ListView.builder(
                itemCount: isLoading ? 2 : state.featuredProducts.length,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 5),
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return _ListItem(
                    featuredProduct:
                        isLoading ? null : state.featuredProducts[index],
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class _ListItem extends StatelessWidget {
  const _ListItem({
    Key? key,
    required this.featuredProduct,
  }) : super(key: key);

  final FeaturedProduct? featuredProduct;

  static final _loading = ClipRRect(
    borderRadius: BorderRadius.circular(8),
    child: const ColoredBox(
      color: Colors.black12,
      child: Center(
        child: CircularProgressIndicator(
          color: Colors.grey,
          strokeWidth: 2,
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(5),
      child: AspectRatio(
        aspectRatio: 3 / 2,
        child: featuredProduct == null
            ? _loading
            : Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                clipBehavior: Clip.antiAlias,
                margin: EdgeInsets.zero,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Product image
                    Expanded(
                      child: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        fit: BoxFit.cover,
                        image: featuredProduct!.imageUrl,
                      ),
                    ),

                    // Product details
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Is veg, product name, variations count
                          Row(
                            children: [
                              VegSymbol(isVeg: featuredProduct!.isVeg),
                              const SizedBox(width: 8),

                              // Product name
                              Expanded(
                                child: Text(
                                  featuredProduct!.name,
                                  style: textTheme.titleMedium!.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),

                              // Product variations count
                              if (featuredProduct!.variations?.isNotEmpty ??
                                  false)
                                Text(
                                  '+${featuredProduct!.variations!.length}',
                                  style: const TextStyle(color: Colors.green),
                                ),
                            ],
                          ),
                          const SizedBox(height: 5),

                          // Product price and ADD button
                          Row(
                            children: [
                              // Price section
                              PriceSection(product: featuredProduct!),
                              const Spacer(),

                              // Add button
                              AddToCartButton(
                                product: featuredProduct!,
                                minimumSize: const Size(50, 25),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
