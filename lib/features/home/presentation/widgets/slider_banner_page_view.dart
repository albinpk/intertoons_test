import 'package:flutter/material.dart';

class SliderBannerPageView extends StatelessWidget {
  const SliderBannerPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      padEnds: false,
      itemCount: 5,
      controller: PageController(viewportFraction: 0.8),
      itemBuilder: (context, index) {
        return const Padding(
          padding: EdgeInsets.all(8.0),
          child: ColoredBox(color: Colors.red),
        );
      },
    );
  }
}
