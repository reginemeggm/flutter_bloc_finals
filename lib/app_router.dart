import 'package:flutter/material.dart';

import 'screens/recycle_bin_screen.dart';
import 'screens/tabs_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case TabsScreen.path:
        return MaterialPageRoute(builder: (_) => const TabsScreen());

      case RecycleBinScreen.path:
        return MaterialPageRoute(builder: (_) => const RecycleBinScreen());

      default:
        return null;
    }
  }
}
