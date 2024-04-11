import 'package:shared_preferences/shared_preferences.dart';

const loginKey = "LOGIN_STATUS";

const userNameKey = "USERNAME";
const userHeightKey = "HEIGHT";
const userWeightKey = "WEIGHT";
const breakFastKey = "BreakFast";
const lunchKey = "BreakFast";
const dinnerKey = "Dinner";
const snackKey = "Snacks";

class LocalPreferences {
  Future setLoginBool(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(loginKey, value);
  }

  Future<bool?> getLoginBool() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(loginKey);
  }
  // ------------------------------------------------------------------

  Future setUserName(String val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(userNameKey, val);
  }

  Future<String?> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userNameKey);
  }
  // ------------------------------------------------------------------

  Future setUserHeight(String val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(userHeightKey, val);
  }

  Future<String?> getUserHeight() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userHeightKey);
  }
  // ------------------------------------------------------------------

  Future setUserWeight(String val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(userWeightKey, val);
  }

  Future<String?> getUserWeight() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userWeightKey);
  }
  // ------------------------------------------------------------------

  Future setBreakFastList(String val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(breakFastKey, val);
  }

  Future<String?> getBreakFastList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(breakFastKey);
  }
  // ------------------------------------------------------------------

  Future setLunchList(String val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(lunchKey, val);
  }

  Future<String?> getLunchList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(lunchKey);
  }

  // ------------------------------------------------------------------
  Future setDinnerList(String val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(dinnerKey, val);
  }

  Future<String?> getDinnerList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(dinnerKey);
  }

  // ------------------------------------------------------------------
  Future setSnacksList(String val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(snackKey, val);
  }

  Future<String?> getSnacksList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(snackKey);
  }
  // ------------------------------------------------------------------
}
