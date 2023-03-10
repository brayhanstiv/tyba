// Packages
import 'package:flutter/material.dart';

// Common
import 'presentation/routes/routes.dart';
import 'presentation/global/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: themeLight,
      initialRoute: '/',
      routes: routes,
    );
  }
}
