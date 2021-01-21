import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flushbar/flushbar.dart';

import '../helpers/db_helper.dart';
import '../providers/pandals.dart';
import '../screens/favorite_pandals.dart';

class SideDrawer extends StatefulWidget {
  @override
  _SideDrawerState createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  var _idController = new TextEditingController();
  var _uid;
  var _displayName;
  var _email;
  var _prefs;

  Future<void> fetchUserDetails() async {
    final user = await FirebaseAuth.instance.currentUser();
    var prefs = await SharedPreferences.getInstance();
    final _userData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;

    setState(() {
      _displayName = _userData['displayName'];
      _email = _userData['email'];
      _uid = user.uid;
      _prefs = prefs;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchUserDetails();
  }

  Future<void> logout() async {
    var prefs = await SharedPreferences.getInstance();
    var friend = prefs.getString('friend');
    if (friend != null) {
      var _friend = json.decode(friend);
      var friendId = _friend['id'];
      await Firestore.instance.document('/users/$friendId').get().then((doc) {
        var friends = doc.data['friends'];
        if (friends > 0) {
          friends.remove(_uid);
        }
        Firestore.instance
            .document('/users/$friendId')
            .updateData({'friends': friends});
      });
    }
    await Firestore.instance
        .document('/users/$_uid')
        .updateData({'pandals': [], 'friends': []});
    _prefs.clear();

    var favPandals = await Provider.of<Pandals>(context, listen: false)
        .fetchFavoritePandals();
    favPandals.forEach((item) async {
      Provider.of<Pandals>(context, listen: false).toggleFavorite(item.id);
      await Firestore.instance
          .document('/pandals/${item.id}')
          .get()
          .then((doc) {
        var count = doc.data['count'];
        count = count - 1;
        Firestore.instance
            .document('/pandals/${item.id}')
            .updateData({'count': count});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
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
                      Image.asset('./assets/images/icon_male.png', width: 100),
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
            Text(
              _uid == null ? 'uid' : _uid,
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                controller: _idController,
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
                  onPressed: () async {
                    var _pandals;
                    await Firestore.instance
                        .document('/users/${_idController.text}')
                        .get()
                        .then((doc) {
                      _pandals = doc.data['pandals'];
                      var friend = json.encode({
                        'id': doc.documentID,
                        'displayName': doc.data['displayName'],
                        'latitude': doc.data['location']['latitude'],
                        'longitude': doc.data['location']['longitude'],
                      });
                      _prefs.setString('friend', friend);
                      var friends = doc.data['friends'] != null
                          ? doc.data['friends']
                          : [];
                      friends.add(_uid);
                      Firestore.instance
                          .document('/users/${doc.documentID}')
                          .updateData({'friends': friends}).then((_) {
                        Flushbar(
                          message: 'User Found',
                          duration: Duration(seconds: 1),
                        )..show(context);
                        _idController.clear();
                      });
                    });

                    var favPandals =
                        await Provider.of<Pandals>(context, listen: false)
                            .fetchFavoritePandals();
                    favPandals.forEach((item) {
                      Provider.of<Pandals>(context, listen: false)
                          .toggleFavorite(item.id);
                    });
                    DBHelper.clear('favorite_pandals');
                    _pandals.forEach((item) {
                      Provider.of<Pandals>(context, listen: false)
                          .toggleFavorite(item);
                    });
                  },
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
                  onPressed: () {
                    Clipboard.setData(new ClipboardData(text: _uid));
                    Flushbar(
                      message: "Copied to Clipboard",
                      duration: Duration(seconds: 1),
                    )..show(context);
                  },
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).viewInsets.bottom,
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
              onPressed: () async {
                await logout().then((_) {
                  print('HOW?');
                  DBHelper.clear('favorite_pandals');
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacementNamed('/');
                  FirebaseAuth.instance.signOut();
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
