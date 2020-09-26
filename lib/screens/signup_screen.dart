import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignupScreen extends StatefulWidget {
  // create static route name
  static const routeName = '/signup';

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  static const String _signupSvg = 'assets/images/signup.svg';
  final Widget svg = SvgPicture.asset(
    _signupSvg,
    semanticsLabel: 'Sign Up SVG',
  );
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
              height: MediaQuery.of(context).size.height - 550,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              child: svg,
            ),
            Text(
              'We are here to guide you.',
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            ),
            Text(
              'Sign Up for a hassel-free experience',
              style: Theme.of(context).textTheme.headline5,
              textAlign: TextAlign.center,
            ),

            // Inputs
            Container(
              padding: EdgeInsets.only(
                top: 10,
                left: 30,
                right: 0,
                bottom: MediaQuery.of(context).viewInsets.bottom + 10,
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),

                  //name
                  TextField(
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.person,
                        color: Color.fromRGBO(35, 163, 203, 1),
                      ),
                      hintText: 'name',
                    ),
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  //email
                  TextField(
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.alternate_email,
                        color: Color.fromRGBO(35, 163, 203, 1),
                      ),
                      hintText: 'email',
                    ),
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  //password
                  TextField(
                    decoration: InputDecoration(
                        icon: Icon(
                          Icons.lock,
                          color: Color.fromRGBO(35, 163, 203, 1),
                        ),
                        hintText: 'password',
                        border: InputBorder.none,
                        suffixIcon: Icon(
                          Icons.visibility,
                          color: Color.fromRGBO(35, 163, 203, 1),
                        )),
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  // confirm password
                  TextField(
                    decoration: InputDecoration(
                        icon: Icon(
                          Icons.lock,
                          color: Color.fromRGBO(35, 163, 203, 1),
                        ),
                        hintText: 'confirm password',
                        border: InputBorder.none,
                        suffixIcon: Icon(
                          Icons.visibility,
                          color: Color.fromRGBO(35, 163, 203, 1),
                        )),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: <Widget>[],
            )
          ],
        ),
      ),
    );
  }
}
