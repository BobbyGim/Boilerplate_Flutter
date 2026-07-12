import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({
    required this.id,
    super.key,
  });

  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail')),
      body: Center(
        child: Text('Detail Page: $id'),
      ),
    );
  }
}
