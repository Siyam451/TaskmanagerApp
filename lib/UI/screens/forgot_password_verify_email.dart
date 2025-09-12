import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:taskmanagement/UI/screens/pin_verification_screen.dart';
import 'package:taskmanagement/UI/screens/update_screen.dart';
import 'package:taskmanagement/UI/screens/widget/background_image.dart';

class ForgotPassEmail extends StatefulWidget {
  const ForgotPassEmail({super.key});

  @override
  State<ForgotPassEmail> createState() => _ForgotPassEmailState();
}

class _ForgotPassEmailState extends State<ForgotPassEmail> {
  final TextEditingController _EmailTEcontroller = TextEditingController();
  late TapGestureRecognizer _signUpRecognizer;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _signUpRecognizer = TapGestureRecognizer()..onTap = _TapLoginButton;
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
                  Text('Your Email Address',style: Theme.of(context).textTheme.titleLarge),//defult vabe sob kane size ta koto hbe set kora
                 SizedBox(height: 4,),
                  Text('A 6 digit verification code will send to your email',
                      style: Theme.of(context,).textTheme.bodyLarge?.copyWith(color: Colors.grey)),
                  SizedBox(height: 15,),
                  TextFormField(
                    controller: _EmailTEcontroller,
                    decoration: InputDecoration(
                      hintText: 'Email',
                    ),
                  ),

                  SizedBox(height: 20,),

                  FilledButton(
                      onPressed:
                        _TapEmailsendbutton
                      , child: Icon(Icons.arrow_circle_right,)),
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

  void _TapLoginButton(){
 Navigator.pop(context);
  }

  void _TapEmailsendbutton(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>PinVerificationScreen()));
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //kaj sesh e dispose i mean ber hoi jabe

    _EmailTEcontroller.dispose();

  }
}

