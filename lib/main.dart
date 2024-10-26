import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_provider/app.dart';
import 'package:todo_app_provider/provider/todo_provider.dart';

void main() {
  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_)=>TodoProvider(),),
        ],
        child: const MyApp(),
      ),
  );
}


