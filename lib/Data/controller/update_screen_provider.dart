import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import '../Utilits/urls.dart';
import '../api_caller.dart';
import '../auth_controller.dart';
import '../models/user_model.dart';

class UpdateScreenProvider extends ChangeNotifier {
  bool _updateScreenInProgress = false;
  String? _errorMessage;
  File? _selectedImage; // store selected image file

  bool get updateScreenInProgress => _updateScreenInProgress;
  String? get errorMessage => _errorMessage;
  File? get selectedImage => _selectedImage;

  void setSelectedImage(File? image) {
    _selectedImage = image;
    notifyListeners();
  }

  Future<bool> postUpdateScreen({
    required String email,
    required String firstName,
    required String lastName,
    required String mobile,
    required String password,
  }) async {
   // bool isSuccess = false;
    _updateScreenInProgress = true;
    notifyListeners();

    Map<String, dynamic> requestBody = {
      "email": email, // email typically not changed
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
    };

    // add password only if not empty
    if (password.isNotEmpty) {
      requestBody['password'] = password;
    }

    //  handle image encoding if user selected one
    String? encodedPhoto;
    if (_selectedImage != null) {
      List<int> bytes = await _selectedImage!.readAsBytes();
      encodedPhoto = base64Encode(bytes); // use base64Encode, not jsonEncode
      requestBody['photo'] = encodedPhoto;
    }

    //  Call API
    final ApiResponse response =
    await ApiCaller.postRequest(url: URLS.ProfileUpdateurl, body: requestBody);

    _updateScreenInProgress = false;
    notifyListeners();

    if (response.isSuccess) {
     // isSuccess = true;
      // Update locally stored user model
      UserModel model = UserModel(
        id: AuthController.userModel!.id,
        email: email.trim(),
        firstname: firstName.trim(),
        lastname: lastName.trim(),
        mobile: mobile.trim(),
        photo: encodedPhoto ?? AuthController.userModel!.photo,
      );

      await AuthController.updateUserData(model);
      return true;

    } else {
      _errorMessage = response.errorMessage;
      return false;
    }
  }
}
