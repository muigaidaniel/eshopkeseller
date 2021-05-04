import 'package:eshopkeseller/screens/addproduct.dart';
import 'package:eshopkeseller/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/login.dart';
import 'screens/register.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

class App extends StatelessWidget {
  bool isLoggedIn;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
      routes: {
        'homepage':(context)=> Home(),
        'register':(context)=> Register(),
        'login' : (context)=> Login(),
        'addproduct':(context)=> AddProduct(),
      },
      title: 'E-Shop KE',
      theme: ThemeData(
        primaryColor: Colors.blue,
        accentColor: Colors.blueAccent,
        primarySwatch: Colors.cyan,
      ),
    );
  }
}