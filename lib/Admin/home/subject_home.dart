import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as ph;
import '../MytextField.dart';
import '../Subject/subject_files.dart';
import 'database_page.dart';

class SubjectHome extends StatefulWidget {
  SubjectHome(
      {super.key,
      required this.Subject_data,
      required this.filteredSubjectData});

  List<QueryDocumentSnapshot> Subject_data;
  List<QueryDocumentSnapshot> filteredSubjectData;

  @override
  State<SubjectHome> createState() => _SubjectHomeState();
}

class _SubjectHomeState extends State<SubjectHome> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        SizedBox(
          height: 100.r,
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20.r, horizontal: 20.r),
          child: TextField(
            controller: searchController,
            onChanged: (value) {
              search(value); // تحديث نتائج البحث عند تغيير النص في حقل البحث
            },
            decoration: const InputDecoration(
              labelText: 'ابحث عن المادة...',
              border: OutlineInputBorder(),
              suffixIcon: Icon(Icons.search),
            ),
          ),
        ),
        Expanded(
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisExtent: 900.r),
              itemCount: widget.filteredSubjectData.length,
              itemBuilder: (BuildContext, i) {
                return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SubjectFiles(
                                Subject_id: widget.filteredSubjectData[i].id,
                                Titile: widget.filteredSubjectData[i]
                                    ["Subject_Name"],
                              )));
                    },
                    onLongPress: () {
                      AwesomeDialog(
                          context: (context),
                          desc: "اختر ما تريد ",
                          dialogType: DialogType.warning,
                          btnCancelText: "Delete",
                          btnOkText: "Editing",
                          btnOkOnPress: () { 
                            String list=  widget.filteredSubjectData[i]["Search_Names"].join(",");
                            DialogEdit(
                                widget.filteredSubjectData[i].id,
                                widget.filteredSubjectData[i]["Subject_Name"],
                               list,
                                i);
                          },
                          btnCancelOnPress: () async {
                            await deleteDocumentWithSubcollections(widget.filteredSubjectData[i].id);
                            await FirebaseStorage.instance
                                .refFromURL(
                                    widget.filteredSubjectData[i]["Url_Image"])
                                .delete();
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DatabasePage(
                                          selectedindex: 0,
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
                              widget.filteredSubjectData[i]["Url_Image"],
                              fit: BoxFit.fill,
                            ),
                          ),
                          Text(
                            widget.filteredSubjectData[i]["Subject_Name"],
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 80.r),
                          ),
                        ],
                      ),
                    ));
              }),
        ),
      ],
    );
  }

  void search(String query) {
    List<QueryDocumentSnapshot> results = [];
    if (query.isEmpty) {
      results = widget.Subject_data;
    } else {
      results = widget.Subject_data.where((subject) {
        // التحقق من الاسم الرئيسي للمادة
        bool matchSubjectName = subject['Subject_Name']
            .toString()
            .toLowerCase()
            .contains(query.toLowerCase());

        // التحقق من وجود الاسم في مصفوفة Search_Names
        bool matchSearchNames = (subject['Search_Names'] as List<dynamic>).any(
            (name) =>
                name.toString().toLowerCase().contains(query.toLowerCase()));

        // إرجاع true إذا كان أي من الشرطين صحيحًا
        return matchSubjectName || matchSearchNames;
      }).toList();
    }

    setState(() {
      widget.filteredSubjectData = results;
    });
  }

  TextEditingController Text1 = TextEditingController();
  TextEditingController Text2 = TextEditingController();

  Update(String id, int index) async {
    CollectionReference Update_Filse =
        FirebaseFirestore.instance.collection("Subject");
    if (Url_Image.isEmpty) {
      Url_Image = widget.filteredSubjectData[index]["Url_Image"];
    } else {
      await FirebaseStorage.instance
          .refFromURL(widget.filteredSubjectData[index]["Url_Image"])
          .delete();
    }
    await Update_Filse.doc(id)
        .update({
          "Subject_Name": Text1.text,
          "Search_Names": Text2.text.split(","),
          "Url_Image": Url_Image
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  File? file;
  String Url_Image = "";

  DialogEdit(String id, String text1, String text2, int index) {
    Text1.text = text1.toString();
    Text2.text = text2.toString();
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
                Hinttext: "Subject Name",
                Mycontroller: Text1,
              ),
              Mytextfield(
                Hinttext: "Search Names",
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
                      selectedindex: 0,
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
    // احصل على مرجع المستند الرئيسي
    var docRef = FirebaseFirestore.instance.collection('Subject').doc(docId);
    List<String> Files = ["Test_Bank", "Slide", "Exam", "Summary"];
    // احذف المجموعات الفرعية
    for(var i in Files){
    var subcollections = await docRef.collection(i).get();
    for (var doc in subcollections.docs) {
      await doc.reference.delete();
    }}
    // احذف المستند الرئيسي بعد حذف المجموعات الفرعية
    await docRef.delete();
  }

}
