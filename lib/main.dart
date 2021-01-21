import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_config/flutter_config.dart';

import './providers/pandals.dart';

import './screens/login_screen.dart';
import './screens/signup_screen.dart';
import './screens/home_screen.dart';
import './screens/pandal_details_screen.dart';
import './screens/favorite_pandals.dart';
import './screens/map_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Pandals(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Travel Guide',
        theme: ThemeData(
          primaryColor: Color.fromRGBO(125, 114, 255, 1),
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
        home: StreamBuilder(
            stream: FirebaseAuth.instance.onAuthStateChanged,
            builder: (ctx, userSnapshot) {
              if (userSnapshot.hasData) {
                return HomeScreen();
              }
              return LoginScreen();
            }),
        routes: {
          HomeScreen.route: (ctx) => HomeScreen(),
          LoginScreen.routeName: (ctx) => LoginScreen(),
          SignupScreen.routeName: (ctx) => SignupScreen(),
          PandalDetailsScreen.routeName: (ctx) => PandalDetailsScreen(),
          FavoritePandals.routeName: (ctx) => FavoritePandals(),
          MapScreen.routeName: (ctx) => MapScreen(),
        },
      ),
    );
  }
}
