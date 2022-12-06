import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/cubit/products_cubit.dart';
import '../widgets/product_tile.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Text('Products'),
      ),
      body: BlocBuilder<ProductsCubit, ProductsState>(
        builder: (context, state) {
          if (state.status == ProductsStatus.failure) {
            return const Center(child: Text('An error has occurred!'));
          }

          final isLoading = state.status == ProductsStatus.loading ||
              state.status == ProductsStatus.initial;

          return ListView.builder(
            itemCount: isLoading ? 3 : state.products.length,
            itemExtent: 90,
            padding: const EdgeInsets.only(bottom: 30, top: 10),
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return ProductTile(
                product: isLoading ? null : state.products[index],
              );
            },
          );
        },
      ),
    );
  }
}
