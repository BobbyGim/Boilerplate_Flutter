import 'package:flutter_dotenv/flutter_dotenv.dart';

final class AppEnvironment {
  const AppEnvironment._();

  static const dev = 'dev';
  static const prod = 'prod';

  static late final String flavor;

  static bool get isDev => flavor == dev;

  static String get appName {
    return dotenv.env['APP_NAME'] ?? 'Flutter Boilerplate';
  }

  static String get apiBaseUrl {
    return dotenv.env['API_BASE_URL'] ?? '';
  }

  static Future<void> load(String selectedFlavor) async {
    flavor = selectedFlavor;

    final fileName = switch (flavor) {
      prod => '.env.prod',
      _ => '.env.dev',
    };

    await dotenv.load(fileName: fileName);
  }
}
