import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmanagement/Data/controller/cancel_provider.dart';
import 'package:taskmanagement/UI/screens/widget/center_inprogress.dart';
import 'package:taskmanagement/UI/screens/widget/task_cards.dart';
import 'package:taskmanagement/UI/screens/widget/task_count_widget.dart';


class CancelScreens extends StatefulWidget {
  const CancelScreens({super.key});

  @override
  State<CancelScreens> createState() => _CancelScreensState();
}

class _CancelScreensState extends State<CancelScreens> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CancelScreenProvider>().getCanceltask();
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: const Tmappbar(), // ✅ optional, so it looks consistent
        body: Consumer<CancelScreenProvider>(
          builder: (context,cancelProvider,_) {
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ✅ Task count label
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Visibility(
                      visible:cancelProvider.cancelInprogress == false,
                      replacement: CenterInprogressbar(),
                      child: TaskCountWidget(title: 'Cancelled', count: cancelProvider.CancelTaskList.length,

                      ),
                    ),
                  ),


                  // ✅ Task list
                  Expanded(
                    child: Visibility(
                      visible: cancelProvider.cancelInprogress == false,
                      replacement: const CenterInprogressbar(),
                      child: ListView.separated(
                        itemCount: cancelProvider.CancelTaskList.length,
                        itemBuilder: (context, index) {
                          return Taskcard(
                            color: Colors.red,
                            title: 'Cancel', // better than 'Pending'
                            taskmodel: cancelProvider.CancelTaskList[index],
                            refreshPerent: () {
                           context.read<CancelScreenProvider>().getCanceltask(); // ✅ actually refresh the list
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