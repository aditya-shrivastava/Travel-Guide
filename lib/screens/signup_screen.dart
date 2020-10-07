import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../screens/login_screen.dart';
import '../services/auth.dart';
import '../models/http_exception.dart';

import '../icons/pass_key_icons.dart';

class SignupScreen extends StatefulWidget {
  static const routeName = '/signup';

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  static const String _signupSvg = 'assets/images/signup.svg';

  var _nameController = new TextEditingController();
  var _emailController = new TextEditingController();
  var _passwordController = new TextEditingController();
  var _confirmpasswordController = new TextEditingController();

  bool _isHidden = true;
  bool _isHidden1 = true;

  bool _errorName = false;
  bool _errorEmail = false;
  bool _errorPassword = false;
  bool _errorConfirmPassword = false;

  bool _isLoading = false;

  final Widget svg = SvgPicture.asset(
    _signupSvg,
    semanticsLabel: 'Sign Up SVG',
  );

  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  void _toggleVisibility1() {
    setState(() {
      _isHidden1 = !_isHidden1;
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
    final String _name = _nameController.text.trim();
    final String _email = _emailController.text.trim();
    final String _password = _passwordController.text.trim();
    final String _confirmPassword = _confirmpasswordController.text.trim();

    if (_name.isEmpty) {
      setState(() {
        _errorName = true;
      });
      return;
    } else {
      setState(() {
        _errorName = false;
      });
    }
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
    if (_confirmPassword.isEmpty || _confirmPassword != _password) {
      setState(() {
        _errorConfirmPassword = true;
      });
      return;
    } else {
      _errorConfirmPassword = false;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await Provider.of<AuthService>(context, listen: false)
          .signup(_email, _password);
    } on HttpException catch (error) {
      var errorMessage = 'Authentication failed';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email address is already in use';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'Invalid email address';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'Password is too weak';
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      const errorMessage = 'Something went wrong. Please try again later';
      _showErrorDialog(errorMessage);
    }

    _nameController.clear();
    _emailController.clear();
    _passwordController.clear();
    _confirmpasswordController.clear();

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
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height - 480,
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 10),
                    child: svg,
                  ),
                  RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.headline6,
                      children: <TextSpan>[
                        TextSpan(
                          text: 'We are here to ',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        TextSpan(
                          text: 'guide ',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                        TextSpan(
                          text: 'you.',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ],
                    ),
                  ),

                  Text(
                    'Sign Up for a hassel-free experience',
                    style: Theme.of(context).textTheme.headline5,
                    textAlign: TextAlign.center,
                  ),

                  // Inputs
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),

                        //name
                        Container(
                          width: double.infinity,
                          child: TextField(
                            decoration: InputDecoration(
                              errorText:
                                  _errorName ? 'Name cannot be blank' : null,
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
                              prefixIcon: Icon(
                                Icons.person,
                                color: Theme.of(context).accentColor,
                              ),
                              labelText: 'name',
                              labelStyle: Theme.of(context).textTheme.subtitle1,
                              border: InputBorder.none,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).accentColor),
                                borderRadius: BorderRadius.circular(35),
                              ),
                            ),
                            controller: _nameController,
                          ),
                        ),

                        SizedBox(
                          height: 10,
                        ),

                        //email
                        Container(
                          width: double.infinity,
                          child: TextField(
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
                                Icons.alternate_email,
                                color: Theme.of(context).accentColor,
                              ),
                              labelText: 'email',
                              labelStyle: Theme.of(context).textTheme.subtitle1,
                              border: InputBorder.none,
                            ),
                            controller: _emailController,
                          ),
                        ),

                        SizedBox(
                          height: 10,
                        ),

                        //password
                        Container(
                          width: double.infinity,
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
                              border: InputBorder.none,
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

                        SizedBox(
                          height: 10,
                        ),

                        // confirm password
                        Container(
                          width: double.infinity,
                          child: TextField(
                            obscureText: _isHidden1,
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                              errorText: _errorConfirmPassword
                                  ? 'Confirm password doesn\'t match'
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
                              labelText: 'confirm password',
                              labelStyle: Theme.of(context).textTheme.subtitle1,
                              border: InputBorder.none,
                              suffixIcon: IconButton(
                                icon: _isHidden1
                                    ? Icon(
                                        Icons.visibility,
                                        color: Theme.of(context).accentColor,
                                      )
                                    : Icon(
                                        Icons.visibility_off,
                                        color: Theme.of(context).accentColor,
                                      ),
                                onPressed: _toggleVisibility1,
                              ),
                            ),
                            controller: _confirmpasswordController,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    height: 60,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 100),
                    child: RaisedButton(
                      child: Text(
                        'SIGN UP',
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

                  SizedBox(
                    height: 15,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Have an account?',
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      InkWell(
                        child: new Text(
                          ' Sign In',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(45, 128, 209, 1),
                          ),
                        ),
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            LoginScreen.routeName,
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
