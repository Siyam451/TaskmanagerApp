import 'package:flutter/material.dart';
import 'package:taskmanagement/UI/screens/cancel_screens.dart';
import 'package:taskmanagement/UI/screens/complete_screens.dart';
import 'package:taskmanagement/UI/screens/progress_screen.dart';
import 'package:taskmanagement/UI/screens/widget/tmappbar.dart';

import 'new_task_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});
  static const String name = '/signup';
  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
int _SelectedIndex= 0;// kishe tap korle ki screen dekhabe er jonno aita + nicher ta kora hoise
final List<Widget> _Screens = [ //tap korle ki ki screen show korbe ta bole dewa
  NewTaskScreen(),
  ProgressScreen(),
 CancelScreens(),
CompleteScreen()
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appbar ta auto vabe so screen e set hoye gelo
      appBar: Tmappbar(),//maked a reusable widget
      body: _Screens[_SelectedIndex], // body te screens er moddhe amra ja selecte korbo ta show korbe
      bottomNavigationBar: NavigationBar(
        selectedIndex: _SelectedIndex,
        onDestinationSelected: (int index){
          _SelectedIndex = index;
          setState(() {

          });
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.new_label), label: 'New'),
          NavigationDestination(icon: Icon(Icons.refresh), label: 'Progress'),
          NavigationDestination(icon: Icon(Icons.cancel_outlined), label: 'Canceled'),
          NavigationDestination(icon: Icon(Icons.done), label: 'Complete'),
        ],
      ),

    );
  }
}

