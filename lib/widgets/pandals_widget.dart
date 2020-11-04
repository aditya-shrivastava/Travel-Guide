import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/pandals.dart';
import '../screens/pandal_details_screen.dart';

class PandalsWidget extends StatelessWidget {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final bool isFavorite;

  PandalsWidget(
    this.id,
    this.title,
    this.description,
    this.imageUrl,
    this.isFavorite,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
        child: Card(
          elevation: 3,
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                ),
                child: GestureDetector(
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height - 480,
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      PandalDetailsScreen.routeName,
                      arguments: id,
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      '$title',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color.fromRGBO(35, 163, 203, 1),
                      ),
                    ),
                  ),
                  Consumer<Pandals>(
                    builder: (context, value, _) => IconButton(
                      iconSize: 25,
                      icon: isFavorite
                          ? Icon(
                              Icons.pin_drop,
                              color: Colors.pink,
                            )
                          : Icon(
                              Icons.pin_drop,
                              color: Colors.grey,
                            ),
                      onPressed: () =>
                          Provider.of<Pandals>(context, listen: false)
                              .toggleFavorite(id),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
