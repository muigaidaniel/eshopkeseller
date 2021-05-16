import 'package:eshopkeseller/screens/items.dart';

import 'database/items.dart';
import 'screens/addproduct.dart';
import 'screens/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/login.dart';
import 'screens/register.dart';
import 'package:provider/provider.dart';
import 'business_logic/user_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
      providers:[
        ChangeNotifierProvider(create: (_)=>UserProvider.initialize()),
        ChangeNotifierProvider(create: (_)=>ItemNotifier()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Login(),
          routes: {
            'homepage':(context)=> Home(),
            'register':(context)=> Register(),
            'login' : (context)=> Login(),
            'addproduct':(context)=> AddProduct(),
            'products':(context)=> DispItems(),
          },
          title: 'E-Shop KE',
          theme: ThemeData(
            primaryColor: Colors.purple,
            accentColor: Colors.blueAccent,
            primarySwatch: Colors.cyan,
          )
      )));
}

class ScreensController extends StatelessWidget {
  const ScreensController({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user= Provider.of<UserProvider>(context);
    switch(user.status){
      case Status.Uninitialized: return Login();
      case Status.Unauthenticated:
      case Status.Authenticating: return Login();
      case Status.Authenticated: return Home();
      default: return Login();
    }
  }
}
