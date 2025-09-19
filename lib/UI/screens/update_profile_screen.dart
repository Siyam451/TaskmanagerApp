import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskmanagement/UI/screens/widget/background_image.dart';
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
                       ontap:_PickImage,
                     selectedphotos: _SelectedImage,
                   ), //widget banailam code ta guchano dekhaite
                    SizedBox(height: 15,),
                    TextFormField(
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
                    ),

                    SizedBox(height: 15,),
                    TextFormField(
                      controller: _LastNameTEcontroller,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: 'Last Name',
                      ),
                    ),

                    SizedBox(height: 15,),
                    TextFormField(
                      controller: _MobileTEcontroller,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: 'Mobile',
                      ),
                    ),

                    SizedBox(height: 15,),
                    TextFormField(
                      controller: _PasswordTEcontroller,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: 'Password',
                      ),
                    ),

                    SizedBox(height: 15,),

                    FilledButton(
                        onPressed:(){}
                        , child: Icon(Icons.arrow_circle_right,)),
                  ],
                ),
              ),
            ),
          ),
      ),
      );
  }
  Future<void> _PickImage()async{
    //? disi karon jdi image na pai tkn null kore phire cole ashbe
    XFile? PickedImage=await _imagePicker.pickImage(source: ImageSource.gallery);//image show korte kora
    if(PickedImage != null){ // null na hoile photos er aikane kidekhabe
      _SelectedImage = PickedImage; // ki show korbe tkn ta
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

