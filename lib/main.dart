import 'package:flutter/material.dart';

import 'package:cinemapedia/config/router/app_router.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/config/theme/app_theme.dart';

// Future<void> async es requisito de flutter_dotenv
Future<void> main() async {

  // await es requisito de flutter_dotenv
  await dotenv.load(fileName: ".env");
  runApp(
    // Para funcionamiento de Riverpod reemplazo esta linea:
    //const MainApp()
    // por esta otra:
    const ProviderScope(child: MainApp())
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme(),
    );
  }
}
