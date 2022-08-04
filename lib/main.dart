import 'package:flutter/material.dart';

import 'app_router.dart';
import 'app_themes.dart';
import 'screens/tabs_screen.dart';

void main() {
  runApp(
    MyApp(appRouter: AppRouter()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.appRouter}) : super(key: key);

  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BloC Tasks App',
      theme: AppThemes.appThemeData[AppTheme.lightMode],
      home: const TabsScreen(),
      onGenerateRoute: appRouter.onGenerateRoute,
    );
  }
}
