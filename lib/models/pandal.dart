import 'package:flutter/foundation.dart';

class Pandal {
  final String id;
  final String title;
  final String description;
  final String category;
  final String metro;
  final double lat;
  final double lon;
  final String imageUrl;

  Pandal({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.category,
    @required this.metro,
    @required this.lat,
    @required this.lon,
    @required this.imageUrl,
  });
}
