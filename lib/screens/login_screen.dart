import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static const String _locationSvg = 'assets/images/location.svg';
  final Widget svg = SvgPicture.asset(
    _locationSvg,
    semanticsLabel: 'Location SVG',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        toolbarHeight: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 400,
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: svg,
          ),
          Text(
            'Welcome Back!',
            style: Theme.of(context).textTheme.headline6,
            textAlign: TextAlign.center,
          ),
          Text(
            'Login and start your journey',
            style: Theme.of(context).textTheme.headline5,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 30),
          /*
            Add Form
            Add Footer 
          */
        ],
      ),
    );
  }
}
