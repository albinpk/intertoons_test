import 'package:flutter/material.dart';

/// Featured products list view.
class FeaturedProducts extends StatelessWidget {
  const FeaturedProducts({
    Key? key,
  }) : super(key: key);

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
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return const Padding(
                padding: EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 200,
                  child: ColoredBox(
                    color: Colors.blue,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
