import 'package:flutter/cupertino.dart';
import '../Utilits/urls.dart';
import '../api_caller.dart';

class SetPasswordProvider extends ChangeNotifier {
  bool _setpasswordInProgress = false;
  String? _errorMessage;

  bool get SetpasswordInprogress => _setpasswordInProgress;
  String? get errorMessage => _errorMessage;

  Future<bool> postsetpassword(String email,String otp,String Setpassword) async {
    _setpasswordInProgress = true;
    notifyListeners();

    bool isSuccess = false;

    Map<String, dynamic> requestbody = {
      "email": email,
      "OTP": otp,
      "password": Setpassword,
    };


    final ApiResponse response = await ApiCaller.postRequest(
      url: URLS.RecoverResetPasswordurl,
      body: requestbody,
    );

   _setpasswordInProgress = false;
   notifyListeners();

    if (response.isSuccess) {
      isSuccess = true;

    } else {
     _errorMessage = response.errorMessage!;
    }

    return isSuccess;
  }
}
