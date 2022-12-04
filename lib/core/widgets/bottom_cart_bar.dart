import 'package:flutter/material.dart';

/// This widget displays the number of items in the user's cart,
/// the total amount, and a button to view the cart.
class BottomCartBar extends StatelessWidget {
  const BottomCartBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            Expanded(
              child: Text(
                '2 Items in cart \$50.0',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Colors.white),
              ),
            ),

            // Goto cart button.
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
              ),
              onPressed: () {},
              child: const Text("Goto Cart"),
            ),
          ],
        ),
      ),
    );
  }
}
