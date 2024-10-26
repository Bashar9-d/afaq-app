import 'package:afaq/Admin/home/subject_home.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'Add/add_email_doctor.dart';
import 'Add/add_folder_subject.dart';
import 'Add/add_major.dart';
import 'Majors.dart';
import 'doctor_email_admin_page.dart';
class DatabasePage extends StatefulWidget {
 DatabasePage({super.key, required this.selectedindex});
  final int selectedindex;
  @override
  State<DatabasePage> createState() => _DatabasePageState();
}

class _DatabasePageState extends State<DatabasePage> {

  bool isloading = true;
  TextEditingController searchController = TextEditingController();
  List<List<QueryDocumentSnapshot>> Data = [[], [], [], []];
  List<String> NameData = ["Subject", "Doctor","Major"];
  getdata() async {
    isloading = true;
    QuerySnapshot querySnapshot;
    for (int i = 0; i < NameData.length; i++) {
      querySnapshot =
          await FirebaseFirestore.instance.collection(NameData[i]).get();
      Data[i].addAll(querySnapshot.docs);
    }
    isloading = false;
    setState(() {});
  }

  @override
  void initState() {
    selectedindex=widget.selectedindex;
    getdata();
    super.initState();
  }

   int? selectedindex ;

  @override
  Widget build(BuildContext context) {
    List<Widget> list = [
      SubjectHome(
        Subject_data: Data[0],
        filteredSubjectData: Data[0],
      ),
      DoctorEmailAdminPage(Doctor_Data: Data[1]),
      Majors(Major_data: Data[2],)

    ];
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            switch (selectedindex) {
              case 0:
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.noHeader,
                  animType: AnimType.bottomSlide,
                  body: StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return const AddFolderSubject();
                    },
                  ),
                ).show();
                break;
              case 1:
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.noHeader,
                  animType: AnimType.bottomSlide,
                  body: StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return const AddEmailDoctor();
                    },
                  ),
                ).show();
                break;
              case 2:
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.noHeader,
                  animType: AnimType.bottomSlide,
                  body: StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return const AddMajor();
                    },
                  ),
                ).show();
                break;
            }
          },
          child: const Icon(Icons.add),
        ),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: selectedindex!,
            onTap: (value) {
              selectedindex = value;
              setState(() {});
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.book), label: "subject"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.email), label: "Dr email"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.map), label: "Majors"),

            ]),
        body: isloading
            ? const Center(child: CircularProgressIndicator())
            : list.elementAt(selectedindex!));
  }

}
