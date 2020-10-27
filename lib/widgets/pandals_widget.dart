import 'package:flutter/material.dart';

import '../screens/pandal_details_screen.dart';

class PandalsWidget extends StatefulWidget {
  final String id;
  final String title;
  final String description;
  final String imageUrl;

  PandalsWidget(
    this.id,
    this.title,
    this.description,
    this.imageUrl,
  );

  @override
  _PandalsWidgetState createState() => _PandalsWidgetState();
}

class _PandalsWidgetState extends State<PandalsWidget> {
  var _added = false;

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
                      widget.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      PandalDetailsScreen.routeName,
                      arguments: widget.id,
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
                      '${widget.title}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color.fromRGBO(35, 163, 203, 1),
                      ),
                    ),
                  ),
                  IconButton(
                    iconSize: 25,
                    icon: _added
                        ? Icon(
                            Icons.bookmark,
                            color: Colors.pink,
                          )
                        : Icon(
                            Icons.bookmark_border,
                            color: Colors.grey,
                          ),
                    onPressed: () {
                      setState(() {
                        _added = !_added;
                      });
                    },
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
