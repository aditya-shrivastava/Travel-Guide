import 'dart:convert';
import 'dart:async';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_config/flutter_config.dart';

import '../models/pandal.dart';
import '../providers/pandals.dart';

class MapScreen extends StatefulWidget {
  static const routeName = '/map';

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Location _locationTracker = Location();
  Marker marker;
  Circle circle;
  GoogleMapController _controller;
  Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};
  Map<CircleId, Circle> _circles = <CircleId, Circle>{};
  Map<PolylineId, Polyline> _polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPIKey = FlutterConfig.get('GOOGLE_API_KEY');
  Timer timer;

  void _addMarkerAndCircle(
    double lat,
    double lon,
    String id,
    String type,
    String title,
    String desc,
    Uint8List image,
    int count,
  ) async {
    MarkerId markerId = MarkerId(id);
    CircleId circleId = CircleId(id);

    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(lat, lon),
      draggable: false,
      zIndex: 2,
      anchor: Offset(0.5, 0.5),
      flat: true,
      icon: BitmapDescriptor.fromBytes(image),
      infoWindow: InfoWindow(title: title, snippet: desc),
    );

    Color color;
    if (count <= 20) {
      color = Colors.green.withAlpha(70);
    } else if (count <= 50) {
      color = Colors.amber.withAlpha(70);
    } else {
      color = Colors.red.withAlpha(70);
    }

    final Circle circle = Circle(
      circleId: circleId,
      radius: type == 'user' ? 80 : 800,
      zIndex: 1,
      strokeColor: Colors.green,
      center: LatLng(lat, lon),
      fillColor: color,
    );

    setState(() {
      _markers[markerId] = marker;
      _circles[circleId] = circle;
    });
  }

  Future<void> _fetchUserPandalsAndFriends() async {
    final _user = await FirebaseAuth.instance.currentUser();
    final _prefs = await SharedPreferences.getInstance();

    final _data =
        await Firestore.instance.document('/users/${_user.uid}').get();

    List<dynamic> _pandalIds = _data.data['pandals'];
    List<dynamic> _friends = _data.data['friends'];

    Pandal pandal;
    Uint8List image = await getPandalMarker();
    var count;
    _pandalIds.forEach((item) async {
      await Firestore.instance.document('/pandals/$item').get().then((doc) {
        count = doc.data['count'];
      });
      pandal = Provider.of<Pandals>(context, listen: false).findById(item);
      _addMarkerAndCircle(pandal.lat, pandal.lon, item, 'pandal', pandal.title,
          'crowd meter: $count', image, count);
    });

    if (_friends != null) {
      _friends.forEach((item) {
        _fetchFriendLocation(item);
      });
    } else {
      var friend =
          json.decode(_prefs.getString('friend')) as Map<String, dynamic>;
      _fetchFriendLocation(friend['id']);
    }
  }

  Future<void> _fetchFriendLocation(String friendId) async {
    Uint8List imageData = await getMarker();
    double latitude;
    double longitude;
    String title;
    String id = 'user';
    String description = 'friend';
    await Firestore.instance.document('/users/$friendId').get().then((doc) {
      latitude = doc.data['location']['latitude'];
      longitude = doc.data['location']['longitude'];
      title = doc.data['displayName'];
    });

    _addMarkerAndCircle(
        latitude, longitude, id, 'user', title, description, imageData, 1);
  }

  @override
  void initState() {
    _fetchUserPandalsAndFriends();
    timer = Timer.periodic(Duration(minutes: 3), (timer) {
      getCurrentLocation();
    });
    super.initState();
  }

  static final CameraPosition initialLocation =
      CameraPosition(target: LatLng(22.4288024, 88.4053954), zoom: 14.4746);

  Future<Uint8List> getMarker() async {
    ByteData byteData =
        await DefaultAssetBundle.of(context).load('assets/images/person.png');
    return byteData.buffer.asUint8List();
  }

  Future<Uint8List> getPandalMarker() async {
    ByteData byteData =
        await DefaultAssetBundle.of(context).load('assets/images/pandal.png');
    return byteData.buffer.asUint8List();
  }

  void getCurrentLocation() async {
    try {
      final _user = await FirebaseAuth.instance.currentUser();
      Uint8List imageData = await getMarker();
      var location = await _locationTracker.getLocation();

      _addMarkerAndCircle(location.latitude, location.longitude, _user.uid,
          'user', 'Me', 'user', imageData, 1);

      var locationData = {
        'latitude': location.latitude,
        'longitude': location.longitude,
      };

      _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          new CameraPosition(
            bearing: 192.8334901395799,
            target: LatLng(location.latitude, location.longitude),
            tilt: 0,
            zoom: 12.225,
          ),
        ),
      );

      await Firestore.instance
          .document('/users/${_user.uid}')
          .updateData({'location': locationData});
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        print('Permission Denied');
      }
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    _markers.clear();
    _circles.clear();
    _polylines.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map'),
      ),
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.hybrid,
            initialCameraPosition: initialLocation,
            markers: Set<Marker>.of(_markers.values),
            circles: Set<Circle>.of(_circles.values),
            polylines: Set<Polyline>.of(_polylines.values),
            onMapCreated: (GoogleMapController controller) {
              _controller = controller;
            },
          ),
          Positioned(
            bottom: 100,
            right: 10,
            child: FlatButton(
              child: Icon(
                Icons.location_searching,
                color: Colors.white,
              ),
              color: Colors.green,
              onPressed: () async {
                getCurrentLocation();
                // getPolylines();
              },
            ),
          ),
        ],
      ),
    );
  }
}
