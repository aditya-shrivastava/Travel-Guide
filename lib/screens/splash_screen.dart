import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
      ),
      child: Center(
        child: LoadingBouncingGrid.square(
          size: 50.0,
          backgroundColor: Colors.white,
          duration: Duration(milliseconds: 700),
        ),
      ),
    );
  }
}
