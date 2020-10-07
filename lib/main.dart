import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:travel_guide/services/auth.dart';

import './screens/login_screen.dart';
import './screens/signup_screen.dart';
import './screens/home_screen.dart';

void main() async {
  await DotEnv().load('.env');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: AuthService(),
          ),
        ],
        child: Consumer<AuthService>(
          builder: (ctx, auth, _) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Travel Guide',
            theme: ThemeData(
              primaryColor: Colors.blue,
              accentColor: Color.fromRGBO(35, 163, 203, 1),
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
                headline4: TextStyle(
                  fontSize: 18,
                  color: Color.fromRGBO(125, 114, 255, 0.6),
                  fontWeight: FontWeight.bold,
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
            home: auth.isAuth ? HomeScreen() : LoginScreen(),
            routes: {
              HomeScreen.route: (ctx) => HomeScreen(),
              LoginScreen.routeName: (ctx) => LoginScreen(),
              SignupScreen.routeName: (ctx) => SignupScreen(),
            },
          ),
        ));
  }
}
