import 'package:flutter/material.dart';

class VegSymbol extends StatelessWidget {
  const VegSymbol({
    super.key,
    required bool isVeg,
  }) : color = isVeg ? Colors.green : const Color(0xFFE9665C);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: 16,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            color: color,
            width: 1.5,
          ),
        ),
        child: Center(
          child: SizedBox.square(
            dimension: 8,
            child: ClipOval(
              child: ColoredBox(color: color),
            ),
          ),
        ),
      ),
    );
  }
}
