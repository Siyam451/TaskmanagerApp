import 'package:flutter/material.dart';
import 'package:taskmanagement/UI/screens/add_task_screen.dart';
import 'package:taskmanagement/UI/screens/widget/task_cards.dart';
import 'package:taskmanagement/UI/screens/widget/task_count_widget.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height:  80, // enough to fit your widget
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              itemBuilder: (context, index) {
                return TaskCountWidget(title: 'New', count: 2);
              },
              separatorBuilder: (context, index) => const SizedBox(width: 120),
            ),
          ),

          // Expanded List
          Expanded(
            child: ListView.separated(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Taskcard(color: Colors.blue, title: 'New',);
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 8);
              },
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


