import 'package:flutter/material.dart';
import 'package:taskmanagement/UI/screens/widget/task_cards.dart';
import 'package:taskmanagement/UI/screens/widget/tmappbar.dart';

class CompleteScreen extends StatefulWidget {
  const CompleteScreen({super.key});

  @override
  State<CompleteScreen> createState() => _CompleteScreenState();
}

class _CompleteScreenState extends State<CompleteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Taskcard(color: Colors.purple, title: 'Complete',);
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
