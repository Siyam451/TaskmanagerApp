import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:taskmanagement/UI/screens/pin_verification_screen.dart';
import 'package:taskmanagement/UI/screens/update_screen.dart';
import 'package:taskmanagement/UI/screens/widget/background_image.dart';

import 'login_Screen.dart';

class Passwordsetscreen extends StatefulWidget {
  const Passwordsetscreen({super.key});

  @override
  State<Passwordsetscreen> createState() => _PasswordsetscreenState();
}

class _PasswordsetscreenState extends State<Passwordsetscreen> {
  final TextEditingController _SetPasswordTEcontroller = TextEditingController();
  final TextEditingController _ConfirmPasswordTEcontroller = TextEditingController();
  late TapGestureRecognizer _signUpRecognizer;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _signUpRecognizer = TapGestureRecognizer()..onTap = _TapSignUpButton;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:BackgroundImage(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 85),
                  Text('Set Password',style: Theme.of(context).textTheme.titleLarge),//defult vabe sob kane size ta koto hbe set kora
                  SizedBox(height: 4,),
                  Text('The password should be contain more then 6words',
                      style: Theme.of(context,).textTheme.bodyLarge?.copyWith(color: Colors.grey)),
                  SizedBox(height: 15,),
                  TextFormField(
                    controller: _SetPasswordTEcontroller,
                    decoration: InputDecoration(
                      hintText: 'Set Password',
                    ),
                  ),
                  SizedBox(height: 15,),
                  TextFormField(
                    controller: _ConfirmPasswordTEcontroller,
                    decoration: InputDecoration(
                      hintText: 'Confirm Password',
                    ),
                  ),


                  SizedBox(height: 20,),

                  FilledButton(
                      onPressed:
                      _TapSignUpButton
                      , child: Text('Confirm')),
                  SizedBox(height: 50,),
                  Center(
                    child: Column(
                        children: [
                          RichText(text: TextSpan(
                              text: " Already Have Account?",
                              children: [
                                TextSpan(
                                    text: 'Login',
                                    style: TextStyle(color: Colors.green),
                                    recognizer: _signUpRecognizer

                                ),
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

  void _TapSignUpButton(){
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginScreen()),
            (predicate)=>false

    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //kaj sesh e dispose i mean ber hoi jabe

    _SetPasswordTEcontroller.dispose();
    _ConfirmPasswordTEcontroller.dispose();

  }
}