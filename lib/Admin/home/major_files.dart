
import 'dart:io';
import 'package:path/path.dart' as ph;
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

import '../MytextField.dart';

class MajorFiles extends StatefulWidget {
  const MajorFiles({super.key, required this.Major_id});

final String Major_id;

@override
  State<MajorFiles> createState() => _MajorFilesState();
}

class _MajorFilesState extends State<MajorFiles> {
  TextEditingController Url_Files = TextEditingController();
  TextEditingController Name_Files = TextEditingController();

  List<QueryDocumentSnapshot> Data = [];
  getdata() async {
    QuerySnapshot querySnapshot;
    querySnapshot = await FirebaseFirestore.instance
        .collection("Major")
        .doc(widget.Major_id)
        .collection("Major_Files")
        .get();
    Data.addAll(querySnapshot.docs);
    setState(() {});
  }
  Delete(String id) async {
    await FirebaseFirestore.instance
        .collection("Major")
        .doc(widget.Major_id)
        .collection("Major_Files")
        .doc(id)
        .delete();
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => MajorFiles(
          Major_id: widget.Major_id
        )));
  }
  Add() async {
    CollectionReference Add_Filse = FirebaseFirestore.instance
        .collection("Major")
        .doc(widget.Major_id)
        .collection("Major_Files");
    await Add_Filse.add({
      "Name_File": Name_Files.text,
      "Url_File": Url_Files.text,
      "Url_Image":Url_Image
    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
  File ?file;
  String Url_Image="";
  getimage() async{
    final ImagePicker picker = ImagePicker();
    final XFile? imagegallery = await picker.pickImage(source: ImageSource.gallery);
    if(imagegallery!=null){
      file=File(imagegallery.path);
      String Nameimage=ph.basename(imagegallery.path);
      var refstorage=FirebaseStorage.instance.ref(Nameimage);
      await refstorage.putFile(file!);
      Url_Image=await refstorage.getDownloadURL();
    }
    setState(() {});
  }
  @override
  void initState() {
    getdata();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.noHeader,
            animType: AnimType.bottomSlide,
            body: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Mytextfield(Hinttext: "Url Files", Mycontroller:Url_Files ),
                    SizedBox(height: 30.r,),
                    Mytextfield(Hinttext: "Name Files", Mycontroller:Name_Files ),
                    SizedBox(height: 30.r,),
                    Container(
                        margin: EdgeInsets.symmetric(vertical: 40.r),
                        width: 1000.r,
                        decoration: BoxDecoration(  color:Url_Image==""? Colors.red:Colors.green,borderRadius:BorderRadius.circular(100.r) ),
                        child:MaterialButton(
                          onPressed:()async{
                            await getimage();
                            setState(() {});
                            },
                          child: Text("Add Image",style: TextStyle(fontSize: 50.r),), )
                    ),
                    SizedBox(height: 30.r,),
                   ],
                );
              },
            ),
            btnOkOnPress: () {
              Add();
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => MajorFiles(
                    Major_id: widget.Major_id
                  )));
            },
            btnCancelOnPress: () {
              Name_Files.text = "";
              Url_Files.text = "";
            },
          ).show();
        },
        child: const Icon(Icons.add),
      ),
      body: Wrap (children: [
        ...List.generate(Data.length, (i){return
          Container(
              margin: EdgeInsets.symmetric(horizontal: 50.r),
              width: 1500.r,
              child: InkWell(
                onLongPress: ()async {
                  AwesomeDialog(context: context,
                  dialogType: DialogType.info,
                    animType: AnimType.bottomSlide,
                    desc: "هل تريد الحذف",
                    btnOkOnPress: ()async {
                    await FirebaseStorage.instance.refFromURL(Data[i]["Url_Image"]).delete();
                    Delete(Data[i].id);},
                    btnCancelOnPress: (){}
                  ).show();
                 },
                  onTap: (){launchUrl(Uri.parse(Data[i]["Url_File"]));},
                  child:
                  Column(children: [
                    Text(Data[i]["Name_File"],style: TextStyle(fontSize: 100.r,color: Colors.blue[900],fontWeight: FontWeight.bold),),
                    SizedBox(height: 50.r,),
                    InkWell(
                      onTap: (){launchUrl(Uri.parse(Data[i]["Url_File"]));},
                      child:Image.network(Data[i]["Url_Image"]),)
                  ],)))
        ;})
      ],),
    );
  }
}
