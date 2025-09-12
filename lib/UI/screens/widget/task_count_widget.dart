import 'package:flutter/material.dart';
class TaskCountWidget extends StatelessWidget {
  const TaskCountWidget({
    super.key, required this.title, required this.count,
  });
  final String title;
  final int count ;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color:  Colors.green,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 8),
        child: Column(
          children: [
            Text('$count',style: Theme.of(context).textTheme.titleLarge),
            Text(title,style: TextStyle(color: Colors.white),),

          ],
        ),
      ),
    );
  }
}
