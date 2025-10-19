import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:taskmanagement/Data/Utilits/urls.dart';
import 'package:taskmanagement/Data/api_caller.dart';
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
  bool _VerifyEmailInprogress = false;

  @override
  void initState() {
    super.initState();
    _signUpRecognizer = TapGestureRecognizer()..onTap = _TapLoginButton;
    _EmailTEcontroller.text = widget.email; // prefill email
  }

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
                  Text('Your Email Address', style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 4),
                  Text(
                    'A 6 digit verification code will be sent to your email',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.grey),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: _EmailTEcontroller,
                    decoration: const InputDecoration(hintText: 'Email'),
                    validator: (value) {
                      if (value == null || value.isEmpty || !value.contains('@')) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  Visibility(
                    visible: !_VerifyEmailInprogress,
                    replacement: const CenterInprogressbar(),
                    child: FilledButton(
                      onPressed: _TapEmailsendbutton,
                      child: const Icon(Icons.arrow_circle_right),
                    ),
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
    );
  }

  void _TapLoginButton() {
    Navigator.pop(context);
  }

  void _TapEmailsendbutton() async {
    if (_formkey.currentState!.validate()) {
      await _VerifyEmail(); // wait for API call
    }
  }

  Future<void> _VerifyEmail() async {
    _VerifyEmailInprogress = true;
    setState(() {});

    try {
      final String url = URLS.RecoverVerifyEmailurl(Uri.encodeComponent(_EmailTEcontroller.text.trim()));
      final ApiResponse response = await ApiCaller.getRequest(url: url);

      if (response.isSuccess) {
        ShowSnackbarMassage(context, response.responseData['data']);//response theke data ta show korbe
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => PinVerificationScreen(
              email: _EmailTEcontroller.text.trim(), // ✅ Pass email here
            ),
          ),
        );
      } else {
        ShowSnackbarMassage(context, response.errorMessage ?? 'Something went wrong');
      }
    } catch (e) { //jdi null hoi tkn
      ShowSnackbarMassage(context, 'Something went wrong');
    } finally {
      _VerifyEmailInprogress = false;
      setState(() {});
    }
  }

  @override
  void dispose() {
    _EmailTEcontroller.dispose();
    _signUpRecognizer.dispose();
    super.dispose();
  }
}

