import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../Utilits/svgpictures.dart';
class BackgroundImage extends StatelessWidget {
  const BackgroundImage({super.key, required this.child});
  final Widget child;//widget create for background

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
      SvgPicture.asset(SvgPictures.backgroundSvg,
      width: double.maxFinite,//aita mane joto tuko newa jai nibe
      height: double.maxFinite,
      fit: BoxFit.cover,
    ),
        SafeArea(child: child),

    ]
    );

  }
}
