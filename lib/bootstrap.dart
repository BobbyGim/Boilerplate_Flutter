import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/src/src.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future<void> bootstrap(String flavor) async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppEnvironment.load(flavor);

  runApp(const ProviderScope(child: App()));
}
