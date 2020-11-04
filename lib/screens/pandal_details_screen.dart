import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/pandals.dart';
import '../models/pandal.dart';

class PandalDetailsScreen extends StatelessWidget {
  static const routeName = '/pandal-details';

  @override
  Widget build(BuildContext context) {
    var pandalId = ModalRoute.of(context).settings.arguments;
    Pandal pandal = Provider.of<Pandals>(context).findById(pandalId);
    return Scaffold(
      appBar: AppBar(
        title: Text(pandal.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              pandal.imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: MediaQuery.of(context).size.height - 450,
            ),
            SizedBox(height: 10.0),
            ListTile(
              leading: Icon(
                Icons.description,
                color: Theme.of(context).primaryColor,
              ),
              title: Text(
                pandal.description,
                style: TextStyle(color: Colors.black54),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.train,
                color: Theme.of(context).primaryColor,
              ),
              title: Text(
                pandal.metro == 'NULL' ? 'None' : pandal.metro,
                style: TextStyle(color: Colors.black54),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.my_location,
                color: Theme.of(context).primaryColor,
              ),
              title: Text(
                "${pandal.category} Region",
                style: TextStyle(color: Colors.black54),
              ),
            ),
            SizedBox(height: 30),
            RaisedButton(
              elevation: 3,
              onPressed: () {
                Provider.of<Pandals>(context, listen: false)
                    .toggleFavorite(pandalId);
              },
              child: Text(
                pandal.isFavorite ? 'REMOVE FROM MAP' : 'ADD TO MAP',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              color: Colors.deepPurple[300],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
