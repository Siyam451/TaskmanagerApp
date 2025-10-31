import 'package:flutter/cupertino.dart';
import '../Utilits/urls.dart';
import '../api_caller.dart';

class PinverificationProvider extends ChangeNotifier {
  bool _PinverificationInProgress = false;
  String? _errorMessage;

  bool get forgetEmailInProgress => _PinverificationInProgress;
  String? get errorMessage => _errorMessage;

  Future<bool> getverifyotp(String email,String otp) async {
    _PinverificationInProgress = true;
    notifyListeners();

    bool isSuccess = false;

    try{
      if (otp.isEmpty) {
        _errorMessage = 'Please enter the OTP';
        _PinverificationInProgress = false;
        notifyListeners();
        return false;
      }
      _PinverificationInProgress = true;
      _errorMessage = null;
      notifyListeners();

      final String url = URLS.RecoverVerifyOtpurl(email, otp);
      final ApiResponse response = await ApiCaller.getRequest(url: url);

      if(response.isSuccess){
      isSuccess = true;
      }else{
       _errorMessage = response.errorMessage!;
      }
    } catch(e){
    _errorMessage = e.toString();

    }finally {
      _PinverificationInProgress = false;
     notifyListeners();
    }

    return isSuccess;
  }
}
