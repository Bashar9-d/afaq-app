import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import '../../MytextField.dart';
import '../database_page.dart';

class AddMajor extends StatefulWidget {
  const AddMajor({super.key});

  @override
  State<AddMajor> createState() => _AddMajorState();
}

class _AddMajorState extends State<AddMajor> {
  GlobalKey<FormState> formkey = GlobalKey();
  TextEditingController Major_Name = TextEditingController();
  TextEditingController Information_Major = TextEditingController();
  CollectionReference Major = FirebaseFirestore.instance.collection('Major');

  Future<void> addSubject() async {
    // Call the user's CollectionReference to add a nderw user
    return await Major.add({
      "Major_Name": Major_Name.text,
      "Information_Major": Information_Major.text,
      "Url_Image": Url_Image
    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  File? file;
  String Url_Image = "";

  getimage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imagegallery =
        await picker.pickImage(source: ImageSource.gallery);
    if (imagegallery != null) {
      file = File(imagegallery.path);
      String Nameimage = basename(imagegallery.path);
      var refstorage = FirebaseStorage.instance.ref(Nameimage);
      await refstorage.putFile(file!);
      Url_Image = await refstorage.getDownloadURL();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Mytextfield(Hinttext: "Name  Major", Mycontroller: Major_Name),
        SizedBox(
          height: 30.h,
        ),
        Mytextfield(Hinttext: "Information Major", Mycontroller: Information_Major),
        SizedBox(
          height: 30.h,
        ),
        Container(
            margin: EdgeInsets.symmetric(vertical: 40.h),
            width: 1000.w,
            decoration: BoxDecoration(
                color: Url_Image.isEmpty ? Colors.red : Colors.green,
                borderRadius: BorderRadius.circular(100.w)),
            child: MaterialButton(
              onPressed: () async {
                await getimage();
              },
              child: Text(
                "Add Image",
                style: TextStyle(fontSize: 50.sp),
              ),
            )),
        SizedBox(
          height: 30.h,
        ),
        Container(
            margin: EdgeInsets.symmetric(vertical: 40.h),
            width: 1000.w,
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(100.w)),
            child: MaterialButton(
              onPressed: () {
                addSubject();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => DatabasePage(selectedindex: 2,)),
                    (route) => false);
              },
              child: Text(
                "Create",
                style: TextStyle(fontSize: 50.sp),
              ),
            ))
      ],
    );
  }
}
