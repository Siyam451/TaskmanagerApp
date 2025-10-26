import 'package:flutter/cupertino.dart';
import '../Utilits/urls.dart';
import '../api_caller.dart';

import '../models/task_model.dart';
//aikane kono UI er kaj hoi na
class CompleteScreenProvider extends ChangeNotifier {
  bool _ComplelteInprogress = false;
  String? _errorMassage;
  List<Taskmodel> _ComplelteTaskList = [];

  bool get complelteInprogress => _ComplelteInprogress;
  List<Taskmodel> get ComplelteTaskList => _ComplelteTaskList; //private method k acess korte get method use korlam
  String? get errorMassage => _errorMassage;

  Future<bool>getCompletetask() async {
    bool isSuccess = false;
    _ComplelteInprogress = true;
    notifyListeners();
//api call
    final ApiResponse response = await ApiCaller.getRequest(url: URLS.CompletetaskListurl);
    if(response.isSuccess){
      List<Taskmodel> list = [];
      for(Map<String,dynamic> jsonData in response.responseData['data']){
        list.add(Taskmodel.fromJson(jsonData));
      }

      _ComplelteTaskList =list; // uporer gula hoile tkn compeletetasklist e list er item add hbe
    }else{
      _errorMassage = response.errorMessage!;
    }

    _ComplelteInprogress = false;
    notifyListeners();
    return isSuccess;
  }
}
