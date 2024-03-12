import 'package:amazon/features/auth/screens/auth_screen.dart';
import 'package:amazon/features/home/home_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routesettings) {
  switch (routesettings.name) {
    case HomeScreen.routeName:
      return MaterialPageRoute(
          settings: routesettings, builder: (_) => const HomeScreen());
    default:
      return MaterialPageRoute(
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Page not found'),
          ),
        ),
      );
  }
}
