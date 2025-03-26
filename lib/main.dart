import 'package:flutter/material.dart';
import 'package:jobs_applications_app/core/router/app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      //theme: AppTheme().getTheme(),
    );
  }
}
