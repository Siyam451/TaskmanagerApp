import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taskmanagement/Data/auth_controller.dart';
import 'package:taskmanagement/UI/Utilits/svgpictures.dart';
import 'package:taskmanagement/UI/screens/bottom_nav_bar.dart';

import 'login_Screen.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const name = '/splash';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _moveToNextScreen();
  }
  Future<void> _moveToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    await AuthController.getData();
    final bool isLoggedIn = await AuthController.IsUserloggedIn();

    if (isLoggedIn) {

      Navigator.pushReplacementNamed(context, BottomNavBar.name);
    } else {
      Navigator.pushReplacementNamed(context, LoginScreen.name);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SvgPicture.asset(SvgPictures.backgroundSvg,
          width: double.maxFinite,//aita mane joto tuko newa jai nibe
            height: double.maxFinite,
            fit: BoxFit.cover,
          ),
          Center(
            child: SvgPicture.asset(SvgPictures.logoSvg),
          )
        ],
      ),
    );
  }
}
