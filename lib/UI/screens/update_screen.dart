import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:taskmanagement/Data/Utilits/urls.dart';
import 'package:taskmanagement/Data/api_caller.dart';
import 'package:taskmanagement/UI/screens/widget/background_image.dart';
import 'package:taskmanagement/UI/screens/widget/center_inprogress.dart';
import 'package:taskmanagement/UI/screens/widget/snack_bar.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({super.key});
  static const String name = '/signup';

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  final TextEditingController _EmailTEcontroller = TextEditingController();
  final TextEditingController _FirstNameTEcontroller = TextEditingController();
  final TextEditingController _LastNameTEcontroller = TextEditingController();
  final TextEditingController _MobileTEcontroller = TextEditingController();
  final TextEditingController _PasswordTEcontroller = TextEditingController();
  final GlobalKey<FormState> _updateformkey = GlobalKey<FormState>();
   bool _signInprogress = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundImage(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _updateformkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 85),
                    Text('Join With Us',style: Theme.of(context).textTheme.titleLarge),//defult vabe sob kane size ta koto hbe set kora
                    SizedBox(height: 15,),
                    TextFormField(
                      controller: _EmailTEcontroller,
                      decoration: InputDecoration(
                        hintText: 'Email',
                      ),
                      validator: (String?value){
                        if(value?.trim().isEmpty ?? true){
                          return 'Enter a valid Email';
                        }
                        return null;
                      }
                    ),
                    SizedBox(height: 15,),
                    TextFormField(
                      controller: _FirstNameTEcontroller,
                      decoration: InputDecoration(
                        hintText: 'First Name',
                      ),
                        validator: (String?value){
                          if(value?.trim().isEmpty ?? true){
                            return 'Enter a valid First Name';
                          }
                          return null;
                        }
                    ),
                    SizedBox(height: 15,),
                    TextFormField(
                      controller: _LastNameTEcontroller,
                      decoration: InputDecoration(
                        hintText: 'Last Name',
                      ),
                        validator: (String?value){
                          if(value?.trim().isEmpty ?? true){
                            return 'Enter a valid Last Name';
                          }
                          return null;
                        }
                    ),
                    SizedBox(height: 15,),
                    TextFormField(
                      controller: _MobileTEcontroller,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Mobile',
                      ),
                        validator: (String?value){
                          if((value?.trim().length ?? 0) < 11){
                            return 'Enter a valid Number';
                          }
                          return null;
                        }
                    ),
                    SizedBox(height: 15,),
                    TextFormField(
                      controller: _PasswordTEcontroller,
                      decoration: InputDecoration(
                          hintText: 'Password'
                      ),
                        validator: (String?value){
                          if((value?.trim().length ?? 0) <= 6){
                            return 'Enter a valid Password';
                          }
                          return null;
                        }
                    ),

                    SizedBox(height: 20,),

                    Visibility(
                      visible: _signInprogress == false,// jdi false hoi tkn dekhabe
                      replacement: CenterInprogressbar(), //widget create
                      child: FilledButton(
                          onPressed: _TapSubmitButton, child: Icon(Icons.arrow_circle_right,)),
                    ),
                    SizedBox(height: 50,),
                    Center(
                      child: Column(
                          children: [
                            RichText(text: TextSpan(
                                text: "Have Account?",
                                children: [
                                  TextSpan(
                                      text: 'Sign In',
                                      style: TextStyle(color: Colors.green),
                                      recognizer: TapGestureRecognizer()..onTap = _TapLoginButton//sign up k tapble korlam
                                  )
                                ]
                            )
                            )
                          ]
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),



    );

  }

  void _TapSubmitButton(){
    if(_updateformkey.currentState!.validate()){
      _signup();
      _clear();
    }
  }

  void _TapLoginButton(){
    Navigator.pop(context);
  }

  Future<void> _signup()async{
    _signInprogress = true;
    setState(() {

    });
    //request body
    Map<String,dynamic> requestBody = {
      "email":_EmailTEcontroller.text.trim(),
      "firstName":_FirstNameTEcontroller.text.trim(),
      "lastName":_LastNameTEcontroller.text.trim(),
      "mobile":_MobileTEcontroller.text.trim(),
      "password":_PasswordTEcontroller.text,
    };
    final ApiResponse response = await ApiCaller().postRequest(
      url: URLS.registrationurl,
      body: requestBody,
    );
    _signInprogress = false;
    setState(() {

    });

    if(response.isSuccess) {
      ShowSnackbarMassage(context, 'Registration success! please login');

    }else{
      ShowSnackbarMassage(context, response.errorMassage!);//errorMassage ja ase ta show korbe
    }

  }

  void _clear(){
    _EmailTEcontroller.clear();
    _FirstNameTEcontroller.clear();
    _LastNameTEcontroller.clear();
    _MobileTEcontroller.clear();
    _PasswordTEcontroller.clear();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _EmailTEcontroller.dispose();
    _FirstNameTEcontroller.dispose();
    _LastNameTEcontroller.dispose();
    _MobileTEcontroller.dispose();
    _PasswordTEcontroller.dispose();
  }
}





