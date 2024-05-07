import 'package:assessment_project/Routes/routesname.dart';

import 'package:assessment_project/Views/HomePage.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.home:
        return MaterialPageRoute(
            builder: (BuildContext context) => const HomePage());
      

      default:
        return MaterialPageRoute(
          builder: (_) {
            return const Scaffold(
              body: Center(
                child: Text('No Route Found'),
              ),
            );
          },
        );
    }
  }
}