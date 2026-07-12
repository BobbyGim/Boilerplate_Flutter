import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_boilerplate/src/presentation/page/home/views/hooks/hooks.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class HomeTitle extends HookWidget {
  const HomeTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final (:title, :description) = useHomeTitle();
    final textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'TIME TO CODE',
          style: textTheme.displaySmall,
          textAlign: TextAlign.center,
        ).animate().fadeIn().slideY(begin: 0.2, duration: 1000.ms),
        const SizedBox(height: 16),
        Text(
          title,
          style: textTheme.headlineSmall,
          textAlign: TextAlign.center,
        ),
        Text(
          description,
          style: textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
