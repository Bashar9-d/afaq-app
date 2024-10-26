import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../home_page.dart';
import 'information_major.dart';
import 'list_page.dart';
import 'my_drawer.dart';

class MajorPage extends StatefulWidget {
  const MajorPage({super.key});

  @override
  State<MajorPage> createState() => _MajorPageState();
}

class _MajorPageState extends State<MajorPage> {
  List<QueryDocumentSnapshot> Major_data = [];
  GlobalKey<ScaffoldState> keyscafolder = GlobalKey();
  bool isloading = true;
  getdata() async {
    isloading = true;
    QuerySnapshot querySnapshot;
    querySnapshot = await FirebaseFirestore.instance.collection("Major").get();
    Major_data.addAll(querySnapshot.docs);
    setState(() {});
    isloading = false;
  }

  @override
  void initState() {
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 800) {
        return Scaffold(
          key: keyscafolder,
          endDrawer: Drawer(child: MyDrawer(keyscafolder: keyscafolder)),
          appBar: AppBar(
            iconTheme: IconThemeData(size: 80.r, color: Colors.black),
            backgroundColor: Colors.blue[900],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                ClipPath(
                  clipper: TopWaveClipper(),
                  child: Container(
                      padding: EdgeInsets.only(bottom: 400.r),
                      color: Colors.blue[900],
                      height: 800.r,
                      child: Center(
                          child: Text(
                        "تخصصات الكلية",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 130.r,
                            fontWeight: FontWeight.bold),
                      ))),
                ),
                SizedBox(
                  height: 100.r,
                ),
           isloading ?SizedBox(height: 3000.r,) :Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.center,
                  children: [
                    ...List.generate(Major_data.length, (i) {
                      return InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => InformationMajor(
                                      Major_id: Major_data[i].id,
                                      information: Major_data[i]
                                          ["Information_Major"],
                                      Major_name: Major_data[i]["Major_Name"],
                                      Url_image: Major_data[i]["Url_Image"],
                                    )));
                          },
                          child: Stack(
                            children: [
                              Container(
                                margin: EdgeInsets.all(49.r),
                                padding: EdgeInsets.all(10.r),
                                height: 450.r,
                                width: 450.r,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(500.r)),
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Colors.blue.shade900, width: 2)),
                                child: Container(
                                  height: 400.r,
                                  width: 400.r,
                                  decoration: BoxDecoration(
                                      color: Colors.blue[900],
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(500.r))),
                                  alignment: Alignment.center,
                                  child: Text(
                                    Major_data[i]["Major_Name"],
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 70.r),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              )
                            ],
                          ));
                    })
                  ],
                ),
                ClipPath(
                  clipper: BottomWaveClipper(),
                  child: Container(
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
            ),
          ),
        );
      } else {
        return Scaffold(
          key: keyscafolder,
          appBar: AppBar(
            iconTheme: IconThemeData(size: 80.r, color: Colors.black),
            backgroundColor: Colors.blue[900],
            title:Container(
                alignment: const Alignment(1,0),child: const ListPage()),

          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                ClipPath(
                  clipper: TopWaveClipper(),
                  child: Container(
                      padding: EdgeInsets.only(bottom: 400.r),
                      color: Colors.blue[900],
                      height: 800.r,
                      child: Center(
                          child: Text(
                        "تخصصات الكلية",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 130.r,
                            fontWeight: FontWeight.bold),
                      ))),
                ),
                SizedBox(
                  height: 100.r,
                ),
                isloading ?SizedBox(height: 3000.r,) :Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.center,
                  children: [
                    ...List.generate(Major_data.length, (i) {
                      return InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => InformationMajor(
                                  Major_id: Major_data[i].id,
                                  information: Major_data[i]
                                  ["Information_Major"],
                                  Major_name: Major_data[i]["Major_Name"],
                                  Url_image: Major_data[i]["Url_Image"],
                                )));
                          },
                          child: Stack(
                            children: [
                              Container(
                                margin: EdgeInsets.all(49.r),
                                padding: EdgeInsets.all(10.r),
                                height: 450.r,
                                width: 450.r,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(500.r)),
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Colors.blue.shade900, width: 2)),
                                child: Container(
                                  height: 400.r,
                                  width: 400.r,
                                  decoration: BoxDecoration(
                                      color: Colors.blue[900],
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(500.r))),
                                  alignment: Alignment.center,
                                  child: Text(
                                    Major_data[i]["Major_Name"],
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 70.r),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              )
                            ],
                          ));
                    })
                  ],
                ),
                SizedBox(
                  height: 100.r,
                ),
                ClipPath(
                  clipper: BottomWaveClipper(),
                  child: Container(
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
            ),
          ),
        );
      }
    });
  }
}
