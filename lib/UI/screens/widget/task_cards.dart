import 'package:flutter/material.dart';

class Taskcard extends StatelessWidget {
  const Taskcard({
    super.key,
   required this.color, required this.title,
  });

  final Color color;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: SizedBox(
        height: 170,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Title of the task',
                style: Theme.of(context).textTheme.titleMedium,
              ),
               SizedBox(height: 4),
               Text('Description of the task'),
               SizedBox(height: 8),
               Text(
                'Date: 1/2/22',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Chip( //chip diye button er moto kore ekta text banano jai
                    label:  Text(title),
                    backgroundColor:color
                  ),
                   Spacer(),//auto space create kore
                  IconButton(
                    onPressed: () {},
                    icon:  Icon(Icons.delete, color: Colors.grey),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon:  Icon(Icons.edit, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
