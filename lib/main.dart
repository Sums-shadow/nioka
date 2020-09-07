import 'package:nioka/constante.dart';

import './home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: color1,
      title: 'Nioka',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
