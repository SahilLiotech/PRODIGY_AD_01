import 'package:calculator_01/calculator.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Calculator",
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: ThemeData(
        colorScheme: const ColorScheme.light().copyWith(
          primary: Colors.lightBlue,
          secondary: Colors.lightBlueAccent,
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: const ColorScheme.dark().copyWith(
          primary: Colors.green,
          secondary: Colors.greenAccent,
        ),
        textTheme: TextTheme(

        )
      ),
      home: const Calculator(),
    );
  }
}
