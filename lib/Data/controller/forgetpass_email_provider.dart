import 'package:flutter/cupertino.dart';
import '../Utilits/urls.dart';
import '../api_caller.dart';

class ForgetpassEmailProvider extends ChangeNotifier {
  bool _forgetEmailInProgress = false;
  String? _errorMessage;

  bool get forgetEmailInProgress => _forgetEmailInProgress;
  String? get errorMessage => _errorMessage;

  Future<bool> getForgetEmailTask(String email) async {
    _forgetEmailInProgress = true;
    notifyListeners();

    bool isSuccess = false;

    try {
      final String url = URLS.RecoverVerifyEmailurl(Uri.encodeComponent(email));
      final ApiResponse response = await ApiCaller.getRequest(url: url);

      if (response.isSuccess) {
 //successyfully verified
        isSuccess = true;
      } else {

        _errorMessage = response.errorMessage ?? 'Something went wrong';
      }
    } catch (e) {

      _errorMessage = e.toString();
    } finally {
      _forgetEmailInProgress = false;
      notifyListeners();
    }

    return isSuccess;
  }
}
