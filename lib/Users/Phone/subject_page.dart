
import 'package:afaq/Users/Phone/my_drawer.dart';
import 'package:afaq/Users/Phone/subject_files_users.dart';
import 'package:animate_on_hover/animate_on_hover.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../home_page.dart';
import 'list_page.dart';

class SubjectPage extends StatefulWidget {
  const SubjectPage({
    super.key,
  });

  @override
  State<SubjectPage> createState() => _SubjectPageState();
}

class _SubjectPageState extends State<SubjectPage> {
  TextEditingController searchController = TextEditingController();
  List<QueryDocumentSnapshot> Subject_data = [];
  List<QueryDocumentSnapshot> filteredSubjectData = [];
  bool isloading = true;
  getdata() async {
     isloading = true;
    QuerySnapshot querySnapshot;
    querySnapshot =
        await FirebaseFirestore.instance.collection("Subject").get();
    Subject_data.addAll(querySnapshot.docs);
    filteredSubjectData.addAll(querySnapshot.docs);
     isloading = false;
    setState(() {});
  }

  Map<String, List<List<QueryDocumentSnapshot>>>? Sup_Data = {};

  List<String> Files = ["Test_Bank", "Slide", "Exam", "Summary"];

  getdataSub(String id) async {
    QuerySnapshot querySnapshot;

    // Ensure Sup_Data and the sub-lists are initialized
    Sup_Data ??= {};
    Sup_Data![id] ??= List.generate(Files.length, (index) => []);

    for (int i = 0; i < Files.length; i++) {
      querySnapshot = await FirebaseFirestore.instance
          .collection("Subject")
          .doc(id)
          .collection(Files[i]).orderBy("Name_File",descending: false)
          .get();
      List<QueryDocumentSnapshot> docs = querySnapshot.docs;
      docs.sort((a, b) => (a['Name_File'].length).compareTo(b['Name_File'].length));
      Sup_Data![id]![i].addAll(docs);
    }

    setState(() {});
  }

  @override
  void initState() {
    getdata();
    super.initState();
  }

