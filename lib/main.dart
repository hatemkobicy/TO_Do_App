// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'layout/home_layout.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TO DO LIST',
      theme: ThemeData(primarySwatch: Colors.red),
      home: HomeLayout(),
    );
  }
}
