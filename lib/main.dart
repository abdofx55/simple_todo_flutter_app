import 'package:flutter/material.dart';
import 'feature/home/presentation/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TODO List',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            inversePrimary: Colors.deepPurpleAccent,
            seedColor: Colors.deepPurple),
        appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(color: Colors.white, fontSize: 21.0),
            centerTitle: true),
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}

