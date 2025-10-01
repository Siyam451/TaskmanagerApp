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
  Future<void>_moveToNextScreen()async  {
    await Future.delayed(Duration(seconds:3));//animation ashtbe 3 second por kore
    //nicher line gula check korbe user ageh theke login ase kina... jdi thake taile direct app e dukhai dibe
    final bool IsloggedIn = await AuthController.IsUserloggedIn();
    if(IsloggedIn){
      await AuthController.getData();//data diye dibe
      Navigator.pushReplacementNamed(context, BottomNavBar.name);
    }else{
      //jdi login na thaki taile amk login screen e pathai dibe
    }
    Navigator.pushReplacementNamed(context, LoginScreen.name);


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
