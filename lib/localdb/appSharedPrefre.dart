import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';



class SharedPrefre{

  SharedPrefre._();
  static String _KEY_USER_ID = "userid";
  static String _KEY_USER_LOGIN_ACCESS_TOKEN = "loginaccesstoken";
  static String _KEY_FIREBASE_TOKEN = "devicetoken";
  static String KEY_PROFILE ="profilescreen";
  static String KEY_USER_TYPE ="userType";
  static const String onboardingCompletedKey = "onboardingCompleted";




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

  static void saveuserLoginAccessToken(String  loginaccToken) async{
    final SharedPreferences prefs = await _prefs;
    prefs.setString(_KEY_USER_LOGIN_ACCESS_TOKEN , loginaccToken);
  }

  //========>>>>> get method <<<===============\\
  static Future<String> getAuthToken()async{
    final SharedPreferences prefs = await _prefs;
    return prefs.getString(_KEY_USER_LOGIN_ACCESS_TOKEN)??"";
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


  static Future<void> saveUserType(String selectedUserType) async {

    final SharedPreferences prefs = await _prefs;
    prefs.setString(KEY_USER_TYPE , selectedUserType);

  }

  static Future<String> getUserType()async{
    final SharedPreferences prefs = await _prefs;
    return prefs.getString(KEY_USER_TYPE)??"";
  }
  static Future<void> setOnboardingCompleted(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(onboardingCompletedKey, value);
  }

  static Future<bool> isOnboardingCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(onboardingCompletedKey) ?? false;
  }


}