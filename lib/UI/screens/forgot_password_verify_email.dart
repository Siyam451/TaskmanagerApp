import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmanagement/Data/Utilits/urls.dart';
import 'package:taskmanagement/Data/api_caller.dart';
import 'package:taskmanagement/Data/controller/forgetpass_email_provider.dart';
import 'package:taskmanagement/UI/screens/pin_verification_screen.dart';
import 'package:taskmanagement/UI/screens/widget/background_image.dart';
import 'package:taskmanagement/UI/screens/widget/center_inprogress.dart';
import 'package:taskmanagement/UI/screens/widget/snack_bar.dart';

class ForgotPassEmail extends StatefulWidget {
  const ForgotPassEmail({super.key, required this.email});
  final String email;

  @override
  State<ForgotPassEmail> createState() => _ForgotPassEmailState();
}

class _ForgotPassEmailState extends State<ForgotPassEmail> {
  final TextEditingController _EmailTEcontroller = TextEditingController();
  late TapGestureRecognizer _signUpRecognizer;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final ForgetpassEmailProvider _forgetpassEmailProvider = ForgetpassEmailProvider();

  @override
  void initState() {
    super.initState();
    _signUpRecognizer = TapGestureRecognizer()..onTap = _TapLoginButton;
    _EmailTEcontroller.text = widget.email; // prefill email
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_)=> ForgetpassEmailProvider(),


        child:Scaffold(
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
                      Text('Your Email Address', style: Theme
                          .of(context)
                          .textTheme
                          .titleLarge),
                      const SizedBox(height: 4),
                      Text(
                        'A 6 digit verification code will be sent to your email',
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: Colors.grey),
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: _EmailTEcontroller,
                        decoration: const InputDecoration(hintText: 'Email'),
                        validator: (value) {
                          if (value == null || value.isEmpty ||
                              !value.contains('@')) {
                            return 'Enter a valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      Consumer<ForgetpassEmailProvider>(
                          builder: (context, forgetemailprovider, _) {
                            return Visibility(
                              visible: forgetemailprovider
                                  .forgetEmailInProgress == false,
                              replacement: CenterInprogressbar(),
                              child: FilledButton(
                                onPressed:()=> _tapEmailSendButton(context, forgetemailprovider),
                                child: const Icon(Icons.arrow_circle_right),
                              ),
                            );
                          }
                      ),
                      const SizedBox(height: 50),
                      Center(
                        child: RichText(
                          text: TextSpan(
                            text: "Already Have Account? ",
                            style: const TextStyle(color: Colors.black),
                            children: [
                              TextSpan(
                                text: 'Login',
                                style: const TextStyle(color: Colors.green),
                                recognizer: _signUpRecognizer,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
    );
  }

  void _TapLoginButton() {
    Navigator.pop(context);
  }

  void _tapEmailSendButton(BuildContext context, ForgetpassEmailProvider provider) async {
    if (!_formkey.currentState!.validate()) return;

    final email = _EmailTEcontroller.text.trim();
    final success = await provider.getForgetEmailTask(email);

    if (!mounted) return;

    if (success) {
      ShowSnackbarMassage(context, "Verification code sent");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => PinVerificationScreen(email: email)),
      );
    } else {
      ShowSnackbarMassage(context, provider.errorMessage ?? 'Something went wrong');
    }
  }

  Future<void> _VerifyEmail() async {
    final bool isSucess = await _forgetpassEmailProvider.getForgetEmailTask(
      _EmailTEcontroller.text.trim(),
    );
    try {
      final String url = URLS.RecoverVerifyEmailurl(Uri.encodeComponent(_EmailTEcontroller.text.trim()));

      if (isSucess) {
        ShowSnackbarMassage(context, "Verification code sent");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => PinVerificationScreen(email: _EmailTEcontroller.text.trim()),
          ),
        );
      } else {
        ShowSnackbarMassage(context, _forgetpassEmailProvider.errorMessage ?? 'Something went wrong');
      }
    } catch (e) {
      ShowSnackbarMassage(context, 'Something went wrong');
    }
  }

  @override
  void dispose() {
    _EmailTEcontroller.dispose();
    _signUpRecognizer.dispose();
    super.dispose();
  }

}


