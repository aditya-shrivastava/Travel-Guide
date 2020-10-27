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
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height - 440,
              child: Image.network(pandal.imageUrl, fit: BoxFit.cover),
            ),
            SizedBox(height: 10.0),
            Text("Description: ${pandal.description}"),
            SizedBox(height: 10.0),
            Text("Metro: ${pandal.metro}"),
            SizedBox(height: 10.0),
            Text("Region: ${pandal.category}"),
            SizedBox(height: 10.0),
            FlatButton(
              onPressed: () {},
              child: Text(
                'ADD TO MAP',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              color: Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }
}
