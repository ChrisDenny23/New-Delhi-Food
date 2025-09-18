import 'package:flutter/material.dart';
import 'package:newdelhifoods/mainpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'New Delhi Foods',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        fontFamily: 'Josefin Sans',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MainPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
