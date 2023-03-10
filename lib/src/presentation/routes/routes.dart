// Packages
import 'package:flutter/material.dart';

// Pages
import '../views/views.dart';

Map<String, Widget Function(BuildContext)> routes = <String, WidgetBuilder>{
  '/': (context) => const HomePage(),
  '/detail': (context) => const DetailPage()
};
