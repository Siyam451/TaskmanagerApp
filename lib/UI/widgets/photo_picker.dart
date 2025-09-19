import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class Photopicker extends StatelessWidget {
  const Photopicker({
    super.key, required this.ontap, this.selectedphotos,
  });
  final VoidCallback ontap;
  final  XFile? selectedphotos; //file type Xfile

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,//voidcallback er ta dilam
      child: Container(
        width: double.maxFinite,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Row(
          children: [
            Container(
              width: 80,
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  )
              ),
              alignment: Alignment.center,//photos lekha ta k center e niye ashbe
              child: Text('Photos',style: TextStyle(color: Colors.white),),
            ),

            SizedBox(
              width: 10,
            ),

            Expanded(child: Text(selectedphotos== null?'No photos Selected': selectedphotos!.name)) //jdi null na hoi tkn bame show korbe

          ],
        ),
      ),
    );
  }
}
