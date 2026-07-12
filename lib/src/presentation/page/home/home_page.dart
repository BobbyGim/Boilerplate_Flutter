import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/src/data/data.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppEnvironment.appName)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Expanded(
            //   child: GridView.count(
            //     crossAxisCount: 2,
            //     mainAxisSpacing: 12,
            //     crossAxisSpacing: 12,
            //     childAspectRatio: 1.4,
            //     children: detailIds
            //         .map((id) => HomeDetailCard(id: id))
            //         .toList(),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
