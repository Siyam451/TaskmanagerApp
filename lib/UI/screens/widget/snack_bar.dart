import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void ShowSnackbarMassage(BuildContext context,String massage){
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(massage)));
}