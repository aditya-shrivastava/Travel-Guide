import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/pandals.dart';

import '../widgets/pandals_widget.dart';
import '../widgets/side_drawer.dart';

class HomeScreen extends StatefulWidget {
  static const route = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final _pandals = Provider.of<Pandals>(context).pandals;

    return Scaffold(
      appBar: AppBar(
        title: Text('Pandals'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
            color: Colors.white,
          ),
          IconButton(
            icon: Icon(
              Icons.location_on,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),
      drawer: SideDrawer(),
      body: ListView.builder(
        itemBuilder: (ctx, i) => PandalsWidget(
          _pandals[i].id,
          _pandals[i].title,
          _pandals[i].description,
          _pandals[i].imageUrl,
          _pandals[i].isFavorite,
        ),
        itemCount: _pandals.length,
      ),
    );
  }
}
