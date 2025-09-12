
import 'package:flutter/material.dart';

import '../update_profile_screen.dart';
class Tmappbar extends StatelessWidget implements PreferredSizeWidget {
  const Tmappbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.green,
      title: Row(
        spacing: 8,
        children: [
          GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdateProfileScreen()));
              },
              child: CircleAvatar()),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Full Name',style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.white)),
              Text('Email@gmail.com',style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.white)),
            ],
          )
        ],
      ),
      actions: [
        Icon(Icons.logout,color: Colors.red,)
      ],
    );
  }


  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);//defult vabe appbar er size nibe
}
