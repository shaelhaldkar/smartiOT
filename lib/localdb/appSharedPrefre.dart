import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';



class SharedPrefre{

  SharedPrefre._();
  static String _KEY_USER_ID = "userid";
  static String _KEY_USER_LOGIN_ACCESS_TOKEN = "loginaccesstoken";
  static String _KEY_FIREBASE_TOKEN = "devicetoken";
  static String KEY_PROFILE ="profiledata";
  static String KEY_NAME="name";




  static Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  //==========>>>> save detail method<<<<<=============\\

  static void saveProfile(Map<String, dynamic> profile) async{
    final SharedPreferences prefs = await _prefs;
    prefs.setString(KEY_PROFILE , jsonEncode(profile));
  }


  static void saveUserId(String  uid) async{
    final SharedPreferences prefs = await _prefs;
    prefs.setString(_KEY_USER_ID , uid);
  }

  static void saveUserName(String  uid) async{
    final SharedPreferences prefs = await _prefs;
    prefs.setString(KEY_NAME , uid);
  }

  static void saveuserLoginAccessToken(String  loginaccToken) async{
    final SharedPreferences prefs = await _prefs;
    prefs.setString(_KEY_USER_LOGIN_ACCESS_TOKEN , loginaccToken);
  }

  //========>>>>> get method <<<===============\\
  static Future<String> getAuthToken()async{
    final SharedPreferences prefs = await _prefs;
    return prefs.getString(_KEY_USER_LOGIN_ACCESS_TOKEN)??"";
  }
  static Future<String> getName()async{
    final SharedPreferences prefs = await _prefs;
    return prefs.getString(KEY_NAME)??"";
  }


  static Future<String> getUserId()async{
    final SharedPreferences prefs = await _prefs;
    return prefs.getString(_KEY_USER_ID)??'';
  }
  static Future<Map<String, dynamic>?> getUserProfile() async {
    final SharedPreferences prefs = await _prefs;
    final profileString = prefs.getString(KEY_PROFILE);
    if (profileString != null) {
      return jsonDecode(profileString);
    }
    return null;
  }
  static Future<void> clearSharedPre() async {
    final SharedPreferences prefs = await _prefs;
    await prefs.clear();
  }

  static Future<void> saveDeviceToken(String deviceToken) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString(_KEY_FIREBASE_TOKEN , deviceToken);

  }
  static Future<String> getDeviceToken()async{
    final SharedPreferences prefs = await _prefs;
    return prefs.getString(_KEY_FIREBASE_TOKEN)??"";
  }





}