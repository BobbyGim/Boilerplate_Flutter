import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/src/presentation/page/home/components/hooks/hooks.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class HomeDetailCard extends HookWidget {
  const HomeDetailCard({required this.id, super.key});

  final String id;

  @override
  Widget build(BuildContext context) {
    final (:openDetail, :title) = useHomeDetailCard(id: id);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: openDetail,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              const Icon(Icons.article_outlined),
              const SizedBox(width: 12),
              Expanded(child: Text(title)),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}
