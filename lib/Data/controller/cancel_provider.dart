import 'package:flutter/cupertino.dart';
import '../Utilits/urls.dart';
import '../api_caller.dart';

import '../models/task_model.dart';
//aikane kono UI er kaj hoi na
class CancelScreenProvider extends ChangeNotifier {
  bool _CancelInprogress = false;
  String? _errorMassage;
  List<Taskmodel> _CancelTaskList = [];

  bool get cancelInprogress => _CancelInprogress;
  List<Taskmodel> get CancelTaskList => _CancelTaskList; //private method k acess korte get method use korlam
  String? get errorMassage => _errorMassage;

  Future<bool>getCanceltask() async {
    bool isSuccess = false;
    _CancelInprogress = true;
    notifyListeners();
//api call
    final ApiResponse response = await ApiCaller.getRequest(url: URLS.CanceledtaskListurl);

    if(response.isSuccess){
      List<Taskmodel> list = [];
      for(Map<String,dynamic> jsonData in response.responseData['data']) {
        list.add(Taskmodel.fromJson(jsonData));
      }

      _CancelTaskList = list;
    }else{
      _errorMassage = response.errorMessage!;
    }

    _CancelInprogress = false;
    notifyListeners();
    return isSuccess;
  }
}
