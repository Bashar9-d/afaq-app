
import 'package:animate_on_hover/animate_on_hover.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../home_page.dart';
import 'list_page.dart';
import 'my_drawer.dart';

class DoctorEmailPage extends StatefulWidget {
  const DoctorEmailPage({super.key});

  @override
  State<DoctorEmailPage> createState() => _DoctorEmailPageState();
}

class _DoctorEmailPageState extends State<DoctorEmailPage> {
  List<QueryDocumentSnapshot> Doctor_Data = [];
  bool isloading = true;
  getdata() async {
     isloading = true;
    QuerySnapshot querySnapshot;
    querySnapshot = await FirebaseFirestore.instance.collection("Doctor").get();
    Doctor_Data.addAll(querySnapshot.docs);
      isloading = false;
    setState(() {});
  }

  @override
  void initState() {
    getdata();
    super.initState();
  }

  String searchQuery = "";
  GlobalKey<ScaffoldState> keyscafolder = GlobalKey();

  @override
  Widget build(BuildContext context) {
    List<QueryDocumentSnapshot> filteredData = Doctor_Data.where((doc) {
      String doctorName = doc["Doctor_Name"];
      return doctorName.contains(searchQuery);
    }).toList();
    return LayoutBuilder(builder: (context, constraints) {
      if(constraints.maxWidth<800){return Scaffold(
        key: keyscafolder,
        endDrawer: Drawer(
          child: MyDrawer(keyscafolder: keyscafolder),
        ),
        appBar: AppBar(
          backgroundColor: Colors.blue[900],
          iconTheme: IconThemeData(size: 80.r, color: Colors.black),
        ),
        body: SingleChildScrollView(
            child: Column(
              children: [
                ClipPath(
                  clipper: TopWaveClipper(),
                  child: Container(
                    padding: EdgeInsets.only(bottom: 250.r),
                    color: Colors.blue[900],
                    height: 700.r,
                    child: Center(
                      child: Text(
                        "ايميلات الدكاترة",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 130.r,fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              isloading?SizedBox(height:3000.r) : Wrap(
                  crossAxisAlignment: WrapCrossAlignment.end,
                  alignment: WrapAlignment.center,
                  children: [
                    SizedBox(
                      height: 100.r,
                    ),
                    // حقل الإدخال للبحث
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.r, horizontal: 20.r),
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            searchQuery = value; // تحديث استعلام البحث عند الكتابة
                          });
                        },
                        decoration: InputDecoration(
                          labelText: "ابحث عن الدكتور",
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.blue.shade900,
                            size: 100.r,
                          ),
                          border: OutlineInputBorder(
                              borderSide:
                              BorderSide(width: 4, color: Colors.blue.shade900),
                              borderRadius: BorderRadius.all(Radius.circular(50.r))),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(width: 4, color: Colors.blue.shade900),
                              borderRadius: BorderRadius.all(Radius.circular(50.r))),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(width: 4, color: Colors.blue.shade900),
                              borderRadius: BorderRadius.all(Radius.circular(50.r))),
                        ),
                      ),
                    ),
                    ...List.generate(
                      filteredData.length,
                          (i) {
                        final Uri uriEmail = Uri(
                            scheme: 'mailto', path: filteredData[i]["Doctor_Email"]);
                        return InkWell(
                            onTap: () {
                              launchUrl(uriEmail);
                            },
                            child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 50.r, vertical: 10.r),
                                child: Card(
                                    color: Colors.blue[900],
                                    margin: EdgeInsets.symmetric(vertical: 20.r),
                                    child: SizedBox(
                                      width: 1000.r,
                                      child: Padding(
                                        padding: EdgeInsets.only(right: 60.r),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              "${filteredData[i]["Doctor_Name"]}",
                                              style: TextStyle(
                                                  fontSize: 80.r,
                                                  color: Colors.white),
                                              textAlign: TextAlign.end,
                                            ),
                                            Text(
                                              "  ${filteredData[i]["Doctor_Email"]} : ايميل الدكتور",
                                              style: TextStyle(
                                                  fontSize: 40.r,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ))).increaseSizeOnHover(1.1,
                                duration: const Duration(milliseconds: 400)));
                      },
                    ),
                  ],
                ),
                ClipPath(
                  clipper: BottomWaveClipper(),
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    color: Colors.blue[900],
                    height: 1000.r,
                    child: Center(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 200.r,
                            ),
                            Text(
                              "لا تنسوا متابعتنا على\nمواقع التواصل الاجتماعي",
                              style: TextStyle(
                                  fontSize: 80.r,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 50.r,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(width: 100.r,),
                                InkWell(
                                    onTap: () {
                                      launchUrl(Uri.parse("https://www.instagram.com/afaq.aabu?igsh=Y2Mwanl1YjR0NDdw"));
                                    },
                                    child: Image.asset(
                                      "images/Instagram.png",
                                      width: 130.r,
                                      height: 130.r,
                                    )),
                                SizedBox(width: 100.r,),
                                InkWell(
                                    onTap: () {launchUrl(Uri.parse("https://chat.whatsapp.com/C8HnajkM3tO3w3BpzTgv3r"));},
                                    child: Image.asset(
                                      "images/whatsapp.png",
                                      width: 130.r,
                                      height: 130.r,
                                    )),
                                SizedBox(width: 100.r,),
                                InkWell(
                                    onTap: () {launchUrl(Uri.parse("https://www.facebook.com/share/Rqfx6nDFGdjXDyG6/"));},
                                    child: Image.asset(
                                      "images/facebook.png",
                                      width: 130.r,
                                      height: 130.r,
                                    )),
                                SizedBox(width: 100.r,),
                              ],
                            ),
                            SizedBox(
                              height: 100.r,
                            ),
                            Text("AFAQ TEAM © جميع الحقوق محفوظة",
                                style: TextStyle(fontSize: 40.r, color: Colors.white)),
                            SizedBox(
                              height: 20.r,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: (){  launchUrl(Uri.parse(
                                      "https://www.linkedin.com/in/bashar-shaqour-320b922a7/?lipi=urn%3Ali%3Apage%3Ad_flagship3_profile_verification_details%3B%2FQt%2BCqYdS%2BaBT1PwZlFADQ%3D%3D"));
                                  },
                                  child:Text(" بشار الشقور : ",
                                      style: TextStyle(fontSize: 50.r, color: Colors.blue)) ,)
                                ,
                                Text("قام بتطوير البرنامج  ",
                                    style: TextStyle(fontSize: 40.r, color: Colors.white)),],)
                          ],
                        )),
                  ),
                ),
              ],
            )),
      );}
      else{return Scaffold(
        key: keyscafolder,

        appBar: AppBar(
          backgroundColor: Colors.blue[900],
          iconTheme: IconThemeData(size: 80.r, color: Colors.black),
          title:Container(
              alignment: const Alignment(1,0),child: const ListPage()),

        ),
        body: SingleChildScrollView(
            child: Column(
              children: [
                ClipPath(
                  clipper: TopWaveClipper(),
                  child: Container(
                    padding: EdgeInsets.only(bottom: 250.r),
                    color: Colors.blue[900],
                    height: 700.r,
                    child: Center(
                      child: Text(
                        "ايميلات الدكاترة",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 130.r,fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                isloading?SizedBox(height:3000.r) : Wrap(
                  crossAxisAlignment: WrapCrossAlignment.end,
                  alignment: WrapAlignment.center,
                  children: [
                    SizedBox(
                      height: 100.r,
                    ),
                    // حقل الإدخال للبحث
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.r, horizontal: 20.r),
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            searchQuery = value; // تحديث استعلام البحث عند الكتابة
                          });
                        },
                        decoration: InputDecoration(
                          labelText: "ابحث عن الدكتور",
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.blue.shade900,
                            size: 100.r,
                          ),
                          border: OutlineInputBorder(
                              borderSide:
                              BorderSide(width: 4, color: Colors.blue.shade900),
                              borderRadius: BorderRadius.all(Radius.circular(50.r))),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(width: 4, color: Colors.blue.shade900),
                              borderRadius: BorderRadius.all(Radius.circular(50.r))),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(width: 4, color: Colors.blue.shade900),
                              borderRadius: BorderRadius.all(Radius.circular(50.r))),
                        ),
                      ),
                    ),
                    ...List.generate(
                      filteredData.length,
                          (i) {
                        final Uri uriEmail = Uri(
                            scheme: 'mailto', path: filteredData[i]["Doctor_Email"]);
                        return InkWell(
                            onTap: () {
                              launchUrl(uriEmail);
                            },
                            child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 50.r, vertical: 10.r),
                                child: Card(
                                    color: Colors.blue[900],
                                    margin: EdgeInsets.symmetric(vertical: 20.r),
                                    child: SizedBox(
                                      width: 1000.r,
                                      child: Padding(
                                        padding: EdgeInsets.only(right: 60.r),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              "${filteredData[i]["Doctor_Name"]}",
                                              style: TextStyle(
                                                  fontSize: 80.r,
                                                  color: Colors.white),
                                              textAlign: TextAlign.end,
                                            ),
                                            Text(
                                              "  ${filteredData[i]["Doctor_Email"]} : ايميل الدكتور",
                                              style: TextStyle(
                                                  fontSize: 40.r,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ))).increaseSizeOnHover(1.1,
                                duration: const Duration(milliseconds: 400)));
                      },
                    ),
                  ],
                ),
                ClipPath(
                  clipper: BottomWaveClipper(),
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    color: Colors.blue[900],
                    height: 1000.r,
                    child: Center(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 200.r,
                            ),
                            Text(
                              "لا تنسوا متابعتنا على\nمواقع التواصل الاجتماعي",
                              style: TextStyle(
                                  fontSize: 80.r,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 50.r,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(width: 100.r,),
                                InkWell(
                                    onTap: () {
                                      launchUrl(Uri.parse("https://www.instagram.com/afaq.aabu?igsh=Y2Mwanl1YjR0NDdw"));
                                    },
                                    child: Image.asset(
                                      "images/Instagram.png",
                                      width: 130.r,
                                      height: 130.r,
                                    )),
                                SizedBox(width: 100.r,),
                                InkWell(
                                    onTap: () {launchUrl(Uri.parse("https://chat.whatsapp.com/C8HnajkM3tO3w3BpzTgv3r"));},
                                    child: Image.asset(
                                      "images/whatsapp.png",
                                      width: 130.r,
                                      height: 130.r,
                                    )),
                                SizedBox(width: 100.r,),
                                InkWell(
                                    onTap: () {launchUrl(Uri.parse("https://www.facebook.com/share/Rqfx6nDFGdjXDyG6/"));},
                                    child: Image.asset(
                                      "images/facebook.png",
                                      width: 130.r,
                                      height: 130.r,
                                    )),
                                SizedBox(width: 100.r,),
                              ],
                            ),
                            SizedBox(
                              height: 100.r,
                            ),
                            Text("AFAQ TEAM © جميع الحقوق محفوظة",
                                style: TextStyle(fontSize: 40.r, color: Colors.white)),
                            SizedBox(
                              height: 20.r,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: (){  launchUrl(Uri.parse(
                                      "https://www.linkedin.com/in/bashar-shaqour-320b922a7/?lipi=urn%3Ali%3Apage%3Ad_flagship3_profile_verification_details%3B%2FQt%2BCqYdS%2BaBT1PwZlFADQ%3D%3D"));
                                  },
                                  child:Text(" بشار الشقور : ",
                                      style: TextStyle(fontSize: 50.r, color: Colors.blue)) ,)
                                ,
                                Text("قام بتطوير البرنامج  ",
                                    style: TextStyle(fontSize: 40.r, color: Colors.white)),],)
                          ],
                        )),
                  ),
                ),
              ],
            )),
      );}
    });
  }
}
