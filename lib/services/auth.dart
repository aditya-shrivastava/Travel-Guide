import 'dart:convert';
import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/http_exception.dart';

class AuthService with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;
  String _userName;
  final String apiKey = DotEnv().env['FIREBASE_API_KEY'];

  Timer _authTimer;

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }

    return null;
  }

  Future<void> _authenticate(
    String email,
    String password,
    String urlSegment,
  ) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/$urlSegment?key=$apiKey';

    try {
      final response = await http.post(
        url,
        body: json.encode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }),
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responseData['expiresIn'],
          ),
        ),
      );
      notifyListeners();
      _autoLogout();
    } catch (error) {
      throw error;
    }
  }

  Future<void> signup(String email, String password, String name) async {
    await _authenticate(email, password, 'accounts:signUp');
    final url = 'https://flutter-travel-guide.firebaseio.com/users.json';
    var userData = {
      'name': name,
      'email': email,
      'imageUrl': null,
      'location': null,
      'pandals': [],
    };
    _userName = name;
    final response = await http.post(url, body: json.encode(userData));
    final data = json.decode(response.body);
    final uid = data['name'];
    // _userId = uid;
    print(uid);
  }

  Future<void> login(String email, String password) async {
    await _authenticate(email, password, 'accounts:signInWithPassword');
    final _prefs = await SharedPreferences.getInstance();
    var userData = json.encode({
      'name': _userName,
      'token': _token,
      'userId': _userId,
      'expiryDate': _expiryDate.toIso8601String(),
    });
    _prefs.setString('userData', userData);
  }

  Future<bool> tryAutoLogin() async {
    final _prefs = await SharedPreferences.getInstance();
    if (!_prefs.containsKey('userData')) {
      return false;
    }
    final _extractedData =
        json.decode(_prefs.getString('userData')) as Map<String, Object>;
    var expiryDate = DateTime.parse(_extractedData['expiryDate']);
    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }

    _token = _extractedData['token'];
    _userName = _extractedData['name'];
    _userId = _extractedData['userId'];
    _expiryDate = expiryDate;
    notifyListeners();
    _autoLogout();
    return true;
  }

  Future<void> logout() async {
    final _prefs = await SharedPreferences.getInstance();
    _prefs.clear();
    _token = null;
    _userId = null;
    _expiryDate = null;
    _userName = null;

    notifyListeners();
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }
  }

  Future<void> _autoLogout() async {
    if (_authTimer != null) {
      _authTimer.cancel();
    }
    Timer(
      Duration(seconds: _expiryDate.difference(DateTime.now()).inSeconds),
      logout,
    );
  }
}
