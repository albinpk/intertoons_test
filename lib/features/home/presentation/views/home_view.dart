import 'package:flutter/material.dart';

import '../widgets/slider_banner_page_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: CustomScrollView(
        slivers: [
          // Delivery address
          SliverAppBar(
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
                    child: const ColoredBox(color: Colors.red),
                  ),
                ),
              ],
            ),
          ),

          // Slider banners page view
          SliverToBoxAdapter(
            child: SizedBox(
              width: screenSize.width,
              height: 200,
              child: const SliderBannerPageView(),
            ),
          ),

          // Featured products
          SliverToBoxAdapter(
            child: SizedBox(
              width: screenSize.width,
              height: 150,
              child: Column(
                children: [
                  const Text('Featured'),
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
              ),
            ),
          ),

          // Additional banners
          SliverToBoxAdapter(
            child: SizedBox(
              width: screenSize.width,
              height: 150,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: ColoredBox(color: Colors.red),
              ),
            ),
          ),

          // Best seller products
          const SliverToBoxAdapter(
            child: Text('Best sellers'),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: 10,
              (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: const [
                      SizedBox.square(
                        dimension: 80,
                        child: ColoredBox(color: Colors.green),
                      ),
                      SizedBox(width: 10),
                      Text('Item'),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
