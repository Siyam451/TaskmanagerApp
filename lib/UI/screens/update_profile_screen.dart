import 'package:flutter/material.dart';
import 'package:taskmanagement/UI/screens/widget/background_image.dart';
import 'package:taskmanagement/UI/screens/widget/tmappbar.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Tmappbar(),

      body: BackgroundImage(
        child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Update Profile',style: Theme.of(context).textTheme.titleLarge),
                  SizedBox(height: 30,),

                  TextFormField(
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: 'Full Name',
                    ),
                  ),
                  SizedBox(height: 15,),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: 'First Name',
                    ),
                  ),
                  SizedBox(height: 15,),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: 'Last Name',
                    ),
                  ),

                  SizedBox(height: 15,),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: 'Email',
                    ),
                  ),

                  SizedBox(height: 15,),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: 'Mobile',
                    ),
                  ),

                  SizedBox(height: 15,),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: 'Img',
                    ),
                  ),

                  SizedBox(height: 15,),

                  FilledButton(
                      onPressed:(){}
                      , child: Icon(Icons.arrow_circle_right,)),
                ],
              ),
            ),
          ),
      ),
      );

  }
}
