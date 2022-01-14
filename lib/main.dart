import 'Views/InitializingPage.dart';
import 'Models/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() => runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    )
);

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context){
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: InitializingPage(),
    );
  }
}
