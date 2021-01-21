import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flushbar/flushbar.dart';

import '../screens/pandal_details_screen.dart';

import '../helpers/db_helper.dart';
import '../models/pandal.dart';
import '../providers/pandals.dart';

class FavoritePandals extends StatefulWidget {
  static const routeName = '/favorites';

  @override
  _FavoritePandalsState createState() => _FavoritePandalsState();
}

class _FavoritePandalsState extends State<FavoritePandals> {
  List<Pandal> _favoritePandals;

  Future<void> _fetchPandals() async {
    List<Pandal> _data = await Provider.of<Pandals>(context, listen: false)
        .fetchFavoritePandals();
    setState(() {
      _favoritePandals = _data == null ? [] : _data;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchPandals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Pandals'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              _favoritePandals.forEach((item) async {
                Provider.of<Pandals>(context, listen: false)
                    .toggleFavorite(item.id);
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
              await DBHelper.clear('favorite_pandals');
              Flushbar(
                message: 'Pandals Deleted Successfully',
                duration: Duration(seconds: 2),
              )..show(context);
              setState(() {
                _favoritePandals = [];
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () async {
              if (_favoritePandals.isEmpty) {
                return;
              }
              final user = await FirebaseAuth.instance.currentUser();
              List<String> pandalsData = [];
              _favoritePandals.forEach((element) async {
                pandalsData.add(element.id);
                await Firestore.instance
                    .document('/pandals/${element.id}')
                    .get()
                    .then((doc) {
                  var count = doc.data['count'];
                  count = count + 1;
                  Firestore.instance
                      .document('/pandals/${element.id}')
                      .updateData({'count': count});
                });
              });
              try {
                await Firestore.instance
                    .document('users/${user.uid}')
                    .updateData({'pandals': pandalsData}).then((_) {
                  Flushbar(
                    message: 'Pandals Added Successfully',
                    duration: Duration(seconds: 2),
                  )..show(context);
                });
              } catch (err) {
                print(err);
              }
            },
          )
        ],
      ),
      body: _favoritePandals == null
          ? Center(
              child: Text('No Pandals Added'),
            )
          : ListView.builder(
              itemBuilder: (ctx, i) => Dismissible(
                direction: DismissDirection.endToStart,
                onDismissed: (direction) => {
                  Provider.of<Pandals>(context, listen: false)
                      .toggleFavorite(_favoritePandals[i].id)
                },
                background: Container(
                  padding: const EdgeInsets.only(right: 10.0),
                  alignment: Alignment.centerRight,
                  color: Colors.red,
                  child: Icon(Icons.delete, color: Colors.white, size: 20),
                ),
                key: Key(_favoritePandals[i].id),
                child: Container(
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(_favoritePandals[i].title),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.info_outline,
                          color: Color.fromRGBO(0, 0, 0, 0.4),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                            PandalDetailsScreen.routeName,
                            arguments: _favoritePandals[i].id,
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
              itemCount: _favoritePandals.length,
            ),
    );
  }
}
