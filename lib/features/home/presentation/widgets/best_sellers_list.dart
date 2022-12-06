import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/home_view_cubit.dart';
import 'product_tile.dart';

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
              return ProductTile(
                product: isLoading ? null : state.bestSellerProducts[index],
              );
            },
          ),
        );
      },
    );
  }
}
