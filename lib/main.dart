import 'package:flutter/material.dart';

// import screens
import './screens/login_screen.dart';
import './screens/signup_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Travel Guide',
      theme: ThemeData(
        primaryColor: Colors.blue,
        fontFamily: 'Raleway',
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          headline6: TextStyle(
            fontSize: 18,
            color: Color.fromRGBO(125, 114, 255, 1),
            fontWeight: FontWeight.bold,
          ),
          headline5: TextStyle(
            fontSize: 18,
            color: Color.fromRGBO(100, 100, 110, 1),
          ),
          subtitle1: TextStyle(
            fontSize: 16,
            color: Color.fromRGBO(35, 163, 203, 1),
          ),
          subtitle2: TextStyle(
            fontSize: 14,
            color: Color.fromRGBO(140, 140, 141, 1),
          ),
        ),
      ),
      home: LoginScreen(),
      routes: {
        SignupScreen.routeName: (ctx) => SignupScreen(),
      },
    );
  }
}
