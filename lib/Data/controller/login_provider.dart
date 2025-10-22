import 'package:flutter/cupertino.dart';
import '../Utilits/urls.dart';
import '../api_caller.dart';
import '../auth_controller.dart';
import '../models/user_model.dart';
//aikane kono UI er kaj hoi na
class Loginprovider extends ChangeNotifier {
  bool _loginInprogress = false;
  String? _errorMassage;

  bool get loginInprogresss => _loginInprogress; //private method k acess korte get method use korlam
  String? get errorMassage => _errorMassage;

  Future<bool> login(String email, String password) async {
    bool isSuccess = false; // default e false
    _loginInprogress = true;
    notifyListeners(); //set state er moto kaj kore

    // request body
    Map<String, dynamic> requestBody = {
      "email": email,
      "password": password,
    };

    //  API call
    final ApiResponse response = await ApiCaller.postRequest(
      url: URLS.loginurl,
      body: requestBody,
    );

    if (response.isSuccess && response.responseData['status'] == 'success') {
      UserModel model = UserModel.fromJson(response.responseData['data']);
      String accessToken = response.responseData['token'];

      // Save user + token
      await AuthController.saveData(model, accessToken);

      _errorMassage = null;
      isSuccess = true;
    } else {
      _errorMassage = response.errorMessage;
    }

    _loginInprogress = false;
    notifyListeners();

    // ✅ return the result (required)
    return isSuccess;
  }
}
