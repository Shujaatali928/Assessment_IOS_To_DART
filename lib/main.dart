import 'package:assessment_project/routes/routes.dart';
import 'package:assessment_project/routes/routesname.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: RouteName.home,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}

