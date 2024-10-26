import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../MytextField.dart';

class SubjectFiles extends StatefulWidget {
  const SubjectFiles(
      {super.key, required this.Subject_id, required this.Titile});

  final String Titile;
  final String Subject_id;

  @override
  State<SubjectFiles> createState() => _SubjectFilesState();
}

class _SubjectFilesState extends State<SubjectFiles> {
  TextEditingController Url_Files = TextEditingController();
  TextEditingController Name_Files = TextEditingController();
  List<String> Files = ["Test_Bank", "Slide", "Exam", "Summary"];
  List<List<QueryDocumentSnapshot>> Data = [[], [], [], []];
  int Mid_or_Final = 0;
  int pageindex = 0;

  Delete(String id) async {
    await FirebaseFirestore.instance
        .collection("Subject")
        .doc(widget.Subject_id)
        .collection(Files[pageindex])
        .doc(id)
        .delete();
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => SubjectFiles(
              Subject_id: widget.Subject_id,
              Titile: widget.Titile,
            )));
  }

  Add() async {
    CollectionReference Add_Filse = FirebaseFirestore.instance
        .collection("Subject")
        .doc(widget.Subject_id)
        .collection(Files[pageindex]);
    pageindex == 0
        ? await Add_Filse.add({
            "Name_File": Name_Files.text,
            "Url_File": Url_Files.text,
            "Mid_or_Final": Mid_or_Final
          })
            .then((value) => print("User Added"))
            .catchError((error) => print("Failed to add user: $error"))
        : await Add_Filse.add({
            "Name_File": Name_Files.text,
            "Url_File": Url_Files.text,
          })
            .then((value) => print("User Added"))
            .catchError((error) => print("Failed to add user: $error"));
  }

  Update(String id) async {
    CollectionReference Update_Filse = FirebaseFirestore.instance
        .collection("Subject")
        .doc(widget.Subject_id)
        .collection(Files[pageindex]);
    pageindex == 0
        ? await Update_Filse.doc(id)
            .update({
              "Name_File": Name_Files.text,
              "Url_File": Url_Files.text,
              "Mid_or_Final": Mid_or_Final
            })
            .then((value) => print("User Added"))
            .catchError((error) => print("Failed to add user: $error"))
        : await Update_Filse.doc(id)
            .update({
              "Name_File": Name_Files.text,
              "Url_File": Url_Files.text,
            })
            .then((value) => print("User Added"))
            .catchError((error) => print("Failed to add user: $error"));
  }

  DialogEdit(String id, String Name, String Url, int MorF) {
    Mid_or_Final = MorF;
    Name_Files.text = Name;
    Url_Files.text = Url;
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
                Hinttext: "URL File",
                Mycontroller: Url_Files,
              ),
              Mytextfield(
                Hinttext: "Name File",
                Mycontroller: Name_Files,
              ),
              if (pageindex == 0)
                RadioListTile(
                  title: Text("Mid"),
                  value: 0,
                  groupValue: Mid_or_Final,
                  onChanged: (value) {
                    setState(() {
                      Mid_or_Final = value!;
                    });
                  },
                ),
              if (pageindex == 0)
                RadioListTile(
                  title: Text("Final"),
                  value: 1,
                  groupValue: Mid_or_Final,
                  onChanged: (value) {
                    setState(() {
                      Mid_or_Final = value!;
                    });
                  },
                )
            ],
          );
        },
      ),
      btnOkOnPress: () {
        Update(id);
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => SubjectFiles(
                  Subject_id: widget.Subject_id,
                  Titile: widget.Titile,
                )));
      },
      btnCancelOnPress: () {
        Name_Files.text = "";
        Url_Files.text = "";
      },
    ).show();
  }

  getData() async {
    QuerySnapshot querySnapshot;

    for (int i = 0; i < Files.length; i++) {
      querySnapshot = await FirebaseFirestore.instance
          .collection("Subject")
          .doc(widget.Subject_id)
          .collection(Files[i]).orderBy("Name_File",descending: false)
          .get(); // استرجاع البيانات بدون ترتيب من Firebase

      // ترتيب البيانات محليًا حسب طول اسم الملف
      List<QueryDocumentSnapshot> docs = querySnapshot.docs;
      docs.sort((a, b) => (a['Name_File'].length).compareTo(b['Name_File'].length));

      // إضافة البيانات المرتبة إلى القائمة
      Data[i].addAll(docs);
    }

    setState(() {});
  }


  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> Body = [
      ListView(
        children: [
          ExpansionTile(
            title: Text("Mid"),
            children:
                Data[0].where((item) => item["Mid_or_Final"] == 0).map((item) {
              return ListTile(
                title: Text(item["Name_File"]),
                onTap: () {
                  launchUrl(Uri.parse(item["Url_File"]));
                },
                onLongPress: () {
                  AwesomeDialog(
                          context: context,
                          desc: "اختر ماذا تريد",
                          btnOkText: "تعديل",
                          btnOkOnPress: () {
                            DialogEdit(item.id, item["Name_File"],
                                item["Url_File"], item["Mid_or_Final"]);
                          },
                          btnCancelOnPress: () {
                            Delete(item.id);
                          },
                          btnCancelText: "حذف")
                      .show();
                },
              );
            }).toList(),
          ),
          ExpansionTile(
            title: Text("Final"),
            children:
                Data[0].where((item) => item["Mid_or_Final"] == 1).map((item) {
              return ListTile(
                title: Text(item["Name_File"]),
                onTap: () {
                  launchUrl(Uri.parse(item["Url_File"]));
                },
                onLongPress: () {
                  AwesomeDialog(
                          context: context,
                          desc: "اختر ماذا تريد",
                          btnOkText: "تعديل",
                          btnOkOnPress: () {
                            DialogEdit(item.id, item["Name_File"],
                                item["Url_File"], item["Mid_or_Final"]);
                          },
                          btnCancelOnPress: () {
                            Delete(item.id);
                          },
                          btnCancelText: "حذف")
                      .show();
                },
              );
            }).toList(),
          ),
        ],
      ), //===========================================11111111111
      ListView.builder(
          itemCount: Data[1].length,
          itemBuilder: (BuildContext, i) {
            return InkWell(
              onTap: () {
                launchUrl(Uri.parse(Data[1][i]["Url_File"]));
              },
              onLongPress: (){
                AwesomeDialog(
                    context: context,
                    desc: "اختر ماذا تريد",
                    btnOkText: "تعديل",
                    btnOkOnPress: () {
                      DialogEdit(Data[1][i].id, Data[1][i]["Name_File"],
                          Data[1][i]["Url_File"],0);
                    },
                    btnCancelOnPress: () {
                      Delete(Data[1][i].id);
                    },
                    btnCancelText: "حذف")
                    .show();
              },
              child: Card(
                child: Text(
                  Data[1][i]["Name_File"],
                  style: TextStyle(fontSize: 100.r),
                ),
              ),
            );
          }),
      ListView.builder(
          itemCount: Data[2].length,
          itemBuilder: (BuildContext, i) {
            return InkWell(
              onTap: () {
                launchUrl(Uri.parse(Data[2][i]["Url_File"]));
              },
              onLongPress: (){ AwesomeDialog(
                  context: context,
                  desc: "اختر ماذا تريد",
                  btnOkText: "تعديل",
                  btnOkOnPress: () {
                    DialogEdit(Data[2][i].id, Data[2][i]["Name_File"],
                        Data[2][i]["Url_File"],0);},
                    btnCancelOnPress: () {
                    Delete(Data[2][i].id);
                  },
                  btnCancelText: "حذف")
                  .show();},
              child: Card(
                child: Text(
                  Data[2][i]["Name_File"],
                  style: TextStyle(fontSize: 100.r),
                ),
              ),
            );
          }),
      ListView.builder(
          itemCount: Data[3].length,
          itemBuilder: (BuildContext, i) {
            return InkWell(
              onTap: () {
                launchUrl(Uri.parse(Data[3][i]["Url_File"]));
              },
              onLongPress: () {
                AwesomeDialog(
                        context: context,
                        desc: "اختر ماذا تريد",
                        btnOkText: "تعديل",
                        btnOkOnPress: () {
                          DialogEdit(Data[3][i].id, Data[3][i]["Name_File"],
                              Data[3][i]["Url_File"],0);
                        },
                        btnCancelOnPress: () {
                          Delete(Data[3][i].id);
                        },
                        btnCancelText: "حذف")
                    .show();
              },
              child: Card(
                child: Text(
                  Data[3][i]["Name_File"],
                  style: TextStyle(fontSize: 100.r),
                ),
              ),
            );
          }),
    ];
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
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
                        Hinttext: "URL File",
                        Mycontroller: Url_Files,
                      ),
                      Mytextfield(
                        Hinttext: "Name File",
                        Mycontroller: Name_Files,
                      ),
                      if (pageindex == 0)
                        RadioListTile(
                          title: Text("Mid"),
                          value: 0,
                          groupValue: Mid_or_Final,
                          onChanged: (value) {
                            setState(() {
                              Mid_or_Final = value!;
                            });
                          },
                        ),
                      if (pageindex == 0)
                        RadioListTile(
                          title: Text("Final"),
                          value: 1,
                          groupValue: Mid_or_Final,
                          onChanged: (value) {
                            setState(() {
                              Mid_or_Final = value!;
                            });
                          },
                        )
                    ],
                  );
                },
              ),
              btnOkOnPress: () {
                Add();
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => SubjectFiles(
                          Subject_id: widget.Subject_id,
                          Titile: widget.Titile,
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
        appBar: AppBar(
          title: Text(widget.Titile),
          bottom: TabBar(
            tabAlignment: TabAlignment.center,
            onTap: (val) {
              pageindex = val;
            },
            tabs: [
              Tab(
                  child: Text(
                "تيست بانك",
                style: TextStyle(fontSize: 39.r),
              )),
              Tab(
                  child: Text(
                "السلايدات",
                style: TextStyle(fontSize: 39.r),
              )),
              Tab(
                  child: Text(
                "امتحانات محوسبة",
                style: TextStyle(fontSize: 39.r),
              )),
              Tab(
                  child: Text(
                "ملخصات",
                style: TextStyle(fontSize: 39.r),
              )),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ...List.generate(Body.length, (i) => Body[i]),
          ],
        ),
      ),
    );
  }
}
