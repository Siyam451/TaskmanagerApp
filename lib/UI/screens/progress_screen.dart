import 'package:flutter/material.dart';
import 'package:taskmanagement/Data/Utilits/urls.dart';
import 'package:taskmanagement/Data/api_caller.dart';
import 'package:taskmanagement/Data/models/task_model.dart';
import 'package:taskmanagement/UI/screens/widget/center_inprogress.dart';
import 'package:taskmanagement/UI/screens/widget/snack_bar.dart';
import 'package:taskmanagement/UI/screens/widget/task_cards.dart';
import 'package:taskmanagement/UI/screens/widget/task_count_widget.dart';
import 'package:taskmanagement/UI/screens/widget/tmappbar.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  bool _getProgressTaskInprogress = false;
  List<Taskmodel> _progressTaskList = [];

  @override
  void initState() {
    super.initState();
    _getPrgressTask();
  }

  Future<void> _getPrgressTask() async {
    _getProgressTaskInprogress = true;
    setState(() {});

    final ApiResponse response =
    await ApiCaller.getRequest(url: URLS.ProgresstaskListurl);

    if (response.isSuccess) {
      List<Taskmodel> list = [];
      for (Map<String, dynamic> jsonData in response.responseData['data']) {
        list.add(Taskmodel.fromJson(jsonData));
      }
      _progressTaskList = list;
    } else {
      ShowSnackbarMassage(context, response.errorMessage!);
    }

    _getProgressTaskInprogress = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: const Tmappbar(), // ✅ optional, so it looks consistent
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ✅ Task count label
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Visibility(
              visible:_getProgressTaskInprogress == false,
              replacement: CenterInprogressbar(),
              child: TaskCountWidget(title: 'Progress', count: _progressTaskList.length,

                ),
            ),
            ),


          // ✅ Task list
          Expanded(
            child: Visibility(
              visible: _getProgressTaskInprogress == false,
              replacement: const CenterInprogressbar(),
              child: ListView.separated(
                itemCount: _progressTaskList.length,
                itemBuilder: (context, index) {
                  return Taskcard(
                    color: Colors.green,
                    title: 'In Progress', // better than 'Pending'
                    taskmodel: _progressTaskList[index],
                    refreshPerent: () {
                      _getPrgressTask(); // ✅ actually refresh the list
                    },
                  );
                },
                separatorBuilder: (context, index) =>
                 SizedBox(height: 8),
              ),
            ),
          ),

        ]
      )
    );
  }
}
