import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmanagement/Data/controller/set_password_provider.dart';

import 'package:taskmanagement/UI/screens/widget/background_image.dart';
import 'package:taskmanagement/UI/screens/widget/center_inprogress.dart';
import 'package:taskmanagement/UI/screens/widget/snack_bar.dart';

import 'login_Screen.dart';

class Passwordsetscreen extends StatefulWidget {
  const Passwordsetscreen({super.key, required this.email, required this.otp});
  final String email;
  final String otp;

  @override
  State<Passwordsetscreen> createState() => _PasswordsetscreenState();
}

class _PasswordsetscreenState extends State<Passwordsetscreen> {
  final TextEditingController _SetPasswordTEcontroller = TextEditingController();
  final TextEditingController _ConfirmPasswordTEcontroller = TextEditingController();
  final TextEditingController _EmailTEcontroller = TextEditingController();
  final TextEditingController _OtpTEcontroller = TextEditingController();
  late TapGestureRecognizer _signUpRecognizer;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final SetPasswordProvider _setPasswordProvider = SetPasswordProvider();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _signUpRecognizer = TapGestureRecognizer()..onTap = _TapSignUpButton;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_)=> SetPasswordProvider(),
      builder: (context,child) {
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
                      Text('Set Password', style: Theme
                          .of(context)
                          .textTheme
                          .titleLarge),
                      //defult vabe sob kane size ta koto hbe set kora
                      SizedBox(height: 4,),
                      Text('The password should be contain more then 6words',
                          style: Theme
                              .of(context,)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: Colors.grey)),
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

                      Consumer<SetPasswordProvider>(
                          builder: (context, setpasswordprovider, _) {
                            return Visibility(
                              visible: setpasswordprovider
                                  .SetpasswordInprogress == false,
                              replacement: CenterInprogressbar(),
                              child: FilledButton(
                                  onPressed:
                                  _TapSignUpButton
                                  , child: Text('Confirm')),
                            );
                          }
                      ),
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
    );
  }

  void _TapSignUpButton(){
    final password = _SetPasswordTEcontroller.text.trim();
    final confirmPassword = _ConfirmPasswordTEcontroller.text.trim();
    if(password.isEmpty || confirmPassword.isEmpty){
      ShowSnackbarMassage(context, 'please enter valid number');
      return;
    }

    if(password.length < 6){
      ShowSnackbarMassage(context, 'please enter more then 6 numbers');
      return;
    }
    if(password != confirmPassword){
      ShowSnackbarMassage(context, 'Password dont match');
      return;
    }
    _Resetpassword();

  }


  Future<void> _Resetpassword() async {


    final bool issucess = await _setPasswordProvider.postsetpassword(widget.email,
        widget.otp,
      _SetPasswordTEcontroller.text

    );


    if (issucess) {
      ShowSnackbarMassage(context, 'password reset successfully');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (ctx) =>  LoginScreen()),
      );
    } else {
      ShowSnackbarMassage(context, _setPasswordProvider.errorMessage!);
    }
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //kaj sesh e dispose i mean ber hoi jabe

    _SetPasswordTEcontroller.dispose();
    _ConfirmPasswordTEcontroller.dispose();
    _EmailTEcontroller.dispose();
    _OtpTEcontroller.dispose();

  }
}