import 'package:flutter/material.dart';
import 'package:taskmanagement/UI/screens/widget/task_cards.dart';
import 'package:taskmanagement/UI/screens/widget/tmappbar.dart';

class CancelScreens extends StatefulWidget {
  const CancelScreens({super.key});

  @override
  State<CancelScreens> createState() => _CancelScreensState();
}

class _CancelScreensState extends State<CancelScreens> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Taskcard(color: Colors.red, title: 'Cancel',);
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
