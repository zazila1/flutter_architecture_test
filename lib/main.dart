import 'package:flutter/material.dart';

import 'router/fluro_router.dart';

void main() {
  runApp(MyApp());
  AppRouter.init();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: AppRouter.startRoute,
      onGenerateRoute: AppRouter.router.generator,

    );
  }
}
