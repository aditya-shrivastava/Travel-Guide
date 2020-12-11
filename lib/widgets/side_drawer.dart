import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/favorite_pandals.dart';

class SideDrawer extends StatefulWidget {
  @override
  _SideDrawerState createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  var _uid = new TextEditingController();
  var _displayName;
  var _email;
  var _prefs;

  void fetchUserDetails() async {
    _prefs = await SharedPreferences.getInstance();
    final _userData =
        json.decode(_prefs.getString('userData')) as Map<String, Object>;

    setState(() {
      _displayName = _userData['displayName'];
      _email = _userData['email'];
    });
  }

  @override
  void initState() {
    super.initState();
    fetchUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text(_email == null ? 'email@email.com' : _email),
            automaticallyImplyLeading: false,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
            child: Center(
              child: CircleAvatar(
                radius: 70,
                backgroundColor: Colors.white,
                child:
                    Image.asset('./assets/images/google_icon.png', width: 70),
              ),
            ),
          ),
          Text(
            _displayName == null ? 'username' : _displayName,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              controller: _uid,
              decoration: InputDecoration(labelText: 'Enter ID'),
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RaisedButton(
                color: Theme.of(context).primaryColor,
                child: Text(
                  'FIND',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onPressed: () {},
              ),
              RaisedButton(
                color: Colors.white,
                child: Text(
                  'SHARE',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onPressed: () {},
              )
            ],
          ),
          Divider(),
          ListTile(
            onTap: () => {
              Navigator.of(context)
                  .pushNamed(FavoritePandals.routeName)
                  .then((_) => Navigator.of(context).pop()),
            },
            trailing: Icon(Icons.bookmark, color: Colors.pink),
            leading: Text(
              'Your Pandals',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Divider(),
          SizedBox(
            height: 40.0,
          ),
          RaisedButton(
            color: Theme.of(context).primaryColor,
            child: Container(
              width: 100,
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'LOGOUT',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(
                    Icons.exit_to_app,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');
              _prefs.clear();
              FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
    );
  }
}
