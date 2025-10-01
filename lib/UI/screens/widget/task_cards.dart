import 'package:flutter/material.dart';
import 'package:taskmanagement/Data/Utilits/urls.dart';
import 'package:taskmanagement/Data/api_caller.dart';
import 'package:taskmanagement/Data/models/task_model.dart';
import 'package:taskmanagement/UI/screens/widget/snack_bar.dart';

class Taskcard extends StatefulWidget {
  const Taskcard({
    super.key, required this.color, required this.title, required this.taskmodel, required this.refreshPerent,
  });

  final Color color;
  final String title;

  final Taskmodel taskmodel;
  final VoidCallback refreshPerent;

  @override
  State<Taskcard> createState() => _TaskcardState();
}

class _TaskcardState extends State<Taskcard> {
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
                widget.taskmodel.title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
               SizedBox(height: 4),
               Text(widget.taskmodel.description),
               SizedBox(height: 8),
               Text(
               'Date : ${widget.taskmodel.createddate}' ,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Chip(
                    label: Text(widget.title),
                    backgroundColor: widget.color,
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                   _getDelete();
                    },
                    icon: const Icon(Icons.delete, color: Colors.grey),
                  ),
                  IconButton(
                    onPressed: () {
                    _ShowchangestatusDialog(); //edit e click korle alertdialog show korbe
                    },
                    icon: const Icon(Icons.edit, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  void _ShowchangestatusDialog(){
    showDialog(context: context, builder: (ctx){
      return AlertDialog(
        title: Text('Change Status'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              onTap: (){
                _changeStatus('New');
              },
              title: Text('New'),
              trailing: widget.taskmodel.status == 'New' ? Icon(Icons.done) : null // new te tap korle done dekhabe ar na hoi null dekhabe
            ),

            ListTile(
                onTap: (){
                  _changeStatus('Progress');
                },
                title: Text('Progress'),
                trailing: widget.taskmodel.status == 'Progress' ? Icon(Icons.done) : null // new te tap korle done dekhabe ar na hoi null dekhabe
            ),

            ListTile(
                onTap: (){
                  _changeStatus('Cancelled');
                },
                title: Text('Cancelled'),
                trailing: widget.taskmodel.status == 'Cancelled' ? Icon(Icons.done) : null // new te tap korle done dekhabe ar na hoi null dekhabe
            ),

            ListTile(
                onTap: (){
                  _changeStatus('Completed'); //tap korle aitar kaj korbe
                },
                title: Text('Completed'),
                trailing: widget.taskmodel.status == 'Completed' ? Icon(Icons.done) : null // new te tap korle done dekhabe ar na hoi null dekhabe
            )
          ],
        ),
      );
    });
  }
  
  Future<void> _changeStatus(String status)async{
    if(status == widget.taskmodel.status){ //jate same jinish e tap korle abr new kono kichu na kore
      return;
    }
    //calling api
    final ApiResponse response = await ApiCaller.getRequest(url: URLS.Updatetaskstatusurl(
        widget.taskmodel.id, status)
    );
    if(response.isSuccess){
      Navigator.pop(context);
      widget.refreshPerent();
      ShowSnackbarMassage(context, 'Updated Successfully');
    }else{
      ShowSnackbarMassage(context, response.errorMessage!);
    }
  }


  //for delete

void _getDelete(){
    showDialog(context: context, builder: (ctx)=>
    AlertDialog(
      title: Text('Sure want to delete?'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            onTap: () {
              _changedeleteStatus();
            },

            title: Text('Yes'),
            trailing: widget.taskmodel.status == 'Delete' ? Icon(Icons.done) : null ,
          ),
          ListTile(
            onTap: (){
              Navigator.pop(context);
            },
            title: Text('No'),
          ),
        ],
      ),
    )
    );
}


Future<void> _changedeleteStatus()async{
  // if(status == widget.taskmodel.status){ //jate same jinish e tap korle abr new kono kichu na kore
  //   return;
  // }
    final ApiResponse response = await ApiCaller.getRequest(

        url: URLS.Deletetaskstatusurl(widget.taskmodel.id));

  if(response.isSuccess){
    Navigator.pop(context);
    widget.refreshPerent();
    ShowSnackbarMassage(context, 'Deleted successfully');

  }else{
    ShowSnackbarMassage(context, response.errorMessage!);
  }
}
}
