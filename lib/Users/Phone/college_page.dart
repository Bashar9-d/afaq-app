
import 'package:animate_on_hover/animate_on_hover.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../home_page.dart';
import 'list_page.dart';
import 'my_drawer.dart';

class CollegePage extends StatefulWidget {
  const CollegePage({super.key});

  @override
  State<CollegePage> createState() => _CollegePageState();
}

class _CollegePageState extends State<CollegePage> {
  GlobalKey<ScaffoldState> keyscafolder = GlobalKey();
  List<String> imgList = [
    "images/college/photo_5825796432202942126_y.jpg",
    "images/college/photo_5825796432202942127_y.jpg",
    "images/college/photo_5825796432202942132_y.jpg",
    "images/college/photo_5825796432202942134_y.jpg",
    "images/college/photo_5825796432202942135_y.jpg",
    "images/college/photo_5825796432202942137_y.jpg",
    "images/college/photo_5825796432202942140_y.jpg",
    "images/college/photo_5825796432202942145_y.jpg",
    "images/college/photo_5825796432202942147_y.jpg",
    "images/college/photo_5825796432202942148_y.jpg",
    "images/college/photo_5825796432202942150_y.jpg",
    "images/college/photo_5825796432202942151_y.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if(constraints.maxWidth<800){
    return Scaffold(
      key: keyscafolder,
      appBar: AppBar(
        iconTheme: IconThemeData(size: 80.r, color: Colors.black),
        backgroundColor: Colors.blue[900],
      ),
      endDrawer: Drawer(
        child: MyDrawer(keyscafolder: keyscafolder),
      ),
      body: SingleChildScrollView(
          child: Column(children: [
        ClipPath(
            clipper: TopWaveClipper(),
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 50.r),
                color: Colors.blue[900],
                height: 900.r,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 100.r,
                      ),
                      Text(
                        "ITكلية الـ",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontSize: 100.r,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Text(
                        "تأسست كلية تكنولوجيا المعلومات في جامعة آل البيت عام 2001 ، ويأتي إنشاء الكلية من رؤية ملكية سامية من جلالة الملك عبد الله الثاني ابن الحسين لتصبح الأردن نموذج إقليمًا لتكنولوجيا المعلومات ، بحيث تضم أكثر من 25 مختبرا",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 55.r, color: Colors.white),
                      )
                    ],
                  ),
                ))),
        Text(
          "خريطة الكلية",
          style: TextStyle(
            fontSize: 100.r,
            fontWeight: FontWeight.bold,
          ),
        ),
        Wrap(
          children: [
            _Show_Image(
                "images/college/college_map/photo_5823287505582147389_y.jpg",
                "خريطة توضع الكلية المبنى الرئيسي واماكن القاعات وايضا اماكان تواجد مكتب العميد ومساعد العميد و وبعض الدكاترة",
            "https://drive.google.com/file/d/1SFc69YeE_P2n_tkasP_QIzCgVNSUlDZM/view?usp=sharing"),
            _Show_Image(
                "images/college/college_map/photo_5823287505582147390_y.jpg",
                "خريطه توضح امكان المختبرات في قسم نظم المعلومات وقسم علم الحاسوب وايضا اماكن تواجد مكاتب الدكاتره",
            "https://drive.google.com/file/d/15QEMcgkLTBPJWTUMN87L2jtJZD1pkh20/view?usp=sharing"),
            _Show_Image(
                "images/college/college_map/photo_5823287505582147391_y.jpg",
                "خريطه توضع اماكن تواجد بعض الدكاتره في مبنى ابو حنيفة النعمان ( كلية التمريض القديمة )",
            "https://drive.google.com/file/d/1QfEHWwLID2VHIui2enSu6takIbkcZTdS/view?usp=sharing")
          ],
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 100.r, horizontal: 20.r),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.r),
              border: Border.all(color: Colors.lightBlue, width: 15)),
          child: ImageSlideshow(
            width: 2000.r,
            height: 1000.r,
            initialPage: 0,
            indicatorColor: Colors.blue,
            indicatorBackgroundColor: Colors.grey,

            /// Called whenever the page in the center of the viewport changes.
            onPageChanged: (value) {
              print('Page changed: $value');
            },
            autoPlayInterval: 3000,
            isLoop: true,
            children: [
              ...List.generate(imgList.length, (Index) {
                return Image.asset(
                  imgList[Index],
                  fit: BoxFit.cover,
                );
              })
            ],
          ),
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
      ])),
    );}
    else{ return Scaffold(
        key: keyscafolder,
        appBar: AppBar(
          iconTheme: IconThemeData(size: 80.r, color: Colors.black),
          backgroundColor: Colors.blue[900],
          title:Container(
              alignment: const Alignment(1,0),child: const ListPage()),
        ),


        body: SingleChildScrollView(
            child: Column(children: [
              ClipPath(
                  clipper: TopWaveClipper(),
                  child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 50.r),
                      color: Colors.blue[900],
                      height: 900.r,
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 100.r,
                            ),
                            Text(
                              "ITكلية الـ",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontSize: 100.r,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text(
                              "تأسست كلية تكنولوجيا المعلومات في جامعة آل البيت عام 2001 ، ويأتي إنشاء الكلية من رؤية ملكية سامية من جلالة الملك عبد الله الثاني ابن الحسين لتصبح الأردن نموذج إقليمًا لتكنولوجيا المعلومات ، بحيث تضم أكثر من 25 مختبرا",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 55.r, color: Colors.white),
                            )
                          ],
                        ),
                      ))),
              Text(
                "خريطة الكلية",
                style: TextStyle(
                  fontSize: 100.r,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Wrap(
                children: [
                  _Show_Image(
                      "images/college/college_map/photo_5823287505582147389_y.jpg",
                      "خريطة توضع الكلية المبنى الرئيسي واماكن القاعات وايضا اماكان تواجد مكتب العميد ومساعد العميد و وبعض الدكاترة",
                      "https://drive.google.com/file/d/1SFc69YeE_P2n_tkasP_QIzCgVNSUlDZM/view?usp=sharing"),
                  _Show_Image(
                      "images/college/college_map/photo_5823287505582147390_y.jpg",
                      "خريطه توضح امكان المختبرات في قسم نظم المعلومات وقسم علم الحاسوب وايضا اماكن تواجد مكاتب الدكاتره",
                      "https://drive.google.com/file/d/15QEMcgkLTBPJWTUMN87L2jtJZD1pkh20/view?usp=sharing"),
                  _Show_Image(
                      "images/college/college_map/photo_5823287505582147391_y.jpg",
                      "خريطه توضع اماكن تواجد بعض الدكاتره في مبنى ابو حنيفة النعمان ( كلية التمريض القديمة )",
                      "https://drive.google.com/file/d/1QfEHWwLID2VHIui2enSu6takIbkcZTdS/view?usp=sharing")
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 100.r, horizontal: 20.r),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.r),
                    border: Border.all(color: Colors.lightBlue, width: 15)),
                child: ImageSlideshow(
                  width: 2000.r,
                  height: 1000.r,
                  initialPage: 0,
                  indicatorColor: Colors.blue,
                  indicatorBackgroundColor: Colors.grey,

                  /// Called whenever the page in the center of the viewport changes.
                  onPageChanged: (value) {
                    print('Page changed: $value');
                  },
                  autoPlayInterval: 3000,
                  isLoop: true,
                  children: [
                    ...List.generate(imgList.length, (Index) {
                      return Image.asset(
                        imgList[Index],
                        fit: BoxFit.cover,
                      );
                    })
                  ],
                ),
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
            ])),
      );}
    });
  }

  _Show_Image(String path, String text,String UrlFile) {
    return Container(
            margin: EdgeInsets.symmetric(horizontal: 50.r, vertical: 50.r),
            width: 1000.r,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                    onTap: (){launchUrl(Uri.parse(UrlFile));},
                    child: Image.asset(
                  path,
                  height: 600.r,
                  width: 1000.r,
                )),
                Text(
                  text,
                  style: TextStyle(fontSize: 70.r),
                  textAlign: TextAlign.center,
                )
              ],
            ))
        .increaseSizeOnHover(1.1, duration: const Duration(milliseconds: 400));
  }
}
