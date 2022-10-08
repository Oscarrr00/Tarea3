import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tarea3/home_page.dart';
import 'package:tarea3/providers/provider.dart';

void main() => runApp(
      ChangeNotifierProvider<Provide_Book>(
        create: (context) => Provide_Book(),
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: HomePage(),
    );
  }
}
