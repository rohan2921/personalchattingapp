import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class UserImagePicker extends StatefulWidget {
  Function fn;
  UserImagePicker(this.fn);
  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _pickedImageShow;
  void _pickImage(ctx) async{
    var pickedImage;
   showModalBottomSheet(
        context: ctx,
        builder: (bctx) {
          return GestureDetector(
            onTap: () => {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton.icon(onPressed: () async{
                    pickedImage= await ImagePicker.pickImage(source: ImageSource.camera,imageQuality: 50);
                     setState(() {
          _pickedImageShow=pickedImage;
        });
        widget.fn(_pickedImageShow);
                    Navigator.of(context).pop(bctx);
                }, icon: Icon(Icons.camera), label: Text('Camera')),
                FlatButton.icon(onPressed: () async{
                  pickedImage= await ImagePicker.pickImage(source: ImageSource.gallery,imageQuality: 50,maxWidth: 150);
                   setState(() {
          _pickedImageShow=pickedImage;
        });
         widget.fn(_pickedImageShow);
                  Navigator.of(context).pop(bctx);
                }, icon: Icon(Icons.photo_album), label:Text('Gallery'))
              ],
            ),
            behavior: HitTestBehavior.opaque,
          );
        });
        print(_pickedImageShow);
       
        print(_pickedImageShow);
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
         CircleAvatar(radius: 35,
         
         backgroundImage: _pickedImageShow==null? NetworkImage('https://1.bp.blogspot.com/-vNBAAu1z7_4/W2sfF_8XHjI/AAAAAAAACGY/EMU-8TLYbegf-Ywv8kMmv85YoHPaAZjNACLcBGAs/s1600/device-2018-08-08-094825.png'): FileImage(_pickedImageShow),
         ),
                FlatButton.icon(onPressed: ()=>_pickImage(context), icon: Icon(Icons.add_a_photo),label: Text('Add Image'),),
      ],
    );
  }
}