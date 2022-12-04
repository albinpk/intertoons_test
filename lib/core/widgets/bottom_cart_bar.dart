import 'package:flutter/material.dart';

/// This widget displays the number of items in the user's cart,
/// the total amount, and a button to view the cart.
class BottomCartBar extends StatelessWidget {
  const BottomCartBar({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    const itemCount = 2;

    return ColoredBox(
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      style: textTheme.titleSmall!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                      children: const [
                        TextSpan(
                          text: '$itemCount ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: 'item${itemCount > 1 ? 's' : ''} in the cart',
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 3),

                  // Total amount
                  RichText(
                    text: TextSpan(
                      style: textTheme.titleMedium!.copyWith(
                        color: Colors.white,
                      ),
                      children: const [
                        TextSpan(text: 'Total: '),
                        TextSpan(
                          text: '\$50.0',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
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
