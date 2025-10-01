import 'package:flutter/material.dart';
import 'package:taskmanagement/Data/Utilits/urls.dart';
import 'package:taskmanagement/Data/api_caller.dart';
import 'package:taskmanagement/Data/models/task_model.dart';
import 'package:taskmanagement/UI/screens/widget/center_inprogress.dart';
import 'package:taskmanagement/UI/screens/widget/snack_bar.dart';
import 'package:taskmanagement/UI/screens/widget/task_cards.dart';
import 'package:taskmanagement/UI/screens/widget/task_count_widget.dart';
import 'package:taskmanagement/UI/screens/widget/tmappbar.dart';

class CancelScreens extends StatefulWidget {
  const CancelScreens({super.key});

  @override
  State<CancelScreens> createState() => _CancelScreensState();
}

class _CancelScreensState extends State<CancelScreens> {
  List<Taskmodel> _CancelTaskList = [];
  bool _CanceltaskInProgress = false;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _getCanceltask();
  }
  
  
  Future<void> _getCanceltask() async {
    _CanceltaskInProgress = true;
    setState(() {

    });
    final ApiResponse response = await ApiCaller.getRequest(url: URLS.CanceledtaskListurl);

    if(response.isSuccess){
      List<Taskmodel> list = [];
      for(Map<String,dynamic> jsonData in response.responseData['data']) {
        list.add(Taskmodel.fromJson(jsonData));
      }

      _CancelTaskList = list;
    }else{
      ShowSnackbarMassage(context, response.errorMessage!);
    }
    _CanceltaskInProgress = false;
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
                  visible:_CanceltaskInProgress == false,
                  replacement: CenterInprogressbar(),
                  child: TaskCountWidget(title: 'Cancelled', count: _CancelTaskList.length,

                  ),
                ),
              ),


              // ✅ Task list
              Expanded(
                child: Visibility(
                  visible: _CanceltaskInProgress == false,
                  replacement: const CenterInprogressbar(),
                  child: ListView.separated(
                    itemCount: _CancelTaskList.length,
                    itemBuilder: (context, index) {
                      return Taskcard(
                        color: Colors.green,
                        title: 'Cancel', // better than 'Pending'
                        taskmodel: _CancelTaskList[index],
                        refreshPerent: () {
                          _getCanceltask(); // ✅ actually refresh the list
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
