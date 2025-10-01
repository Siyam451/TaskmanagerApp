import 'package:flutter/material.dart';
import 'package:taskmanagement/Data/Utilits/urls.dart';
import 'package:taskmanagement/Data/api_caller.dart';
import 'package:taskmanagement/UI/screens/widget/center_inprogress.dart';
import 'package:taskmanagement/UI/screens/widget/snack_bar.dart';
import 'package:taskmanagement/UI/screens/widget/task_cards.dart';
import 'package:taskmanagement/UI/screens/widget/task_count_widget.dart';
import 'package:taskmanagement/UI/screens/widget/tmappbar.dart';

import '../../Data/models/task_model.dart';

class CompleteScreen extends StatefulWidget {
  const CompleteScreen({super.key});

  @override
  State<CompleteScreen> createState() => _CompleteScreenState();
}

class _CompleteScreenState extends State<CompleteScreen> {
  List<Taskmodel> _completedTaskList =[];
  bool _CompletedtaskInProgress = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCompleteTask();
  }


  Future<void> _getCompleteTask()async{
    _CompletedtaskInProgress = true;
    setState(() {

    });
    final ApiResponse response = await ApiCaller.getRequest(url: URLS.CompletetaskListurl);
    if(response.isSuccess){
      List<Taskmodel> list = [];
      for(Map<String,dynamic> jsonData in response.responseData['data']){
        list.add(Taskmodel.fromJson(jsonData));
      }

      _completedTaskList =list; // uporer gula hoile tkn compeletetasklist e list er item add hbe
    }else{
      ShowSnackbarMassage(context, response.errorMessage!);
    }
    _CompletedtaskInProgress = false;
    setState(() {

    });
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
                  visible:_CompletedtaskInProgress == false,
                  replacement: CenterInprogressbar(),
                  child: TaskCountWidget(title: 'Complete', count: _completedTaskList.length,

                  ),
                ),
              ),


              // ✅ Task list
              Expanded(
                child: Visibility(
                  visible: _CompletedtaskInProgress == false,
                  replacement: const CenterInprogressbar(),
                  child: ListView.separated(
                    itemCount: _completedTaskList.length,
                    itemBuilder: (context, index) {
                      return Taskcard(
                        color: Colors.green,
                        title: 'Completed', // better than 'Pending'
                        taskmodel: _completedTaskList[index],
                        refreshPerent: () {
                          _getCompleteTask(); // ✅ actually refresh the list
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
