import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.restaurantId});

  static const routeName = '/detail_screen';
  final String restaurantId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Restoran'),
      ),
      body: Center(child: Text("ID: $restaurantId"),),
    );
  }
}