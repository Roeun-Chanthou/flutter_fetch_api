import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import 'pages/main_page/main_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      home: MainScreen(),
    );
  }
}
