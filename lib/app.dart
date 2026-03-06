import 'package:flutter/material.dart';
import 'package:pokedex/src/router/app_router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.router,  // GoRouter ya contiene el navigatorKey
      debugShowCheckedModeBanner: false,
      title: 'Pokédex',
      theme: ThemeData.light(),
      darkTheme: ThemeData.light(),
      themeMode: ThemeMode.light,
    );
  }
}