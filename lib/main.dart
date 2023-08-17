import 'package:emobile_calculator_test/presentation/page/calculator_page.dart';
import 'package:flutter/material.dart';

import 'misc/injector.dart';

void main() {
  Injector.init();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: false,
      ),
      home: const CalculatorPage(),
    );
  }
}