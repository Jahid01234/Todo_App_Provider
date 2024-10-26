import 'package:flutter/material.dart';
import 'package:todo_app_provider/screens/home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Todo App With Provider',
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
