import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../screens/signup_screen.dart';
import '../services/auth.dart';
import '../models/http_exception.dart';

import '../icons/pass_key_icons.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static const String _locationSvg = 'assets/images/location.svg';

  var _emailController = new TextEditingController();
  var _passwordController = new TextEditingController();

  bool _isHidden = true;
  bool _isLoading = false;

  bool _errorEmail = false;
  bool _errorPassword = false;

  final Widget svg = SvgPicture.asset(
    _locationSvg,
    semanticsLabel: 'Location SVG',
  );

  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Error Occurred!'),
        content: Text(message),
        actions: [
          FlatButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  Future<void> _submit() async {
    final String _email = _emailController.text;
    final String _password = _passwordController.text;

    if (_email.isEmpty) {
      setState(() {
        _errorEmail = true;
      });
      return;
    } else {
      setState(() {
        _errorEmail = false;
      });
    }
    if (_password.isEmpty) {
      setState(() {
        _errorPassword = true;
      });
      return;
    } else {
      setState(() {
        _errorPassword = false;
      });
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await Provider.of<AuthService>(context, listen: false)
          .login(_email, _password);
    } on HttpException catch (error) {
      var errorMessage = 'Authentication failed';
      if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'Invalid email address';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Could not find a user with that email address';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Incorrect Password';
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      const errorMessage = 'Something went wrong. Please try again.';
      _showErrorDialog(errorMessage);
    }

    _emailController.clear();
    _passwordController.clear();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        toolbarHeight: 0,
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Theme.of(context).primaryColor,
              ),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height - 400,
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 10),
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
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          child: TextField(
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              errorText:
                                  _errorEmail ? 'Email cannot be blank' : null,
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.circular(35),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.circular(35),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).accentColor),
                                borderRadius: BorderRadius.circular(35),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).accentColor),
                                borderRadius: BorderRadius.circular(35),
                              ),
                              prefixIcon: Icon(
                                Icons.person,
                                color: Theme.of(context).accentColor,
                              ),
                              labelText: 'email',
                              labelStyle: Theme.of(context).textTheme.subtitle1,
                            ),
                            controller: _emailController,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: TextField(
                            obscureText: _isHidden,
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                              errorText: _errorPassword
                                  ? 'Password cannot be blank'
                                  : null,
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.circular(35),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.circular(35),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).accentColor),
                                borderRadius: BorderRadius.circular(35),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).accentColor),
                                borderRadius: BorderRadius.circular(35),
                              ),
                              prefixIcon: Icon(
                                Pass_key.key,
                                color: Theme.of(context).accentColor,
                              ),
                              labelText: 'password',
                              labelStyle: Theme.of(context).textTheme.subtitle1,
                              suffixIcon: IconButton(
                                icon: _isHidden
                                    ? Icon(
                                        Icons.visibility,
                                        color: Theme.of(context).accentColor,
                                      )
                                    : Icon(
                                        Icons.visibility_off,
                                        color: Theme.of(context).accentColor,
                                      ),
                                onPressed: _toggleVisibility,
                              ),
                            ),
                            controller: _passwordController,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    height: 60,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 100),
                    child: RaisedButton(
                      child: Text(
                        'LOGIN',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        _submit();
                      },
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Or Signin With',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  Container(
                    height: 70,
                    width: 70,
                    child: FlatButton(
                      onPressed: () {},
                      child: Image.asset('./assets/images/google_icon.png'),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account?',
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      InkWell(
                        child: new Text(
                          ' Sign Up',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(45, 128, 209, 1),
                          ),
                        ),
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            SignupScreen.routeName,
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