  GlobalKey<ScaffoldState> keyscafolder = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if(constraints.maxWidth<800){
    return  Scaffold(
        key: keyscafolder,
        endDrawer:Drawer(child: MyDrawer(keyscafolder: keyscafolder)),
        appBar: AppBar( iconTheme: IconThemeData(size: 80.r, color: Colors.black),backgroundColor: Colors.blue[900] ,),
        body: SingleChildScrollView(
    child:Column(
          children: [
        Column(
    children: [
          ClipPath(
            clipper: TopWaveClipper(),
            child: Container(
                color: Colors.blue[900],
                height: 800.r,
                child: Center(
                    child:  Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 100.r,),
                        Text(
                          "مكتبة المواد",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: 100.r,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Text(
                          "نقدم لكم في مكتبة المواد كل ما يلزم الطالب في دراسته من ملفات وشروحات من إعداد اللجنة الأكاديمية بفريق آفاق التكنولوجيا",
                          textAlign: TextAlign.center,
                          style:
                          TextStyle(fontSize: 55.r, color: Colors.white),
                        )
                      ],
                    ),)
                ))]),

            Padding(
              padding: EdgeInsets.symmetric(vertical: 50.r, horizontal: 50.r),
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  search(
                      value); // تحديث نتائج البحث عند تغيير النص في حقل البحث
                },
                decoration: InputDecoration(
                  labelText: 'Search',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(100.r))),
                  suffixIcon: const Icon(Icons.search),
                ),
              ),
            ),
       isloading  ? SizedBox(height: 3000.h,):Wrap(
           crossAxisAlignment: WrapCrossAlignment.center,
           alignment: WrapAlignment.center,
           children: [
             ...List.generate(filteredSubjectData.length, (i) {
               if (Sup_Data![filteredSubjectData[i].id] == null) {
                 getdataSub(filteredSubjectData[i].id);
               }
               return InkWell(
                   onTap: () {
                     final subjectId = filteredSubjectData[i].id;
                     final subjectFiles =
                     Sup_Data![subjectId];
                     if (subjectFiles != null) {
                       Navigator.of(context).push(MaterialPageRoute(
                         builder: (context) => SubjectFilesUsers(
                           Sup_Data: subjectFiles,

                           Titile: filteredSubjectData[i]["Subject_Name"],Url_Image:filteredSubjectData[i]["Url_Image"] ,
                         ),
                       ));
                     }
                   },
                   child: Container(

                     padding: EdgeInsets.only(bottom: 50.r),
                     margin: EdgeInsets.symmetric(
                         vertical: 30.r, horizontal: 60.r),
                     width: 1000.r,

                     decoration: BoxDecoration(
                         color: Colors.white,
                         border: Border.all(color: Colors.black, width: 2)),
                     child: Column(
                       crossAxisAlignment:CrossAxisAlignment.center,
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [

                         SizedBox(
                             height: 500.h,
                             width: 1000.r,
                             child: Image.network(
                               filteredSubjectData[i]["Url_Image"] ,
                               fit: BoxFit.fill,
                             )),
                         Text(
                           filteredSubjectData[i]["Subject_Name"],
                           style: TextStyle(fontSize: 90.r,),textAlign: TextAlign.center,
                         ),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceAround,
                           children: [
                             Container(
                               alignment: Alignment.center,
                               height: 80.r,
                               decoration: BoxDecoration(
                                   color: HexColor("#25D6DD"),
                                   borderRadius: BorderRadius.circular(20.r)),
                               child: Text(
                                 "(${Sup_Data![filteredSubjectData[i].id]![2].length})اختبار محوسب",
                                 style: TextStyle(fontSize: 40.r),
                               ),
                             ),
                             Container(
                               alignment: Alignment.center,
                               width: 300.r,
                               height: 80.r,
                               decoration: BoxDecoration(
                                   color: HexColor("#25D6DD"),
                                   borderRadius: BorderRadius.circular(20.r)),
                               child: Text(
                                 "(${Sup_Data![filteredSubjectData[i].id]![3].length})ملخصات",
                                 style: TextStyle(fontSize: 40.r),
                               ),
                             ),
                             Container(
                               alignment: Alignment.center,
                               width: 300.r,
                               height: 80.r,
                               decoration: BoxDecoration(
                                   color: HexColor("#25D6DD"),
                                   borderRadius: BorderRadius.circular(20.r)),
                               child: Text(
                                 "(${Sup_Data![filteredSubjectData[i].id]![0].length})تست بانك",
                                 style: TextStyle(fontSize: 40.r),
                               ),
                             )
                           ],
                         ),
                       ],
                     ),
                   ).increaseSizeOnHover(1.1,duration:  const Duration(milliseconds:400)));
             })
           ]),
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
        )));
  }
    else{
        return  Scaffold(
            appBar:AppBar( iconTheme: IconThemeData(size: 80.r, color: Colors.black),backgroundColor: Colors.blue[900] ,
                    title:Container(
                        alignment: const Alignment(1,0),child: const ListPage()),

            ),
            body: SingleChildScrollView(
                child:Column(
                  children: [
                    Column(
                        children: [
                          ClipPath(
                              clipper: TopWaveClipper(),
                              child: Container(
                                  color: Colors.blue[900],
                                  height: 800.r,
                                  child: Center(
                                    child:  Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(height: 100.r,),
                                        Text(
                                          "مكتبة المواد",
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                              fontSize: 100.r,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                        Text(
                                          "نقدم لكم في مكتبة المواد كل ما يلزم الطالب في دراسته من ملفات وشروحات من إعداد اللجنة الأكاديمية بفريق آفاق التكنولوجيا",
                                          textAlign: TextAlign.center,
                                          style:
                                          TextStyle(fontSize: 55.r, color: Colors.white),
                                        )
                                      ],
                                    ),)
                              ))]),

                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 50.r, horizontal: 50.r),
                      child: TextField(
                        controller: searchController,
                        onChanged: (value) {
                          search(
                              value); // تحديث نتائج البحث عند تغيير النص في حقل البحث
                        },
                        decoration: InputDecoration(
                          labelText: 'Search',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(100.r))),
                          suffixIcon: const Icon(Icons.search),
                        ),
                      ),
                    ),
                    isloading  ? SizedBox(height: 3000.h,):Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        alignment: WrapAlignment.center,
                        children: [
                          ...List.generate(filteredSubjectData.length, (i) {
                            if (Sup_Data![filteredSubjectData[i].id] == null) {
                              getdataSub(filteredSubjectData[i].id);
                            }
                            return InkWell(
                                onTap: () {
                                  final subjectId = filteredSubjectData[i].id;
                                  final subjectFiles =
                                  Sup_Data![subjectId];
                                  if (subjectFiles != null) {
                                    Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => SubjectFilesUsers(
                                        Sup_Data: subjectFiles,

                                        Titile: filteredSubjectData[i]["Subject_Name"],Url_Image:filteredSubjectData[i]["Url_Image"] ,
                                      ),
                                    ));
                                  }
                                },
                                child: Container(

                                  padding: EdgeInsets.only(bottom: 50.r),
                                  margin: EdgeInsets.symmetric(
                                      vertical: 30.r, horizontal: 60.r),
                                  width: 1000.r,

                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.black, width: 2)),
                                  child: Column(
                                    crossAxisAlignment:CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [

                                      SizedBox(
                                          height: 500.h,
                                          width: 1000.r,
                                          child: Image.network(
                                            filteredSubjectData[i]["Url_Image"] ,
                                            fit: BoxFit.fill,
                                          )),
                                      Text(
                                        filteredSubjectData[i]["Subject_Name"],
                                        style: TextStyle(fontSize: 90.r,),textAlign: TextAlign.center,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Container(
                                            alignment: Alignment.center,
                                            height: 80.r,
                                            decoration: BoxDecoration(
                                                color: HexColor("#25D6DD"),
                                                borderRadius: BorderRadius.circular(20.r)),
                                            child: Text(
                                              "(${Sup_Data![filteredSubjectData[i].id]![2].length})اختبار محوسب",
                                              style: TextStyle(fontSize: 40.r),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            width: 300.r,
                                            height: 80.r,
                                            decoration: BoxDecoration(
                                                color: HexColor("#25D6DD"),
                                                borderRadius: BorderRadius.circular(20.r)),
                                            child: Text(
                                              "(${Sup_Data![filteredSubjectData[i].id]![3].length})ملخصات",
                                              style: TextStyle(fontSize: 40.r),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            width: 300.r,
                                            height: 80.r,
                                            decoration: BoxDecoration(
                                                color: HexColor("#25D6DD"),
                                                borderRadius: BorderRadius.circular(20.r)),
                                            child: Text(
                                              "(${Sup_Data![filteredSubjectData[i].id]![0].length})تست بانك",
                                              style: TextStyle(fontSize: 40.r),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ).increaseSizeOnHover(1.1,duration:  const Duration(milliseconds:400)));
                          })
                        ]),
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
                )));
      }});
  }

  void search(String query) {
    List<QueryDocumentSnapshot> results = [];
    if (query.isEmpty) {
      results = Subject_data;
    } else {
      results = Subject_data.where((subject) {
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
      filteredSubjectData = results;
    });
  }
}
