import 'package:flutter/material.dart';
import 'package:taskmanagement/Data/Utilits/urls.dart';
import 'package:taskmanagement/Data/api_caller.dart';
import 'package:taskmanagement/UI/screens/widget/background_image.dart';
import 'package:taskmanagement/UI/screens/widget/center_inprogress.dart';
import 'package:taskmanagement/UI/screens/widget/snack_bar.dart';
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
  bool _addNewInprogress = false;

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
                     validator: (String ? value){
                       if(value?.trim().isEmpty ?? true){
                         return 'Enter your title';
                       }else{
                         return null;
                       }
                     }
                   ),
                   SizedBox(height: 10,),
                   TextFormField(
                     textInputAction: TextInputAction.next,
                     maxLines: 6,
                     decoration: InputDecoration(
                       hintText: 'Description',
                     ),
                       validator: (String ? value){
                         if(value?.trim().isEmpty ?? true){
                           return 'Enter your description';
                         }else{
                           return null;
                         }
                       }
                   ),
                   SizedBox(
                     height: 10,
                   ),
                   Visibility(

                       visible: _addNewInprogress == false,
                       replacement: CenterInprogressbar(),
                       child: FilledButton(onPressed: _AddTaskbutton, child: Text('Add')))

                 ],
               ),
             )


              ),
    )


          )


    );
  }


  void _AddTaskbutton(){

    if(_formkey.currentState!.validate()){
      _addNewTask();
    }
  }


  Future<void> _addNewTask()async{
    _addNewInprogress =true;
    setState(() {

    });
    Map<String,dynamic> requestbody = {

      "title":_titleTEcontroller.text.trim(),
      "description": _descriptionTEcontroller.text.trim(),
      "status":"New"
    };
    
    final ApiResponse response = await ApiCaller.postRequest(
        url: URLS.createtaskurl,
        body: requestbody);

    _addNewInprogress =false;
    setState(() {

    });

    if(response.isSuccess){
      _clearTextfield();
      ShowSnackbarMassage(context, 'New task added');
      Navigator.pop(context,true);
    }else{
      ShowSnackbarMassage(context, response.errorMessage!);

    }

  }

  void _clearTextfield(){
    _titleTEcontroller.clear();
    _descriptionTEcontroller.clear();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _titleTEcontroller.dispose();
    _descriptionTEcontroller.dispose();
  }
}
