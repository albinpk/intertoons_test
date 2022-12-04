import 'package:flutter/material.dart';

class AccountView extends StatelessWidget {
  const AccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Text('Account'),
      ),
      body: Center(
        child: Text(
          'Account',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}
