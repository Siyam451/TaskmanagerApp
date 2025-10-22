import 'package:flutter/cupertino.dart';
import '../../UI/screens/widget/snack_bar.dart';
import '../Utilits/urls.dart';
import '../api_caller.dart';
import '../auth_controller.dart';
import '../models/task_model.dart';
import '../models/user_model.dart';
//aikane kono UI er kaj hoi na
class AddNewScreenProvider extends ChangeNotifier {
  bool _AddTaskInprogress = false;
  String? _errorMassage;
  List<Taskmodel> _newTaskList = [];

  bool get AddTaskInprogress => _AddTaskInprogress; //private method k acess korte get method use korlam
  String? get errorMassage => _errorMassage;
  List<Taskmodel> get newTaskList => _newTaskList;

  Future<bool>getnewtask() async {
    bool isSuccess = false;
    _AddTaskInprogress = true;
    notifyListeners();
//api call
    final ApiResponse response = await ApiCaller.getRequest(
      url: URLS.NewtaskListurl,
    );
//ki hoile ki hbe ta
    if (response.isSuccess) {
      List<Taskmodel> list = [];

      for (Map<String, dynamic> jsonData in response.responseData['data']) {
        list.add(Taskmodel.fromJson(jsonData)); //add kore dibo
      }

      _newTaskList = list;
      isSuccess = true;
    } else {
    _errorMassage = response.errorMessage;
        }

    _AddTaskInprogress = false;
   notifyListeners();
   return isSuccess;
  }
}
