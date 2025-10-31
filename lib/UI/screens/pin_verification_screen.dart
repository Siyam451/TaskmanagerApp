import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:taskmanagement/Data/controller/pin_verification_provider.dart';
import 'package:taskmanagement/UI/screens/login_Screen.dart';
import 'package:taskmanagement/UI/screens/set_password_screen.dart';

import 'package:taskmanagement/UI/screens/widget/background_image.dart';
import 'package:taskmanagement/UI/screens/widget/center_inprogress.dart';
import 'package:taskmanagement/UI/screens/widget/snack_bar.dart';


class PinVerificationScreen extends StatefulWidget {
  const PinVerificationScreen({super.key, required this.email});
  final String email;

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {
  final TextEditingController _EmailOTPTEcontroller = TextEditingController();
  final TextEditingController _otpTextController = TextEditingController();

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
    return ChangeNotifierProvider(
      create: (_)=> PinverificationProvider(),
      child: Scaffold(
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
                    Text('A 6 digit verification code Have been send to your email',
                        style: Theme.of(context,).textTheme.bodyLarge?.copyWith(color: Colors.grey)),
                    SizedBox(height: 15,),
                    PinCodeTextField(
                      keyboardType: TextInputType.number,
                      length: 6,
                      obscureText: false,
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 50,
                        fieldWidth: 40,
                        activeFillColor: Colors.white,
                      ),
                      animationDuration: Duration(milliseconds: 300),
                      backgroundColor: Colors.transparent,
                      controller: _otpTextController,
                     appContext: context,
                    ),

                    SizedBox(height: 20,),

                    Consumer<PinverificationProvider>(
                      builder: (context,pinverificationProvider , _) {
                        return Visibility(
                          visible: pinverificationProvider.forgetEmailInProgress == false,
                          replacement: CenterInprogressbar(),
                          child: FilledButton(
                              onPressed:()=>_TapVerifyButton(context,pinverificationProvider),
                              child: Text('Verify')),
                        );
                      }
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



      ),
    );
  }

  void _TapSignUpButton(){
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginScreen()),
            (predicate)=>false

    );
  }

  void _TapVerifyButton(BuildContext context,PinverificationProvider provider) async{
    final email = widget.email;
    final otp = _otpTextController.text.trim();
    final success = await provider.getverifyotp(email, otp);

    if(success){
      ShowSnackbarMassage(context, 'Verified successfully');
      Navigator.push(
          context,
          MaterialPageRoute(builder: (ctx) => Passwordsetscreen(email: widget.email,otp: _otpTextController.text,)));
    }else{
      ShowSnackbarMassage(context, provider.errorMessage!);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //kaj sesh e dispose i mean ber hoi jabe

    _EmailOTPTEcontroller.dispose();
    _otpTextController.dispose();

  }

}



