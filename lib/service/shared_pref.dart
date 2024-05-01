import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper{

  static String userIdKey="USERKEY";
  static String userNameKey="USERNAMEKEY";
  static String userEmailKey="USEREMAILKEY";
  static String userWalletKey="USERWALLETKEY";
  static String userProfileKey="USERPROFILEKEY";
  static String userLoginKey="USERLOGINKEY";

 //<============================================Setters===============================================================================>
  Future<bool> saveUserId(String getUserId) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userIdKey, getUserId);
  }
  Future<bool> saveUserName(String getUserName) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userNameKey, getUserName);
  }
  Future<bool> saveUserEmail(String getUserEmail) async
  {
    print("emil kEy Saved ${getUserEmail}");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userEmailKey, getUserEmail);
  }
  Future<bool> saveUserWallet(String getUserWallet) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userWalletKey, getUserWallet);
  }
  Future<bool> saveUserProfile(String getUserProfile) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userProfileKey, getUserProfile);
  }

  Future<bool> saveLoginKey(String getUserLoginKey) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userLoginKey, getUserLoginKey);
  }


//<============================================Getters===============================================================================>



  Future<String?> getLoginKey() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userLoginKey);
  }

  Future<String?> getUserId() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userIdKey);
  }

Future<String?> getUserName() async
{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString(userNameKey);
}
  Future<String?> getUserEmail() async
  {
    print("emil kEy Got ${getUserEmail}");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userEmailKey);
  }

  Future<String?> getUserWallet() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userWalletKey);
  }

  Future<String?> getUserProfile() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userProfileKey);
  }
}