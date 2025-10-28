import 'package:flutter/cupertino.dart';
import '../Utilits/urls.dart';
import '../api_caller.dart';

//aikane kono UI er kaj hoi na
class AddnewtaskProvider extends ChangeNotifier {
  bool _AddTaskInprogress = false;
  String? _errorMassage;

  bool get addTaskInprogress => _AddTaskInprogress; //private method k acess korte get method use korlam
  String? get errorMassage => _errorMassage;

  Future<bool> AddnewTask(String title, String description) async {
    bool isSuccess = false; // default e false
    _AddTaskInprogress = true;
    notifyListeners(); //set state er moto kaj kore

    // request body
    Map<String, dynamic> requestBody = {
      "title":title,
      "description": description,
      "status":"New"
    };

    //  API call
    final ApiResponse response = await ApiCaller.postRequest(
        url: URLS.createtaskurl,
        body: requestBody);

    if(response.isSuccess){
      isSuccess = true;
      _errorMassage = null;
      _clearTextfield(title,description);


    }else{
    _errorMassage = response.errorMessage!;

    }

    _AddTaskInprogress = false;
    notifyListeners();

    // ✅ return the result (required)
    return isSuccess;
  }
  void _clearTextfield(String title,String description){
    title;
    description;
  }

}
