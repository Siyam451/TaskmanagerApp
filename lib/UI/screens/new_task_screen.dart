//import 'package:flutter/material.dart'; import 'package:provider/provider.dart'; import 'package:taskmanagement/Data/Utilits/urls.dart'; import 'package:taskmanagement/Data/api_caller.dart'; import 'package:taskmanagement/Data/controller/add_newTask_provider.dart'; import 'package:taskmanagement/Data/models/task_status_count_model.dart'; import 'package:taskmanagement/UI/screens/add_task_screen.dart'; import 'package:taskmanagement/UI/screens/widget/center_inprogress.dart'; import 'package:taskmanagement/UI/screens/widget/snack_bar.dart'; import 'package:taskmanagement/UI/screens/widget/task_cards.dart'; import 'package:taskmanagement/UI/screens/widget/task_count_widget.dart'; class NewTaskScreen extends StatefulWidget { const NewTaskScreen({super.key}); @override State<NewTaskScreen> createState() => _NewTaskScreenState(); } class _NewTaskScreenState extends State<NewTaskScreen> { bool _statusCountInProgress = false; List<TaskStatusCountModel> _taskCountList = []; @override void initState() { super.initState(); _getAllTaskCountStatus(); context.read<NewtaskListProvider>().getnewtask(); } Future<void> _getAllTaskCountStatus() async { _statusCountInProgress = true; setState(() {}); final response = await ApiCaller.getRequest(url: URLS.taskStatusCounturl); if (response.isSuccess) { List<TaskStatusCountModel> list = []; for (Map<String, dynamic> jsonData in response.responseData['data']) { list.add(TaskStatusCountModel.fromJson(jsonData)); } _taskCountList = list; } else { ShowSnackbarMassage(context, response.errorMessage ?? "Something went wrong"); } _statusCountInProgress = false; setState(() {}); } @override Widget build(BuildContext context) { return Scaffold( body: Column( children: [ // 🔹 Top Status Count Bar SizedBox( height: 80, child: Visibility( visible: !_statusCountInProgress, replacement: const CenterInprogressbar(), child: ListView.separated( scrollDirection: Axis.horizontal, itemCount: _taskCountList.length, itemBuilder: (context, index) { return TaskCountWidget( title: _taskCountList[index].status, count: _taskCountList[index].count, ); }, separatorBuilder: (context, index) => const SizedBox(width: 12), ), ), ), // 🔹 Task List Section Expanded( child: Consumer<NewtaskListProvider>( builder: (context,newtaskprovider,_) { return Visibility( visible: newtaskprovider.AddTaskInprogress, replacement: CenterInprogressbar(), child: ListView.separated( padding: const EdgeInsets.all(8), itemCount: newtaskprovider.newTaskList.length, itemBuilder: (context, index) { return T
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmanagement/Data/Utilits/urls.dart';
import 'package:taskmanagement/Data/api_caller.dart';
import 'package:taskmanagement/Data/controller/add_newTask_provider.dart';
import 'package:taskmanagement/Data/models/task_status_count_model.dart';
import 'package:taskmanagement/UI/screens/add_task_screen.dart';
import 'package:taskmanagement/UI/screens/widget/center_inprogress.dart';
import 'package:taskmanagement/UI/screens/widget/snack_bar.dart';
import 'package:taskmanagement/UI/screens/widget/task_cards.dart';
import 'package:taskmanagement/UI/screens/widget/task_count_widget.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool _statusCountInProgress = false;
  List<TaskStatusCountModel> _taskCountList = [];

  @override
  void initState() {
    super.initState();
    _getAllTaskCountStatus();
    // Correct provider and method names
    context.read<NewtaskListProvider>().getnewtask();
  }

  Future<void> _getAllTaskCountStatus() async {
    _statusCountInProgress = true;
    setState(() {});

    final response = await ApiCaller.getRequest(url: URLS.taskStatusCounturl);

    if (response.isSuccess) {
      List<TaskStatusCountModel> list = [];
      for (Map<String, dynamic> jsonData in response.responseData['data']) {
        list.add(TaskStatusCountModel.fromJson(jsonData));
      }
      _taskCountList = list;
    } else {
      ShowSnackbarMassage(context, response.errorMessage ?? "Something went wrong");
    }

    _statusCountInProgress = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // 🔹 Top Status Count Bar
          SizedBox(
            height: 90,
            child: Visibility(
              visible: _statusCountInProgress== false,
              replacement: CenterInprogressbar(),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _taskCountList.length,
                itemBuilder: (context, index) {
                  return TaskCountWidget(
                    title: _taskCountList[index].status,
                    count: _taskCountList[index].count,
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(width: 8),
              ),
            ),
          ),

          // 🔹 Task List Section
          Expanded(
            child: Consumer<NewtaskListProvider>(
              builder: (context, newTaskProvider, _) {
                return Visibility(
                  visible: !newTaskProvider.AddTaskInprogress,
                  replacement: CenterInprogressbar(),
                  child: ListView.separated(
                    padding: const EdgeInsets.all(8),
                    itemCount: newTaskProvider.newTaskList.length,
                    itemBuilder: (context, index) {
                      return Taskcard(
                        title: 'new',
                        color: Colors.blue,
                        taskmodel: newTaskProvider.newTaskList[index],
                        refreshPerent: () {
                          context.read<NewtaskListProvider>().getnewtask();
                        },
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(height: 8),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _tapAddNewTask,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _tapAddNewTask() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddTaskScreen()),
    );
  }
}
