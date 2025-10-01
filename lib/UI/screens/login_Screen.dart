import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:taskmanagement/Data/Utilits/urls.dart';
import 'package:taskmanagement/Data/api_caller.dart';
import 'package:taskmanagement/Data/auth_controller.dart';
import 'package:taskmanagement/Data/models/user_model.dart';
import 'package:taskmanagement/UI/screens/forgot_password_verify_email.dart';
import 'package:taskmanagement/UI/screens/splash_screen.dart';
import 'package:taskmanagement/UI/screens/update_screen.dart';
import 'package:taskmanagement/UI/screens/widget/background_image.dart';
import 'package:taskmanagement/UI/screens/widget/center_inprogress.dart';
import 'package:taskmanagement/UI/screens/widget/snack_bar.dart';

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
  bool _loginInprogress = false;
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
                        validator: (String?value){
                          if(value?.trim().isEmpty ?? true ){
                            return 'Enter Valid Email';
                          }else{
                            return null;
                          }
                        }
                      ),
                      SizedBox(height: 15,),
                      TextFormField(
                        controller: _PasswordTEcontroller,
                        decoration: InputDecoration(
                          hintText: 'Password'
                        ),
                        validator: (String?value){
                          if(value!.length <6){
                            return 'The password is more then 6 words';
                          }else{
                            return null;
                          }
                        }
                      ),

                      SizedBox(height: 20,),

                      Visibility(
                        visible: _loginInprogress == false,
                        replacement: CenterInprogressbar(),
                        child: FilledButton(
                            onPressed: _TapSubmitButton, child: Icon(Icons.arrow_circle_right,)),
                      ),
                      SizedBox(height: 50,),
                      Center(
                        child: Column(
                          children: [
                            TextButton(onPressed: (){
                              _TapForgotPassword();
                             // Navigator.push(context, MaterialPageRoute(builder: (context)=>SplashScreen()));
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

 void _TapSubmitButton(){
   if(_formkey.currentState!.validate()){
     _login();
     // Navigator.push(context, MaterialPageRoute(builder: (context)=>SplashScreen()));
   }
 }
  void _TapSignUpButton(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdateScreen()));
  }


  void _TapForgotPassword(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPassEmail()));
  }

 // void _TapLoginButton(){
 // Navigator.pushNamedAndRemoveUntil(context,BottomNavBar.name,
 //
 //     (predicate) => false
 // );
 // }


 Future<void> _login() async {
   _loginInprogress = true;
   setState(() {});

   // request body
   Map<String, dynamic> requestBody = {
     "email": _EmailTEcontroller.text.trim(),
     "password": _PasswordTEcontroller.text,
   };

   // ✅ Call static method directly
   final ApiResponse response = await ApiCaller.postRequest(
     url: URLS.loginurl,
     body: requestBody,
   );

   if (response.isSuccess && response.responseData['status'] == 'success') {
     UserModel model = UserModel.fromJson(response.responseData['data']);
     String accessToken = response.responseData['token'];

     // Save user + token
     await AuthController().saveData(model, accessToken);

     Navigator.pushNamedAndRemoveUntil(
       context,
       BottomNavBar.name,
           (predicate) => false,
     );

     ShowSnackbarMassage(context, 'Login successful');
   } else {
     _loginInprogress = false;
     setState(() {});
     ShowSnackbarMassage(context, response.errorMessage!);
   }
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


