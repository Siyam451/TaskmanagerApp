import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:taskmanagement/Data/auth_controller.dart';
import 'package:taskmanagement/Data/controller/update_screen_provider.dart';
import 'package:taskmanagement/Data/models/user_model.dart';
import 'package:taskmanagement/UI/screens/new_task_screen.dart';
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
 // XFile? _SelectedImage;
  final UpdateScreenProvider _updateScreenProvider = UpdateScreenProvider();




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
    return ChangeNotifierProvider(
      create: (_)=> UpdateScreenProvider(),
        child:Scaffold(
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

                         Consumer<UpdateScreenProvider>(
                           builder: (context,updatescreenprovider,_) {
                             return Photopicker(
                                 ontap:()=>_pickImage(context),
                               selectedphotos: updatescreenprovider.selectedImage != null
                                   ? XFile(updatescreenprovider.selectedImage!.path) : null
                             );
                           }
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

                          Consumer<UpdateScreenProvider>(
                            builder: (context,updatescreenprovider,_) {
                              return Visibility(
                                visible: updatescreenprovider.updateScreenInProgress==false,
                                replacement: CenterInprogressbar(),
                                child: FilledButton(

                               onPressed:(){
                                 _TapUpdatebutton();

                                 }, // tap korle jdi valid hoi taile change korbe
                                 child: Icon(Icons.arrow_circle_right,
                               )),
                              );
                            }
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



  void _TapUpdatebutton(){
     if(_formkey.currentState!.validate()){
       _updateProfile();

       Navigator.push(context, MaterialPageRoute(builder: (context)=>NewTaskScreen()));

     }
  }

  Future<void> _updateProfile()async{

     final bool isSucess = await _updateScreenProvider.postUpdateScreen(email: _EmailTEcontroller.text.trim(),
         firstName: _FirstNameTEcontroller.text.trim(),
       lastName:_LastNameTEcontroller.text.trim(),
         mobile: _MobileTEcontroller.text.trim(),
         password: _PasswordTEcontroller.text,
     );

     if (!mounted) return;

     if(isSucess){
       _PasswordTEcontroller.clear();
       ShowSnackbarMassage(context, 'Profile Has been Updated');
     }else{
       ShowSnackbarMassage(context,_updateScreenProvider.errorMessage!);
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
  Future<void> _pickImage(BuildContext context) async {
    final provider = context.read<UpdateScreenProvider>();
    XFile? pickedImage =
    await _imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      provider.setSelectedImage(File(pickedImage.path));
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

