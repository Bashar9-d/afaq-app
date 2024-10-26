
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../home_page.dart';
import 'list_page.dart';
import 'my_drawer.dart';

class InformationMajor extends StatefulWidget {
  const InformationMajor(
      {super.key,
      required this.Url_image,
      required this.information,
      required this.Major_name, required this.Major_id});

  final String Url_image;
  final String information;
  final String Major_name;
final String Major_id;
  @override
  State<InformationMajor> createState() => _InformationMajorState();
}

class _InformationMajorState extends State<InformationMajor> {
  GlobalKey<ScaffoldState> keyscafolder = GlobalKey();
  List<QueryDocumentSnapshot> Data = [];
  bool isloading = true;
  getdata() async {
    isloading = true;
    QuerySnapshot querySnapshot;
    querySnapshot = await FirebaseFirestore.instance
        .collection("Major")
        .doc(widget.Major_id)
        .collection("Major_Files")
        .get();
    Data.addAll(querySnapshot.docs);
    isloading = false;
    setState(() {});
  }
  @override
  void initState() {
   getdata();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if(constraints.maxWidth<800){
    return Scaffold(
      key: keyscafolder,
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        iconTheme: IconThemeData(size: 80.r, color: Colors.black),
      ),
      endDrawer: Drawer(
        child: MyDrawer(keyscafolder: keyscafolder),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipPath(
              clipper: TopWaveClipper(),
              child: Container(
                padding: EdgeInsets.only(bottom: 250.r),
                color: Colors.blue[900],
                child: Center(
                    child: Column(
                  children: [
                    Image.network(
                      widget.Url_image,
                        height: 800.r, width: 1500.r, fit: BoxFit.fill
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 50.r,top: 100.r),
                        child: Text(
                      widget.Major_name,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 100.r),
                      textAlign: TextAlign.left,
                    )),
                    Container(
                        margin: EdgeInsets.symmetric(horizontal:  50.r),
                        child: Text(
                          widget.information,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 60.r),
                          textAlign: TextAlign.center,
                        ))
                  ],
                )),
              ),
            ),
            SizedBox(height: 100.r,),
         isloading? SizedBox(height: 1000.r,) : Wrap (
           crossAxisAlignment: WrapCrossAlignment.center,
           alignment: WrapAlignment.center,
           children: [
              ...List.generate(Data.length, (i){return
               Container(
                   margin: EdgeInsets.symmetric(horizontal: 50.r),
                   width: 1500.r,
                   child:
                Column(children: [
                Text(Data[i]["Name_File"],style: TextStyle(fontSize: 100.r,color: Colors.blue[900],fontWeight: FontWeight.bold),),
                SizedBox(height: 50.r,),
                       InkWell(
                         onTap: (){launchUrl(Uri.parse(Data[i]["Url_File"]));},
                         child:Image.network(Data[i]["Url_Image"]),)
              ],))
                ;})
            ],),
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
    );}
    else{return  Scaffold(
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
                  child: Center(
                      child: Column(
                        children: [
                          Image.network(
                              widget.Url_image,
                              height: 800.r, width: 1500.r, fit: BoxFit.fill
                          ),
                          Container(
                              margin: EdgeInsets.only(right: 50.r,top: 100.r),
                              child: Text(
                                widget.Major_name,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 100.r),
                                textAlign: TextAlign.left,
                              )),
                          Container(
                              margin: EdgeInsets.symmetric(horizontal:  50.r),
                              child: Text(
                                widget.information,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 60.r),
                                textAlign: TextAlign.center,
                              ))
                        ],
                      )),
                ),
              ),
              SizedBox(height: 50.r,),
              isloading? SizedBox(height: 1000.r,) : Wrap (
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.center,
                children: [
                ...List.generate(Data.length, (i){return
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 50.r),
                      width: 1500.r,
                      child:
                      Column(children: [
                        Text(Data[i]["Name_File"],style: TextStyle(fontSize: 100.r,color: Colors.blue[900],fontWeight: FontWeight.bold),),
                        SizedBox(height: 50.r,),
                        InkWell(
                          onTap: (){launchUrl(Uri.parse(Data[i]["Url_File"]));},
                          child:Image.network(Data[i]["Url_Image"]),)
                      ],))
                ;})
              ],),
              SizedBox(height: 50.r,),
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
      );}
    });
  }
}
