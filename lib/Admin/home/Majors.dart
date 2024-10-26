import 'dart:io';

import 'package:afaq/Users/home_page.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as ph;
import '../MytextField.dart';
import 'database_page.dart';
import 'major_files.dart';

class Majors extends StatefulWidget {
  Majors({super.key, required this.Major_data});
  List<QueryDocumentSnapshot> Major_data;

  @override
  State<Majors> createState() => _MajorsState();
}

class _MajorsState extends State<Majors> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        height: 200.r,
      ),
      InkWell(
        onTap: () {
          FirebaseAuth.instance.signOut();
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>const HomePage()), (route) => false);
        },
        child: const Icon(Icons.exit_to_app),
      ),
      Expanded(
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisExtent: 600.r),
              itemCount: widget.Major_data.length,
              itemBuilder: (BuildContext, i) {
                return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              MajorFiles(Major_id: widget.Major_data[i].id)));
                    },
                    onLongPress: () {
                      AwesomeDialog(
                          context: (context),
                          desc: "اختر ما تريد ",
                          dialogType: DialogType.warning,
                          btnCancelText: "Delete",
                          btnOkText: "Editing",
                          btnOkOnPress: () {
                            DialogEdit(
                                widget.Major_data[i].id,
                                widget.Major_data[i]["Major_Name"],
                                widget.Major_data[i]["Information_Major"],
                                i);
                          },
                          btnCancelOnPress: () async {

                            if (widget.Major_data[i]["Url_Image"]
                                .toString()
                                .isNotEmpty) {
                              await FirebaseStorage.instance
                                  .refFromURL(widget.Major_data[i]["Url_Image"])
                                  .delete();

                            }
                            await deleteDocumentWithSubcollections(widget.Major_data[i].id);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DatabasePage(
                                          selectedindex: 2,
                                        )));
                          }).show();
                    },
                    child: Card(
                      child: Column(
                        children: [
                          Container(
                            width: 500.r,
                            height: 400.r,
                            color: Colors.blue,
                            child: Image.network(
                              widget.Major_data[i]["Url_Image"]
                                      .toString()
                                      .isEmpty
                                  ? "https://play-lh.googleusercontent.com/LECOTVlGWVclV1VU3-1YcNoQdF2f37jQaQhX353GkySuwK9EcPXgy92YgKB3QeNvZMXe=w240-h480-rw"
                                  : widget.Major_data[i]["Url_Image"],
                              fit: BoxFit.fill,
                            ),
                          ),
                          Text(
                            widget.Major_data[i]["Major_Name"],
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 50.r),
                          ),
                        ],
                      ),
                    ));
              }))
    ]);
  }

  TextEditingController Text1 = TextEditingController();
  TextEditingController Text2 = TextEditingController();

  Update(String id, int index) async {
    CollectionReference Update_Filse =
        FirebaseFirestore.instance.collection("Major");
    if (Url_Image.isEmpty) {
      Url_Image = widget.Major_data[index]["Url_Image"];
    } else {
      await FirebaseStorage.instance
          .refFromURL(widget.Major_data[index]["Url_Image"])
          .delete();
    }
    await Update_Filse.doc(id)
        .update({
          "Major_Name": Text1.text,
          "Information_Major": Text2.text,
          "Url_Image": Url_Image
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  File? file;
  String Url_Image = "";

  DialogEdit(String id, String text1, String text2, int index) {
    Text1.text = text1;
    Text2.text = text2;
    AwesomeDialog(
      context: context,
      dialogType: DialogType.noHeader,
      animType: AnimType.bottomSlide,
      body: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Mytextfield(
                Hinttext: "Major Name",
                Mycontroller: Text1,
              ),
              Mytextfield(
                Hinttext: "Information Major",
                Mycontroller: Text2,
              ),
              Container(
                  margin: EdgeInsets.symmetric(vertical: 40.r),
                  width: 1000.r,
                  decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(100.r)),
                  child: MaterialButton(
                    onPressed: () async {
                      await getimage();
                      setState(() {});
                    },
                    child: Text(
                      "Add Image",
                      style: TextStyle(fontSize: 50.r),
                    ),
                  )),
            ],
          );
        },
      ),
      btnOkOnPress: () async {
        await Update(id, index);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => DatabasePage(
                      selectedindex: 2,
                    )));
      },
      btnCancelOnPress: () async {
        Text1.text = "";
        Text2.text = "";
        if (Url_Image.isNotEmpty) {
          await FirebaseStorage.instance.refFromURL(Url_Image).delete();
        }
      },
    ).show();
  }

  getimage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imagegallery =
        await picker.pickImage(source: ImageSource.gallery);
    if (imagegallery != null) {
      file = File(imagegallery.path);
      String Nameimage = ph.basename(imagegallery.path);
      var refstorage = FirebaseStorage.instance.ref(Nameimage);
      await refstorage.putFile(file!);
      Url_Image = await refstorage.getDownloadURL();
    }
    setState(() {});
  }
  Future<void> deleteDocumentWithSubcollections(String docId) async {
    var docRef = FirebaseFirestore.instance.collection('Major').doc(docId);
      var subcollections = await docRef.collection("Major_Files").get();
      for (var doc in subcollections.docs) {
        await FirebaseStorage.instance
            .refFromURL(doc["Url_Image"])
            .delete();
        await doc.reference.delete();
      }
    await docRef.delete();
  }

}
