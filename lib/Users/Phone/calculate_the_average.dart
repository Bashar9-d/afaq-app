import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../home_page.dart';
import 'list_page.dart';
import 'my_drawer.dart';
import 'my_dropdown.dart';

class CalculateTheAverage extends StatefulWidget {
  const CalculateTheAverage({super.key});
  @override
  State<CalculateTheAverage> createState() => _CalculateTheAverageState();}

class _CalculateTheAverageState extends State<CalculateTheAverage> {
  List<List<String>> Mylist = [
    [" س.م", " رمز المادة", " الرمز السابق"]
  ];
  int time = 0;
  double GPA = 0;
  double Semester_average=0.0;
  String Semester_average_Rat="";
  String GPA_Rat="";
  String? selectedValue;
  Map<String, double> Subject_symbol = {
    "A+": 4.0,
    "A": 3.75,
    "A-": 3.5,
    "B+": 3.25,
    "B": 3.0,
    "B-": 2.75,
    "C+": 2.5,
    "C": 2.25,
    "C-": 2.0,
    "D+": 1.75,
    "D": 1.5,
    "F": 0.75
  };
  TextEditingController controllertime=TextEditingController();
  TextEditingController controlleravrage=TextEditingController();
  GlobalKey<ScaffoldState> keyscafolder=GlobalKey();
  String What_Rating(double avg){
    switch (avg) {
      case >=3.50:
      return"امتياز";
      case >=3.00:
      return"جيد جدا";
      case >=2.50:
      return"جيد";
      case >2:
      return"مقبول";
      default:
       return"ضعيف";
    }

  }
  Calculate_Average() {
    int timeNow = 0;
    GPA *= time;
    Semester_average = 0.0;
    for (int i = 0; i < Mylist.length; i++) {
      if (Mylist[i][0] != " س.م" && Mylist[i][1] != " رمز المادة") {
        int t = int.parse(Mylist[i][0]);
        if (Mylist[i][2] == " الرمز السابق") {
          Semester_average =
              (Semester_average + Subject_symbol[Mylist[i][1]]! * t);
          time += t;
          timeNow += t;
        } else {
          Semester_average =
              (Semester_average + Subject_symbol[Mylist[i][1]]! * t);
              GPA -= Subject_symbol[Mylist[i][2]]! * t;
          timeNow += t;
        }
      }
    }
    GPA = (GPA + Semester_average) / time;
    Semester_average = Semester_average / timeNow;
    GPA_Rat=What_Rating(double.parse(GPA.toStringAsFixed(2)));
    Semester_average_Rat=What_Rating(double.parse( Semester_average.toStringAsFixed(2)));
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if(constraints.maxWidth<800){
        return Scaffold(
      key: keyscafolder,
        endDrawer: Drawer(child: MyDrawer(keyscafolder: keyscafolder),),
        appBar: AppBar(
          backgroundColor: Colors.blue[900],
          iconTheme:IconThemeData(size: 80.r,color: Colors.black) ,),
        body: SingleChildScrollView(
            child: Column(children: [
                ClipPath(
                clipper: TopWaveClipper(),
          child: Container(
            padding: EdgeInsets.only(bottom: 200.r),
            color: Colors.blue[900],
            height: 500.r,
            child:Center(child: Text("احسب معدلك",textAlign: TextAlign.center,style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,fontSize: 130.r),),
            )),
        ),
          Container(
              decoration: BoxDecoration(
                  color: HexColor("#38b6ff"),
                  border: Border.all(width: 2.5),
                  borderRadius: BorderRadius.circular(100.r)),
              margin: EdgeInsets.symmetric(horizontal: 45.r),
              padding: EdgeInsets.symmetric(vertical: 50.r),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 50.r),

                      height: 100.r,
                      child: TextField(
                        controller: controllertime,
                        decoration: InputDecoration(
                          label: Container(
                              alignment: const Alignment(1, 0),
                              child: Text("الساعات المقطوعة",style: TextStyle(fontSize: 40.r))),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 100.r, style: BorderStyle.solid),
                            borderRadius:
                                BorderRadius.all(Radius.circular(100.r)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 3.r, color: Colors.blue),
                            borderRadius:
                                BorderRadius.all(Radius.circular(100.r)),
                          ),
                        ),
                      ),
                    )),
                    Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 50.r),
                      width: 1000.r,
                      height: 100.r,
                      child: TextField(
                        controller: controlleravrage,
                        decoration: InputDecoration(
                          label: Container(
                              alignment: const Alignment(1, 0),
                              child:  Text("المعدل التراكمي",style: TextStyle(fontSize: 40.r),)),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 100.r, style: BorderStyle.solid),
                            borderRadius:
                                BorderRadius.all(Radius.circular(100.r)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 3.r, color: Colors.blue),
                            borderRadius:
                                BorderRadius.all(Radius.circular(100.r)),
                          ),
                        ),
                      ),
                    )),
                  ],
                ),

                ...List.generate(Mylist.length , (i) {
                  return MyDropdown(
                    list: Mylist[i ],
                    color: Colors.red,
                    icon: Icon(
                      Icons.clear,
                      color: Colors.white,
                      size: 80.r,
                    ),
                    onTap: () {
                      Mylist.removeAt(i );
                      setState(() {});
                    },
                  );
                }),
                InkWell(
                  onTap: (){
                    Mylist.add([" س.م", " رمز المادة", " الرمز السابق"]);
                    setState(() {});
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.green[400],
                        borderRadius: BorderRadius.circular(100.r)),
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 150.r,

                    ),
                  ),
                ),

              ])),
              SizedBox(height: 50.r,),
              MaterialButton(
                child: Text("احسب معدلك",style: TextStyle(color: Colors.white,fontSize: 50.r),),
                  color: Colors.blue,
                  onPressed: (){
                if(controllertime.text.trim().isNotEmpty&&controlleravrage.text.trim().isNotEmpty){
                time = int.parse( controllertime.text.trim());
               GPA=double.parse(controlleravrage.text.trim());
                }
                else{
                  time =0;
                  GPA=0.0;
                }
                Calculate_Average();
                setState(() {});
                print(GPA);
                print(Semester_average);

              }),
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [Container(
               padding: EdgeInsets.symmetric(vertical: 50.r),
               decoration: BoxDecoration(
                   color: HexColor("#38b6ff"),
                   border: Border.all(width: 2.5),
                   borderRadius: BorderRadius.circular(100.r)),
               width: 400.w,
               height: 550.h,
               margin: EdgeInsets.all(50.r),

             child: Column(children: [
               Text(": المعدل الفصلي",style: TextStyle(fontSize: 55.r,color: Colors.white),),
               Text(Semester_average.toStringAsFixed(2),style: TextStyle(fontSize: 80.r,color: Colors.white)),
               Text(": التقدير",style: TextStyle(fontSize: 55.r,color: Colors.white),),
               Text(Semester_average_Rat,style: TextStyle(fontSize: 80.r,color: Colors.white)),
             ],),),
             Container(
               padding: EdgeInsets.symmetric(vertical: 50.r),
               decoration: BoxDecoration(
                   color: HexColor("#38b6ff"),
                   border: Border.all(width: 2.5),
                   borderRadius: BorderRadius.circular(100.r)),
               width: 400.w,
               height: 550.h,
               margin: EdgeInsets.all(50.r),

               child: Column(children: [
                  Text(": المعدل التراكمي",style: TextStyle(fontSize: 55.r,color: Colors.white),),
                 Text((GPA).toStringAsFixed(2),style: TextStyle(fontSize: 80.r,color: Colors.white),),
                 Text(": التقدير",style: TextStyle(fontSize: 55.r,color: Colors.white),),
                 Text(GPA_Rat,style: TextStyle(fontSize: 80.r,color: Colors.white),),
               ],),)],),
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
        ])));}
    else{
        return Scaffold(
            key: keyscafolder,
            appBar: AppBar(
              backgroundColor: Colors.blue[900],
              iconTheme:IconThemeData(size: 80.r,color: Colors.black) ,
              title:Container(
                  alignment: const Alignment(1,0),child: const ListPage()),

            ),
            body: SingleChildScrollView(
                child: Column(children: [
                  ClipPath(
                    clipper: TopWaveClipper(),
                    child: Container(
                        padding: EdgeInsets.only(bottom: 200.r),
                        color: Colors.blue[900],
                        height: 500.r,
                        child:Center(child: Text("احسب معدلك",textAlign: TextAlign.center,style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,fontSize: 130.r),),
                        )),
                  ),
                  Container(
                      decoration: BoxDecoration(
                          color: HexColor("#38b6ff"),
                          border: Border.all(width: 2.5),
                          borderRadius: BorderRadius.circular(100.r)),
                      margin: EdgeInsets.symmetric(horizontal: 45.r),
                      padding: EdgeInsets.symmetric(vertical: 50.r),
                      child: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 50.r),

                                  height: 100.r,
                                  child: TextField(
                                    controller: controllertime,
                                    decoration: InputDecoration(
                                      label: Container(
                                          alignment: const Alignment(1, 0),
                                          child: Text("الساعات المقطوعة",style: TextStyle(fontSize: 40.r))),
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 100.r, style: BorderStyle.solid),
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(100.r)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                        BorderSide(width: 3.r, color: Colors.blue),
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(100.r)),
                                      ),
                                    ),
                                  ),
                                )),
                            Expanded(
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 50.r),
                                  width: 1000.r,
                                  height: 100.r,
                                  child: TextField(
                                    controller: controlleravrage,
                                    decoration: InputDecoration(
                                      label: Container(
                                          alignment: const Alignment(1, 0),
                                          child:  Text("المعدل التراكمي",style: TextStyle(fontSize: 40.r),)),
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 100.r, style: BorderStyle.solid),
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(100.r)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                        BorderSide(width: 3.r, color: Colors.blue),
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(100.r)),
                                      ),
                                    ),
                                  ),
                                )),
                          ],
                        ),

                        ...List.generate(Mylist.length , (i) {
                          return MyDropdown(
                            list: Mylist[i ],
                            color: Colors.red,
                            icon: Icon(
                              Icons.clear,
                              color: Colors.white,
                              size: 80.r,
                            ),
                            onTap: () {
                              Mylist.removeAt(i );
                              setState(() {});
                            },
                          );
                        }),
                        InkWell(
                          onTap: (){
                            Mylist.add([" س.م", " رمز المادة", " الرمز السابق"]);
                            setState(() {});
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.green[400],
                                borderRadius: BorderRadius.circular(100.r)),
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 150.r,

                            ),
                          ),
                        )
                      ])),
                  SizedBox(height: 50.r,),
                  MaterialButton(
                      child: Text("احسب معدلك",style: TextStyle(color: Colors.white,fontSize: 50.r),),
                      color: Colors.blue,
                      onPressed: (){
                        if(controllertime.text.trim().isNotEmpty&&controlleravrage.text.trim().isNotEmpty){
                          time = int.parse( controllertime.text.trim());
                          GPA=double.parse(controlleravrage.text.trim());
                        }
                        else{
                          time =0;
                          GPA=0.0;
                        }
                        Calculate_Average();
                        setState(() {});
                        print(GPA);
                        print(Semester_average);

                      }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Container(
                      padding: EdgeInsets.symmetric(vertical: 50.r),
                      decoration: BoxDecoration(
                          color: HexColor("#38b6ff"),
                          border: Border.all(width: 2.5),
                          borderRadius: BorderRadius.circular(100.r)),
                      width: 400.w,
                      height: 550.h,
                      margin: EdgeInsets.all(50.r),

                      child: Column(children: [
                        Text(": المعدل الفصلي",style: TextStyle(fontSize: 55.r,color: Colors.white),),
                        Text(Semester_average.toStringAsFixed(2),style: TextStyle(fontSize: 80.r,color: Colors.white)),
                        Text(": التقدير",style: TextStyle(fontSize: 55.r,color: Colors.white),),
                        Text(Semester_average_Rat,style: TextStyle(fontSize: 80.r,color: Colors.white)),
                      ],),),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 50.r),
                        decoration: BoxDecoration(
                            color: HexColor("#38b6ff"),
                            border: Border.all(width: 2.5),
                            borderRadius: BorderRadius.circular(100.r)),
                        width: 400.w,
                        height: 550.h,
                        margin: EdgeInsets.all(50.r),

                        child: Column(children: [
                          Text(": المعدل التراكمي",style: TextStyle(fontSize: 55.r,color: Colors.white),),
                          Text((GPA).toStringAsFixed(2),style: TextStyle(fontSize: 80.r,color: Colors.white),),
                          Text(": التقدير",style: TextStyle(fontSize: 55.r,color: Colors.white),),
                          Text(GPA_Rat,style: TextStyle(fontSize: 80.r,color: Colors.white),),
                        ],),)],),
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
                ])));
      }
    });
  }
}
