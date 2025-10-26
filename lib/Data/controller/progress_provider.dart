import 'package:flutter/cupertino.dart';
import '../Utilits/urls.dart';
import '../api_caller.dart';

import '../models/task_model.dart';
//aikane kono UI er kaj hoi na
class ProgressScreenProvider extends ChangeNotifier {
  bool _progressInprogress = false;
  String? _errorMassage;
  List<Taskmodel> _progressTaskList = [];

  bool get progressInprogress => _progressInprogress;
  List<Taskmodel> get progressTaskList => _progressTaskList; //private method k acess korte get method use korlam
  String? get errorMassage => _errorMassage;


  Future<bool>getProgresstask() async {
    bool isSuccess = false;
    _progressInprogress = true;
    notifyListeners();
//api call
    final ApiResponse response = await ApiCaller.getRequest(
      url: URLS.ProgresstaskListurl,
    );
//ki hoile ki hbe ta
    if (response.isSuccess) {
      List<Taskmodel> list = [];
      for (Map<String, dynamic> jsonData in response.responseData['data']) {
        list.add(Taskmodel.fromJson(jsonData));
      }
      _progressTaskList = list;
    } else {
      _errorMassage = response.errorMessage!;
    }

    _progressInprogress = false;
    notifyListeners();
    return isSuccess;
  }
}
