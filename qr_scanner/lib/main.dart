import 'package:flutter/material.dart';
import 'package:qr_scanner/splash_screen.dart';

import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //Given Title
      title: 'QR Scanner',
      debugShowCheckedModeBanner: false,
      //Given Theme Color
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      //Declared first page of our app
      home: const SplashScreen(),
    );
  }
}
