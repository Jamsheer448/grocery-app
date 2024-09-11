import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';

class Store {
  const Store._();
  static const String _fcmtokenKey = "FCMTOKEN";
  static const String _tokenKey = "TOKEN";
  static const String _usernameKey = "username";
  static const String _mrpnoteKey = "mrpnote";
  static const String _isLoggedIn = "isLoggedIn";

  //fcm
  static Future<void> setfcmToken(String token) async {
    log("token added");
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_fcmtokenKey, token);
  }

  static Future<String?> getfcmToken() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(_fcmtokenKey);
  }

//token
  static Future<void> setToken(String token) async {
    log("token added");
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_tokenKey, token);
  }

  static Future<String?> getToken() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(_tokenKey);
  }

//isLoggedIn
  static Future<void> setLoggedIn(String loggedvalue) async {
    log("logged added");
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_isLoggedIn, loggedvalue);
  }

  static Future<String?> getLoggedIn() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(_isLoggedIn);
  }

//username
  static Future<void> setUsername(String username) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_usernameKey, username);
    log("sp username $getUsername");
  }

  static Future<String?> getUsername() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(_usernameKey);
  }
  

//mrpnote
  static Future<void> setMrpnote(String note) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_mrpnoteKey, note);
  }

  static Future<String?> getMrpnote() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(_mrpnoteKey);
  }

  static Future<void> clear() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }
}