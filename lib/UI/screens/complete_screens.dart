import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmanagement/Data/Utilits/urls.dart';
import 'package:taskmanagement/Data/api_caller.dart';
import 'package:taskmanagement/Data/controller/complete_provider.dart';
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
    context.read<CompleteScreenProvider>().getCompletetask();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: const Tmappbar(), // ✅ optional, so it looks consistent
        body: Consumer<CompleteScreenProvider>(
          builder: (context,completeProvider,_) {
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ✅ Task count label
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Visibility(
                      visible:completeProvider.complelteInprogress == false,
                      replacement: CenterInprogressbar(),
                      child: TaskCountWidget(title: 'Complete', count: completeProvider.ComplelteTaskList.length,

                      ),
                    ),
                  ),


                  // ✅ Task list
                  Expanded(
                    child: Visibility(
                      visible: completeProvider.complelteInprogress == false,
                      replacement: const CenterInprogressbar(),
                      child: ListView.separated(
                        itemCount: completeProvider.ComplelteTaskList.length,
                        itemBuilder: (context, index) {
                          return Taskcard(
                            color: Colors.purple,
                            title: 'Completed', // better than 'Pending'
                            taskmodel: completeProvider.ComplelteTaskList[index],
                            refreshPerent: () {
                              context.read<CompleteScreenProvider>().getCompletetask();  // ✅ actually refresh the list
                            },
                          );
                        },
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 8),
                      ),
                    ),
                  ),

                ]
            );
          }
        )
    );
  }
}
