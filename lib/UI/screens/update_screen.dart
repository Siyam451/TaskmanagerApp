import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:taskmanagement/UI/screens/widget/background_image.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({super.key});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  final TextEditingController _EmailTEcontroller = TextEditingController();
  final TextEditingController _FirstNameTEcontroller = TextEditingController();
  final TextEditingController _LastNameTEcontroller = TextEditingController();
  final TextEditingController _MobileTEcontroller = TextEditingController();
  final TextEditingController _PasswordTEcontroller = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundImage(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formkey,
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
                    ),
                    SizedBox(height: 15,),
                    TextFormField(
                      controller: _FirstNameTEcontroller,
                      decoration: InputDecoration(
                        hintText: 'First Name',
                      ),
                    ),
                    SizedBox(height: 15,),
                    TextFormField(
                      controller: _LastNameTEcontroller,
                      decoration: InputDecoration(
                        hintText: 'Last Name',
                      ),
                    ),
                    SizedBox(height: 15,),
                    TextFormField(
                      controller: _MobileTEcontroller,
                      decoration: InputDecoration(
                        hintText: 'Mobile',
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


  void _TapLoginButton(){
    Navigator.pop(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //kaj sesh e dispose i mean ber hoi jabe
    _EmailTEcontroller.dispose();
    _FirstNameTEcontroller.dispose();
    _LastNameTEcontroller.dispose();
    _MobileTEcontroller.dispose();
    _PasswordTEcontroller.dispose();
  }
}

