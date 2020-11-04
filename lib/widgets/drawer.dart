import 'package:flutter/material.dart';

import '../screens/favorite_pandals.dart';

class SideDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              child: Text(
                'Your Pandals 🏛',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              onTap: () {
                Navigator.of(context)
                    .pushNamed(FavoritePandals.routeName)
                    .then((_) => Navigator.pop(context));
              },
            ),
          ],
        ),
      ),
    );
  }
}
