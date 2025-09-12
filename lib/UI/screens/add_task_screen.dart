import 'package:flutter/material.dart';
import 'package:taskmanagement/UI/screens/widget/background_image.dart';
import 'package:taskmanagement/UI/screens/widget/tmappbar.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
 final TextEditingController _titleTEcontroller = TextEditingController();
  final TextEditingController _descriptionTEcontroller = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Tmappbar(),
      body: BackgroundImage(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
             child: Form(
               key: _formkey,
               child: Column(
                 crossAxisAlignment:  CrossAxisAlignment.start,
                 children: [

                   Text('Add New Task',style: Theme.of(context).textTheme.titleLarge),
                   SizedBox(height: 40,),
                   TextFormField(
                     controller: _titleTEcontroller,
                     textInputAction: TextInputAction.next,
                     decoration: InputDecoration(
                       hintText: 'Title',

                     ),
                   ),
                   SizedBox(height: 10,),
                   TextFormField(
                     textInputAction: TextInputAction.next,
                     maxLines: 6,
                     decoration: InputDecoration(
                       hintText: 'Description',
                     ),
                   ),
                   SizedBox(
                     height: 10,
                   ),
                   FilledButton(onPressed: (){}, child: Text('Add'))

                 ],
               ),
             )


              ),
    )


          )


    );
  }
}
