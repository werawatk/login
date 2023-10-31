import 'package:flutter/material.dart';
import 'package:myappit2/pages/counter.dart';
import 'package:myappit2/pages/sliverbar.dart';
import 'package:myappit2/screens/mylogin.dart';
import 'package:myappit2/screens/myregister.dart';
import 'package:myappit2/screens/navigatorpage.dart';
import 'package:myappit2/screens/welcome.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyWelcome(),
      routes: {
        'login': (context) => MyLoginPage(),
        'register': (context) => MyRegisterPage(),
        'home': (context) => MyNavigatorPage(),
        'counter': (context) => MyHomepage(),
        'sliver': (context) => MyAppbarPage()
      },
    );
  }
}
