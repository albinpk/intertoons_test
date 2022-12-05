import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/cart_cubit.dart';

class OrderSummaryScreen extends StatelessWidget {
  const OrderSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Text('Order Summary'),
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          return ListView.builder(
            itemCount: state.items.length,
            itemBuilder: (context, index) {
              return Text('Cart item $index');
            },
          );
        },
      ),
    );
  }
}
