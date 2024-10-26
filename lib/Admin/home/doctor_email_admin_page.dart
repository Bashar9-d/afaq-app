import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'database_page.dart';

class DoctorEmailAdminPage extends StatefulWidget {
  DoctorEmailAdminPage({super.key, required this.Doctor_Data});

  List<QueryDocumentSnapshot> Doctor_Data;

  @override
  State<DoctorEmailAdminPage> createState() => _DoctorEmailAdminPageState();
}

class _DoctorEmailAdminPageState extends State<DoctorEmailAdminPage> {
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    // تصفية البيانات بناءً على استعلام البحث
    List<QueryDocumentSnapshot> filteredData = widget.Doctor_Data.where((doc) {
      String doctorName = doc["Doctor_Name"];
      return doctorName.contains(searchQuery);
    }).toList();

    return Column(
      children: [
        SizedBox(height:100.r ,),
        // حقل الإدخال للبحث
        Padding(
          padding:EdgeInsets.symmetric(vertical: 20.r,horizontal: 20.r),
          child: TextField(
            onChanged: (value) {
              setState(() {
                searchQuery = value; // تحديث استعلام البحث عند الكتابة
              });
            },
            decoration: const InputDecoration(
              labelText: "ابحث عن الدكتور",
              suffixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
          ),
        ),
        // عرض البيانات المفلترة
        Expanded(
          child: ListView.builder(
            itemCount: filteredData.length,
            itemBuilder: (BuildContext, i) {
              return InkWell(
                  onLongPress: () async {
                    AwesomeDialog(
                            context: (context),
                            desc: "هل تريد حذف هذا المجلد",
                            dialogType: DialogType.warning,
                            btnOkOnPress: () async {
                              await FirebaseFirestore.instance
                                  .collection("Doctor")
                                  .doc(filteredData[i].id)
                                  .delete();
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                           DatabasePage(selectedindex: 1,)));
                            },
                            btnCancelOnPress: () {})
                        .show();
                  },
                  child: Card(
                    margin:
                        EdgeInsets.symmetric(horizontal: 70.r, vertical: 20.r),
                    child: Padding(
                      padding: EdgeInsets.only(right: 60.r),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "${filteredData[i]["Doctor_Name"]}",
                            style: TextStyle(fontSize: 70.r),
                            textAlign: TextAlign.end,
                          ),
                          Text(
                            "  ${filteredData[i]["Doctor_Email"]} : الايميل",
                            style: TextStyle(fontSize: 50.r),
                          ),
                        ],
                      ),
                    ),
                  ));
            },
          ),
        ),
      ],
    );
  }
}
