import 'package:querhub/Views/Authentication/SignUp.dart';
import '../Models/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class InitializingPage extends StatefulWidget {

  @override
  _InitializingPageState createState() => _InitializingPageState();
}

class _InitializingPageState extends State<InitializingPage> {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Center(child: CircularProgressIndicator(),);
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return SignUp();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Center(child: CircularProgressIndicator());
      },
    );
  }

}
