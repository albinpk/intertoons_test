import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../../core/models/product_model.dart';
import '../../../../core/widgets/add_to_cart_button.dart';
import 'price_section.dart';
import 'veg_symbol.dart';

class ProductTile extends StatelessWidget {
  const ProductTile({
    super.key,
    required this.product,
  });

  final Product? product;

  static final text = ClipRRect(
    borderRadius: BorderRadius.circular(8),
    child: const ColoredBox(color: Colors.black12),
  );

  @override
  Widget build(BuildContext context) {
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
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(fontWeight: FontWeight.w500),
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

                            // TODO: special price
                            // Product price
                            PriceSection(product: product!),
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
