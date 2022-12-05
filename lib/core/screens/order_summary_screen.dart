import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../features/home/presentation/cubit/home_view_cubit.dart';
import '../constants.dart';
import '../cubit/cart_cubit.dart';
import '../models/cart_item_model.dart';
import '../models/featured_product_model.dart';
import '../widgets/add_to_cart_button.dart';

class OrderSummaryScreen extends StatelessWidget {
  const OrderSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Text('Order Summary'),
      ),
      body: BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {
          // Pop the screen when the cart is empty
          if (state.items.isEmpty) Navigator.pop(context);
        },
        builder: (context, state) {
          return ListView.builder(
            itemExtent: 150,
            itemCount: state.items.length,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(bottom: 30),
            itemBuilder: (context, index) {
              return _ListItem(
                item: state.items[index],
              );
            },
          );
        },
      ),

      // Bottom sheet with total price and payment button
      bottomNavigationBar: const _BottomSheet(),
    );
  }
}

class _ListItem extends StatelessWidget {
  const _ListItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  final CartItem item;

  @override
  Widget build(BuildContext context) {
    final product = context.select(
      (HomeViewCubit bloc) => bloc.state.featuredProducts.singleWhere(
        (p) => p.id == item.productId,
      ),
    );

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Image and name
            Expanded(
              child: Row(
                children: [
                  // Image
                  AspectRatio(
                    aspectRatio: 3 / 2,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        fit: BoxFit.cover,
                        image: product.imageUrl,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),

                  // Name
                  Expanded(
                    child: Text(
                      product.name,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),

                  // Remove button
                  IconButton(
                    onPressed: () {
                      context.read<CartCubit>().deleteFromCart(product);
                    },
                    color: Colors.red,
                    icon: const Icon(Icons.delete),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    // Quantity button
                    AddToCartButton(
                      product: product,
                      minimumSize: const Size(90, 30),
                    ),
                    const SizedBox(width: 50),

                    // Total price
                    Expanded(
                      child: Text(
                        _price(product),
                        textAlign: TextAlign.end,
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _price(FeaturedProduct product) {
    final productPrice =
        product.specialPrice == 0 ? product.price : product.specialPrice;
    final totalPrice = item.productCount * productPrice;
    return '\$$totalPrice';
  }
}

/// Bottom sheet with total price, address and payment button.
class _BottomSheet extends StatelessWidget {
  const _BottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: () {},
      enableDrag: false,
      elevation: 20,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Total price
              Row(
                children: [
                  Text(
                    'Total price:',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  Expanded(
                    child: BlocSelector<CartCubit, CartState, double>(
                      selector: (state) {
                        return state.items.fold<double>(
                          0,
                          (previousValue, item) {
                            final list = context
                                .read<HomeViewCubit>()
                                .state
                                .featuredProducts
                                .where((p) => p.id == item.productId);
                            assert(list.length == 1);
                            final product = list.first;
                            final price = product.specialPrice == 0
                                ? product.price
                                : product.specialPrice;

                            return previousValue + price * item.productCount;
                          },
                        );
                      },
                      builder: (context, totalAmount) {
                        return Text(
                          '\$$totalAmount',
                          textAlign: TextAlign.end,
                          style: Theme.of(context).textTheme.titleLarge,
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Address
              Text(
                'Address',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
              Row(
                children: [
                  const Expanded(
                    child: Text('Address goes here..'),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: () {},
                    child: const Text('Change'),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Payment button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  fixedSize: const Size(double.infinity, 50),
                ),
                onPressed: () {},
                child: const Text('PROCEED TO PAYMENT'),
              ),
            ],
          ),
        );
      },
    );
  }
}
