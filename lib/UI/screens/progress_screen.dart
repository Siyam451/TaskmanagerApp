import 'package:flutter/material.dart';
import 'package:taskmanagement/UI/screens/widget/task_cards.dart';
import 'package:taskmanagement/UI/screens/widget/tmappbar.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Taskcard(color: Colors.green, title: 'Pending',);
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 8);
              },
            ),
          ),
        ],
      ),
    );
  }
}
