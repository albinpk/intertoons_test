import 'package:flutter/material.dart';

import '../../../../core/constants.dart';

/// The home view appBar, contains delivery address.
class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      toolbarHeight: kToolbarHeight + 20,
      floating: true,
      snap: true,
      backgroundColor: Colors.white,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Deliver to',
            style: TextStyle(color: Colors.black87),
          ),
          const SizedBox(height: 5),
          Text(
            'The delivery address goes here.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.black54,
                ),
          ),
          const SizedBox(height: 5),
          SizedBox(
            width: 100,
            height: 5,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: const ColoredBox(color: primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
