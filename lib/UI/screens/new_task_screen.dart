import 'package:flutter/material.dart';
import 'package:taskmanagement/Data/Utilits/urls.dart';
import 'package:taskmanagement/Data/api_caller.dart';
import 'package:taskmanagement/Data/models/task_status_count_model.dart';
import 'package:taskmanagement/UI/screens/add_task_screen.dart';
import 'package:taskmanagement/UI/screens/widget/center_inprogress.dart';
import 'package:taskmanagement/UI/screens/widget/snack_bar.dart';
import 'package:taskmanagement/UI/screens/widget/task_cards.dart';
import 'package:taskmanagement/UI/screens/widget/task_count_widget.dart';

import '../../Data/models/task_model.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {

  bool _NewTaskprogress =false;
  bool _NewTaskstatuscountprogress =false;

  List<TaskStatusCountModel> _newTaskcountlist = [];
  List<Taskmodel> _newTaskList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getAlltaskCountStatus();
    _getAlltask();
  }

  Future<void> _getAlltaskCountStatus() async {
    _NewTaskstatuscountprogress = true;
    setState(() {
    });

    final ApiResponse response = await ApiCaller.getRequest(
      url: URLS.taskStatusCounturl, // 👈 matches your ApiCaller param name
    );

    if (response.isSuccess) {
      List<TaskStatusCountModel> list = [];

      for (Map<String, dynamic> jsonData in response.responseData['data']) {
        list.add(TaskStatusCountModel.fromJson(jsonData));
      }

      _newTaskcountlist = list;
    } else {
      ShowSnackbarMassage(context, response.errorMessage!);
    }
    _NewTaskstatuscountprogress = false;
    setState(() {

    });
  }

    Future<void> _getAlltask() async {
      _NewTaskprogress = true;
      setState(() {});
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

        _newTaskList = list; // ✅ assign to task list
      } else {
        ShowSnackbarMassage(context, response.errorMessage!);
      }

      _NewTaskprogress = false;
      setState(() {});
    }




    @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height:  80, // enough to fit your widget
            child: Visibility(
              visible: _NewTaskstatuscountprogress == false,
              replacement: CenterInprogressbar(),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _newTaskcountlist.length,
                itemBuilder: (context, index) {
                  return TaskCountWidget(
                    //uporer number gula s\change er jonno
                      title: _newTaskcountlist[index].status,
                      count: _newTaskcountlist[index].count
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(width: 120),
              ),
            ),
          ),

          // Expanded List
          Expanded(
            child: Visibility(
              visible: _NewTaskprogress== false,
              replacement:  CenterInprogressbar(),
              child: ListView.separated(
                itemCount: _newTaskList.length,
                itemBuilder: (context, index) {
                  return Taskcard(color: Colors.blue, title: 'New', taskmodel: _newTaskList[index],
                    refreshPerent: () {
                    _newTaskList;
                    },);
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 8);
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _TapAddNewTask();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _TapAddNewTask(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>AddTaskScreen()));
  }
}


