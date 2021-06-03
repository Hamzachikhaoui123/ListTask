import 'package:flutter/material.dart';
import 'package:list2/secreen/activite.dart';
import 'package:list2/secreen/homePage.dart';
import 'package:list2/secreen/list.dart';
import 'package:list2/secreen/menu.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        '/': (context) => homepage(),
        '/seconde': (context) => activite(),
        '/thrid': (context) => meun(),
        '/for': (context) => listP()
      },
    );
  }
}
