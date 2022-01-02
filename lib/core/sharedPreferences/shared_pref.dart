import 'package:fusteka_icecreem/core/hooks/hooks.dart';

class SharedPref{

  late SharedPreferences prefs;

  clear() async {
    prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  Future<String?> getUserId() async {
    prefs = await SharedPreferences.getInstance();
    String? intValue = prefs.getString('userid')??'';
    return intValue;
  }

  setUserId(String? userId) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString('userid', userId!);
  }

  Future<String?> getToken() async {
    prefs = await SharedPreferences.getInstance();
    String? stringValue = prefs.getString('token')??'';
    return stringValue;
  }

  setToken(String? token) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token!);
  }

  Future<String?> getLang() async {
    prefs = await SharedPreferences.getInstance();
    String? stringValue = prefs.getString('lang')??'en';
    return stringValue;
  }

  setLang(String? lang) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString('lang', lang!);
  }

  Future<bool?> getIsUserActive() async {
    prefs = await SharedPreferences.getInstance();
    bool? boolValue = prefs.getBool('isUserActive')??false;
    return boolValue;
  }

  setIsUserActive(bool value) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setBool('isUserActive', value);
  }

  Future<bool?> getIsForgotPass() async {
    prefs = await SharedPreferences.getInstance();
    bool? boolValue = prefs.getBool('isForgotPass')??false;
    return boolValue;
  }

  setIsForgotPass(bool value) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setBool('isForgotPass', value);
  }

  Future<bool?> getIsEngActive() async {
    prefs = await SharedPreferences.getInstance();
    bool? boolValue = prefs.getBool('isEngActive')??true;
    return boolValue;
  }

  setIsEngActive(bool value) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setBool('isEngActive', value);
  }
}