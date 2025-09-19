import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:taskmanagement/UI/screens/forgot_password_verify_email.dart';
import 'package:taskmanagement/UI/screens/update_screen.dart';
import 'package:taskmanagement/UI/screens/widget/background_image.dart';

import 'bottom_nav_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String name = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
 final TextEditingController _EmailTEcontroller = TextEditingController();
  final TextEditingController _PasswordTEcontroller = TextEditingController();
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
                      Text('Get Started with',style: Theme.of(context).textTheme.titleLarge),//defult vabe sob kane size ta koto hbe set kora
                      SizedBox(height: 15,),
                      TextFormField(
                        controller: _EmailTEcontroller,
                        decoration: InputDecoration(
                         hintText: 'Email',
                        ),
                      ),
                      SizedBox(height: 15,),
                      TextFormField(
                        controller: _PasswordTEcontroller,
                        decoration: InputDecoration(
                          hintText: 'Password'

                        ),
                      ),

                      SizedBox(height: 20,),

                      FilledButton(
                          onPressed: _TapLoginButton, child: Icon(Icons.arrow_circle_right,)),
                      SizedBox(height: 50,),
                      Center(
                        child: Column(
                          children: [
                            TextButton(onPressed: (){
                              _TapForgotPassword();
                            }, child: Text('Forgot Password?',style: TextStyle(color: Colors.grey),)),

                        RichText(text: TextSpan(
                          text: "Don't Have Account?",
                          children: [
                            TextSpan(
                              text: 'Sign up',
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
    Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdateScreen()));
  }


  void _TapForgotPassword(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPassEmail()));
  }

 void _TapLoginButton(){
 Navigator.pushNamedAndRemoveUntil(context,BottomNavBar.name,

     (predicate) => false
 );
 }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //kaj sesh e dispose i mean ber hoi jabe

    _EmailTEcontroller.dispose();
    _PasswordTEcontroller.dispose();
  }
}

