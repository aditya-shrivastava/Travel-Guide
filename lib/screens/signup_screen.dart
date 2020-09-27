import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../icons/pass_key_icons.dart';
import '../screens/login_screen.dart';

class SignupScreen extends StatefulWidget {
  // create static route name
  static const routeName = '/signup';

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  static const String _signupSvg = 'assets/images/signup.svg';
  final _nameController = new TextEditingController();
  final _emailController = new TextEditingController();
  final _passwordController = new TextEditingController();
  final _confirmpasswordController = new TextEditingController();
  bool _isHidden = true;
  bool _isHidden1 = true;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        toolbarHeight: 0,
      ),
      // Add Body
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 480,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
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
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
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
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Theme.of(context).accentColor),
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
                          borderSide:
                              BorderSide(color: Theme.of(context).accentColor),
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
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Theme.of(context).accentColor),
                          borderRadius: BorderRadius.circular(35),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Theme.of(context).accentColor),
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
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Theme.of(context).accentColor),
                          borderRadius: BorderRadius.circular(35),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Theme.of(context).accentColor),
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
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Theme.of(context).accentColor),
                          borderRadius: BorderRadius.circular(35),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Theme.of(context).accentColor),
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
              padding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 100),
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
                  print(_nameController.text);
                  print(_emailController.text);
                  print(_passwordController.text);
                  print(_confirmpasswordController.text);
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
                      color: Color.fromRGBO(45, 128, 209, 1),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return LoginScreen();
                        },
                      ),
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
