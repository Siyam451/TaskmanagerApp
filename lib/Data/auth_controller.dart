import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskmanagement/Data/models/user_model.dart';

class AuthController {
  static const String _userTokenKey = 'token';
  static const String _userModelKey = 'user-data';

  //variable set kore korchi karon aita diye aro speedly data pawa jai
  static String? accessToken;
  static UserModel? userModel;

  Future<void> saveData(UserModel model, String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();//nijer ekta instance ready kore nilo

    // save data in shared preferences
    await sharedPreferences.setString(_userTokenKey, token);
    await sharedPreferences.setString(
      _userModelKey,
      jsonEncode(model.toJson()),//jsonencode er maddome model ta k string e convert korlam
    );

    // cache in memory
    accessToken = token;
    userModel = model;
  }

   static Future<void> getData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String? token = sharedPreferences.getString(_userTokenKey);
    if (token != null) {
      String? userData = sharedPreferences.getString(_userModelKey); //null na hoile model er data giula dibe
        userModel = UserModel.fromJson(jsonDecode(userData!));
        accessToken = token;
    }
  }
  //user ageh theke login ase naki check korar jonno
   static Future<bool> IsUserloggedIn() async{
    SharedPreferences sharedPreferences =await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString(_userTokenKey);
    return token != null;

  }

  static Future<void> clearUserData()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();// sob clear kore dibe
  }
}



