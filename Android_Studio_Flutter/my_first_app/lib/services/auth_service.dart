
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends ChangeNotifier
{
  static late final SharedPreferences _prefs;

  static init()  async
  {
  _prefs= await SharedPreferences.getInstance();

  }

  Future<void> loginUser(String userName) async
  {
    try {

      _prefs.setString('userName', userName);
    }
  catch(e)
  {
    print(e);
  }}


  void logoutUser()
  {

    _prefs.clear();
  }

  void updateUserName(String newName)
  {
    _prefs.setString('userName', newName);
  }

 String? getUserName()
  {

    return _prefs.getString('userName') ?? 'Default Value';
    notifyListeners();

  }

  Future<bool> isLoggedIn() async
  {
    String? username =await _prefs.getString('userName');
    if(username==null)
      return false;
    return true;
  }
}