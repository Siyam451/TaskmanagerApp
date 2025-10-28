import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmanagement/Data/controller/progress_provider.dart';
import 'package:taskmanagement/Data/models/task_model.dart';
import 'package:taskmanagement/UI/screens/widget/center_inprogress.dart';

import 'package:taskmanagement/UI/screens/widget/task_cards.dart';
import 'package:taskmanagement/UI/screens/widget/task_count_widget.dart';


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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProgressScreenProvider>().getProgresstask();
    });


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: const Tmappbar(), // ✅ optional, so it looks consistent
      body: Consumer<ProgressScreenProvider>(
        builder: (context,progressProvider,_) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ✅ Task count label
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Visibility(
                  visible:progressProvider.progressInprogress == false,
                  replacement: CenterInprogressbar(),
                  child: TaskCountWidget(title: 'Progress', count: progressProvider.progressTaskList.length,

                    ),
                ),
                ),


              // ✅ Task list
              Expanded(
                child: Visibility(
                      visible: progressProvider.progressInprogress == false,
                      replacement:  CenterInprogressbar(),
                      child: ListView.separated(
                        itemCount: progressProvider.progressTaskList.length,
                        itemBuilder: (context, index) {
                          return Taskcard(
                            color: Colors.green,
                            title: 'In Progress', // better than 'Pending'
                            taskmodel: progressProvider.progressTaskList[index],
                            refreshPerent: () {
                              context.read<ProgressScreenProvider>().getProgresstask(); // ✅ actually refresh the list
                            },
                          );
                        },
                        separatorBuilder: (context, index) =>
                         SizedBox(height: 8),
                      ),
                    )

              ),

            ]
          );
        }
      )
    );
  }
}
