import 'package:flutter/material.dart';

class ViewAllButton extends StatelessWidget {
  const ViewAllButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        foregroundColor: Colors.black54,
      ),
      onPressed: () => Navigator.of(context).pushNamed('/products'),
      child: const Text('View all'),
    );
  }
}
