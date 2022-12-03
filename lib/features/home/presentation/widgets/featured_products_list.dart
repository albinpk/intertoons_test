import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../models/featured_product.dart';
import '../cubit/home_view_cubit.dart';

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
          child: Text(
            'Featured',
            style: Theme.of(context).textTheme.titleLarge,
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: AspectRatio(
        aspectRatio: 3 / 2,
        child: featuredProduct == null
            ? ClipRRect(
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
              )
            : Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                clipBehavior: Clip.antiAlias,
                margin: EdgeInsets.zero,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        fit: BoxFit.cover,
                        image: featuredProduct!.imageUrl,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            featuredProduct!.name,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                            maxLines: 1,
                          ),
                          Row(
                            children: [
                              Text(
                                '\$${featuredProduct!.specialPrice}',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                    ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                '\$${featuredProduct!.price}',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                      color: Colors.grey,
                                      decoration: TextDecoration.lineThrough,
                                    ),
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
