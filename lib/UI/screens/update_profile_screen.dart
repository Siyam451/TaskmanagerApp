import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskmanagement/Data/Utilits/urls.dart';
import 'package:taskmanagement/Data/api_caller.dart';
import 'package:taskmanagement/Data/auth_controller.dart';
import 'package:taskmanagement/Data/models/user_model.dart';
import 'package:taskmanagement/UI/screens/widget/background_image.dart';
import 'package:taskmanagement/UI/screens/widget/center_inprogress.dart';
import 'package:taskmanagement/UI/screens/widget/snack_bar.dart';
import 'package:taskmanagement/UI/screens/widget/tmappbar.dart';

import '../widgets/photo_picker.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key,});
  static const String name = '/update';

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController _EmailTEcontroller = TextEditingController();
  final TextEditingController _FirstNameTEcontroller = TextEditingController();
  final TextEditingController _LastNameTEcontroller = TextEditingController();
  final TextEditingController _MobileTEcontroller = TextEditingController();
  final TextEditingController _PasswordTEcontroller = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final ImagePicker _imagePicker = ImagePicker();//function call for image
   XFile? _SelectedImage;

   bool _UpdateProfileInProgress = false;



  //user update profile e click korle esob data show korbe
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UserModel user = AuthController.userModel!; // user er ki ki information anbo er jonno aita anlam
     _EmailTEcontroller.text = user.email;
     _FirstNameTEcontroller.text = user.firstname;
     _LastNameTEcontroller.text = user.lastname;
     _MobileTEcontroller.text = user.mobile;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Tmappbar(
        fromupdatescreen: true,
      ),

      body: BackgroundImage(
        child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Update Profile',style: Theme.of(context).textTheme.titleLarge),
                    SizedBox(height: 30,),

                   Photopicker(
                       ontap:_pickImage,
                     selectedphotos: _SelectedImage,
                   ), //widget banailam code ta guchano dekhaite
                    SizedBox(height: 15,),
                    TextFormField(
                      enabled: false, // aita dile field ta change kora jabe na
                      controller: _EmailTEcontroller,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: 'Email',
                      ),


                    ),
                    SizedBox(height: 15,),
                    TextFormField(
                      controller: _FirstNameTEcontroller,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: 'First Name',
                      ),
                      validator: (String ? value){
                        if
                        (value!.trim().isEmpty){
                          return 'Enter valid name';
                        }else{
                          return null;
                        }
                      }
                    ),

                    SizedBox(height: 15,),
                    TextFormField(
                      controller: _LastNameTEcontroller,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: 'Last Name',
                      ),
                        validator: (String ? value){
                          if
                          (value!.trim().isEmpty){
                            return 'Enter valid name';
                          }else{
                            return null;
                          }
                        }
                    ),

                    SizedBox(height: 15,),
                    TextFormField(
                      controller: _MobileTEcontroller,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: 'Mobile',
                      ),
                        validator: (String ? value){
                          if
                          (value!.trim().isEmpty){
                            return 'Enter valid number';
                          }else{
                            return null;
                          }
                        }
                    ),

                    SizedBox(height: 15,),
                    TextFormField(
                      controller: _PasswordTEcontroller,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: 'Password',
                      ),
                        validator: (String ? value){
                          if((value!=null && value.isNotEmpty)&&value.length<6){
                            return 'Enter more then 6 words';
                          }else{
                            return null;
                          }
                        }
                    ),

                    SizedBox(height: 15,),

                    Visibility(
                      visible: _UpdateProfileInProgress==false,
                      replacement: CenterInprogressbar(),
                      child: FilledButton(

                     onPressed: _TapUpdatebutton, // tap korle jdi valid hoi taile change korbe
                          child: Icon(Icons.arrow_circle_right,)),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ),
      );
  }



  void _TapUpdatebutton(){
     if(_formkey.currentState!.validate()){
       _updateProfile();

     }
  }

  Future<void> _updateProfile()async{
     _UpdateProfileInProgress = true;
     setState(() {});

     Map<String,dynamic> requestbody = {
       "email":_EmailTEcontroller.text, //email change korbo na tai trim dilam na
       "firstName":_FirstNameTEcontroller.text.trim(),
       "lastName":_LastNameTEcontroller.text.trim(),
       "mobile":_MobileTEcontroller.text.trim(),
     };

     if(_PasswordTEcontroller.text.isNotEmpty){ // jdi emtey na hoi tkn request bodyr moddhe pass ta add hbe ar aita na dile o somossha nai
       requestbody['password'] = _PasswordTEcontroller.text;
     }
     String? encodedPhoto;
     if (_SelectedImage != null) {
       List<int> bytes = await _SelectedImage!.readAsBytes();
       encodedPhoto = jsonEncode(bytes);
       requestbody['photo'] = encodedPhoto;
     }



     //calling api now


    final ApiResponse response = await ApiCaller.postRequest(url: URLS.ProfileUpdateurl,body: requestbody);

     _UpdateProfileInProgress = false;
     setState(() {});

     if(response.isSuccess){
       _PasswordTEcontroller.clear();
       //sucesss hoile user er esob ni ashbe
       UserModel model = UserModel(id: AuthController.userModel!.id,
           email: _EmailTEcontroller.text.trim(),
           firstname: _FirstNameTEcontroller.text.trim(),
           lastname: _LastNameTEcontroller.text.trim(),
           mobile: _MobileTEcontroller.text.trim(),
           photo: encodedPhoto ?? AuthController.userModel!.photo //encodephoto te ja ase ta set korbe ar na hoi usermodel e ja ase ta dibe
       );

       await AuthController.updateUserData(model);
       ShowSnackbarMassage(context, 'Profile Has been Updated');
     }else{
       ShowSnackbarMassage(context,response.errorMessage!);
     }
  }
  // Future<void> _PickImage()async{
  //   //? disi karon jdi image na pai tkn null kore phire cole ashbe
  //   XFile? PickedImage=await _imagePicker.pickImage(source: ImageSource.gallery);//image show korte kora
  //   if(PickedImage != null){ // null na hoile photos er aikane kidekhabe
  //     _SelectedImage = PickedImage; // ki show korbe tkn ta
  //     _selectedImageBytes = await pickedImage.readAsBytes();
  //     setState(() {});
  //   }
  // }
  Future<void> _pickImage() async {
    XFile? pickedImage = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      _SelectedImage = pickedImage;
      setState(() {});
    }
  }



  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _EmailTEcontroller.dispose();
    _FirstNameTEcontroller.dispose();
    _LastNameTEcontroller.dispose();
    _MobileTEcontroller.dispose();
    _PasswordTEcontroller.dispose();
  }
}

