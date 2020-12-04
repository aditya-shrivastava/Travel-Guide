import 'package:flutter/material.dart';

import '../screens/favorite_pandals.dart';

class SideDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).primaryColor,
              Color(0xFF8e2de2),
            ],
          ),
        ),
      ),
    );
  }
}
