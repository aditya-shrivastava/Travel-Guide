import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static const String _locationSvg = 'assets/images/location.svg';
  final _emailController = new TextEditingController();
  final _passwordController = new TextEditingController();

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
      body: SingleChildScrollView(
        child: Column(
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
            SizedBox(height: 10),
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              child: TextField(
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  labelText: 'email',
                  labelStyle: Theme.of(context).textTheme.subtitle1,
                  prefix: Container(
                    width: MediaQuery.of(context).size.width - 285,
                    child: Row(
                      children: [
                        Icon(
                          Icons.person,
                          color: Color.fromRGBO(35, 163, 203, 1),
                        ),
                        Text(
                          'email',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ],
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromRGBO(35, 163, 203, 1),
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                controller: _emailController,
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              child: TextField(
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  labelText: 'password',
                  labelStyle: Theme.of(context).textTheme.subtitle1,
                  prefix: Container(
                    width: MediaQuery.of(context).size.width - 250,
                    child: Row(
                      children: [
                        Icon(
                          Icons.lock,
                          color: Color.fromRGBO(35, 163, 203, 1),
                        ),
                        Text(
                          'password',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ],
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromRGBO(35, 163, 203, 1),
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                controller: _passwordController,
              ),
            ),
            SizedBox(height: 10),
            RaisedButton(
              child: Text(
                'LOGIN',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              color: Theme.of(context).primaryColor,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
