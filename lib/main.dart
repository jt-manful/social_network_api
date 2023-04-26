
import 'package:flutter/material.dart';
import 'logIn.dart';

void main () => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'REST API',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: logIn(),
    );
  }
}