import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/home/presentation/cubit/home_view_cubit.dart';
import '../cubit/cart_cubit.dart';
import '../cubit/products_cubit.dart';
import '../screens/order_summary_screen.dart';

/// This widget displays the number of items in the user's cart,
/// the total amount, and a button to view the cart.
class BottomCartBar extends StatelessWidget {
  const BottomCartBar({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    // To show/hide this widget using the AnimatedAlign widget
    final isEmpty = context.select(
      (CartCubit bloc) => bloc.state.items.isEmpty,
    );

    final isLoading = context.select(
      (HomeViewCubit bloc) => bloc.state.status != HomeViewStatus.success,
    );

    return AnimatedAlign(
      alignment: Alignment.topCenter,
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 300),
      heightFactor: isLoading || isEmpty ? 0 : 1,
      child: isLoading
          ? const SizedBox.shrink()
          : ColoredBox(
              color: Colors.black,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BlocSelector<CartCubit, CartState, int>(
                            selector: (state) {
                              return state.items.fold<int>(
                                0,
                                (previousValue, item) =>
                                    previousValue + item.productCount,
                              );
                            },
                            builder: (context, itemCount) {
                              return RichText(
                                text: TextSpan(
                                  style: textTheme.titleSmall!.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '$itemCount ',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          'item${itemCount > 1 ? 's' : ''} in the cart',
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 3),

                          // Total amount
                          BlocSelector<ProductsCubit, ProductsState, bool>(
                            selector: (state) {
                              return state.status == ProductsStatus.succuss;
                            },
                            builder: (context, isSuccess) {
                              if (!isSuccess) {
                                return const Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: SizedBox(
                                    width: 100,
                                    child: LinearProgressIndicator(
                                      color: Colors.grey,
                                      backgroundColor: Colors.transparent,
                                    ),
                                  ),
                                );
                              }

                              return BlocSelector<CartCubit, CartState, double>(
                                selector: (state) {
                                  return state.items.fold<double>(
                                    0,
                                    (previousValue, item) {
                                      final list = context
                                          .read<ProductsCubit>()
                                          .state
                                          .products
                                          .where((p) => p.id == item.productId);
                                      assert(list.length == 1);
                                      final product = list.first;
                                      final price =
                                          product.specialPrice ?? product.price;

                                      return previousValue +
                                          price * item.productCount;
                                    },
                                  );
                                },
                                builder: (context, totalPrice) {
                                  return RichText(
                                    text: TextSpan(
                                      style: textTheme.titleMedium!.copyWith(
                                        color: Colors.white,
                                      ),
                                      children: [
                                        const TextSpan(text: 'Total: '),
                                        TextSpan(
                                          text:
                                              '\$${totalPrice.toStringAsFixed(2)}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),

                    // Goto cart button.
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return const OrderSummaryScreen();
                            },
                          ),
                        );
                      },
                      child: const Text("Goto Cart"),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
