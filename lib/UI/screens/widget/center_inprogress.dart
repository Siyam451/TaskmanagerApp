import 'package:flutter/material.dart';
class CenterInprogressbar extends StatelessWidget {
  const CenterInprogressbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}