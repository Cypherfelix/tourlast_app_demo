import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/theme/app_theme.dart';
import 'presentation/screens/splash/splash_screen.dart';

void main() {
  runApp(const ProviderScope(child: TourLastApp()));
}

class TourLastApp extends StatelessWidget {
  const TourLastApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TourLast Flights',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const SplashScreen(),
    );
  }
}
