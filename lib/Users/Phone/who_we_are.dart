
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../home_page.dart';
import 'list_page.dart';
import 'my_drawer.dart';

class WhoWeAre extends StatefulWidget {
  const WhoWeAre({super.key});

  @override
  State<WhoWeAre> createState() => _WhoWeAreState();
}

class _WhoWeAreState extends State<WhoWeAre> {
  List<String> imgList = [
    "images/afaq_event/photo_5796200955027507363_y.jpg",
    "images/afaq_event/photo_5796200955027507366_y.jpg",
    "images/afaq_event/photo_5796200955027507368_y.jpg",
    "images/afaq_event/photo_5796200955027507372_y.jpg",
    "images/afaq_event/photo_5796200955027507393_y.jpg",
    "images/afaq_event/photo_5870462163641024962_y.jpg",
    "images/afaq_event/photo_5803315718677184857_y.jpg",
    "images/afaq_event/photo_5812398775644307803_y.jpg",
    "images/afaq_event/photo_5812398775644307805_y.jpg",
    "images/afaq_event/photo_5812398775644307806_y.jpg",
    "images/afaq_event/photo_5839078910623597153_y.jpg",
    "images/afaq_event/photo_5839078910623597162_y.jpg",
    "images/afaq_event/photo_5904325073077125561_y.jpg",
    "images/afaq_event/photo_5904325073077125573_y.jpg",
    "images/afaq_event/photo_5904385507561948189_y.jpg",
    "images/afaq_event/photo_5913734139536852350_y.jpg",
    "images/afaq_event/photo_5915842405838473835_y.jpg",
    "images/afaq_event/photo_5971819285837890575_y.jpg",
  ];
  GlobalKey<ScaffoldState> keyscafolder = GlobalKey();
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return  LayoutBuilder(builder: (context, constraints) {
      if(constraints.maxWidth<800){ return Scaffold(
          key: keyscafolder,
          endDrawer: Drawer(child: MyDrawer(keyscafolder: keyscafolder)),
          appBar: AppBar(
            iconTheme: IconThemeData(size: 100.r, color: Colors.black),
            backgroundColor: Colors.blue[900],
          ),
          body: SingleChildScrollView(
              child:
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                ClipPath(
                    clipper: TopWaveClipper(),
                    child: Container(
                      alignment: Alignment.center,
                      color: Colors.blue[900],
                      height: 700.r,
                      child: Image.asset(
                        "images/afaq-Logo[1].png",
                        width: 800.r,
                        alignment: Alignment.topCenter,
                        height: 400.r,
                      ),
                    )),
                Container(
                    margin: EdgeInsets.all(50.r),
                    child: Column(
                      children: [
                        Text(
                          "من نحن؟",
                          style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 130.r),
                        ),
                        SizedBox(
                          height: 50.r,
                        ),
                        Text(
                          "AFAQ TEAM - فریق آفاق التكنولوجيا",
                          style: TextStyle(
                              color: Colors.blue[900],
                              fontSize: 60.r,
                              fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 50.r,
                        ),
                        Text(
                          "فريق طلابي من كلية الامير الحسين بن عبدالله تكنولوجيا المعلومات تأسس على أيدي طلبة الكلية عام 2023 يتبع لكتلة النشامى في جامعة آل البيت",
                          style:
                          TextStyle(fontSize: 70.r, fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 150.r,
                        ),
                        Text("رؤيتنا",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 130.r)),
                        Text(
                          "تقديم المساعدة للطلبة، وتنمية روح المبادرة لديهم وبناء جيل واعي، يملك مسؤولية اتجاه وطنه وأمته",
                          style:
                          TextStyle(fontSize: 70.r, fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 150.r,
                        ),
                        Text(
                          "أهدافنا",
                          style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 130.r),
                        ),
                        GoalsScreen()
                      ],
                    )),
                SizedBox(
                  height: 150.r,
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
                      alignment: Alignment.center,
                      color: Colors.blue[900],
                      height: 900.r,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 100.r,
                          ),
                          Text(
                            "منشئين التطبيق",
                            style: TextStyle(color: Colors.white, fontSize: 100.r),
                          ),
                          SizedBox(
                            height: 50.r,
                          ),
                          Text(
                            "قام بتطويره و برمجته : بشار الشقور",
                            style: TextStyle(color: Colors.white, fontSize: 70.r),
                          ),
                          SizedBox(
                            height: 50.r,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 100.r,
                              ),
                              InkWell(
                                  onTap: () {
                                    launchUrl(Uri.parse(
                                        "https://www.instagram.com/bshrztshqwr/"));
                                  },
                                  child: Image.asset(
                                    "images/Instagram.png",
                                    width: 100.r,
                                    height: 100.r,
                                  )),
                              SizedBox(
                                width: 100.r,
                              ),
                              InkWell(
                                  onTap: () {
                                    launchUrl(Uri.parse(
                                        "https://www.linkedin.com/in/bashar-shaqour-320b922a7/?lipi=urn%3Ali%3Apage%3Ad_flagship3_profile_verification_details%3B%2FQt%2BCqYdS%2BaBT1PwZlFADQ%3D%3D"));
                                  },
                                  child: Image.asset(
                                    "images/linkein_logo.png",
                                    width: 100.r,
                                    height: 100.r,
                                  )),
                              SizedBox(
                                width: 100.r,
                              ),
                              InkWell(
                                  onTap: () {
                                    launchUrl(Uri.parse(
                                        "https://www.facebook.com/profile.php?id=100067921209651"));
                                  },
                                  child: Image.asset(
                                    "images/facebook.png",
                                    width: 100.r,
                                    height: 100.r,
                                  )),
                              SizedBox(
                                width: 100.r,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 50.r,
                          ),
                          Text(
                            "قام بتصميم الديزاين : وليد زياد",
                            style: TextStyle(color: Colors.white, fontSize: 70.r),
                          ),
                        ],
                      ),
                    )),
              ])));}
      else{return Scaffold(
          key: keyscafolder,

          appBar: AppBar(
            iconTheme: IconThemeData(size: 100.r, color: Colors.black),
            backgroundColor: Colors.blue[900],  title:Container(
              alignment: const Alignment(1,0),child: const ListPage()),

          ),
          body: SingleChildScrollView(
              child:
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                ClipPath(
                    clipper: TopWaveClipper(),
                    child: Container(
                      alignment: Alignment.center,
                      color: Colors.blue[900],
                      height: 700.r,
                      child: Image.asset(
                        "images/afaq-Logo[1].png",
                        width: 800.r,
                        alignment: Alignment.topCenter,
                        height: 400.r,
                      ),
                    )),
                Container(
                    margin: EdgeInsets.all(50.r),
                    child: Column(
                      children: [
                        Text(
                          "من نحن؟",
                          style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 130.r),
                        ),
                        SizedBox(
                          height: 50.r,
                        ),
                        Text(
                          "AFAQ TEAM - فریق آفاق التكنولوجيا",
                          style: TextStyle(
                              color: Colors.blue[900],
                              fontSize: 60.r,
                              fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 50.r,
                        ),
                        Text(
                          "فريق طلابي من كلية الامير الحسين بن عبدالله تكنولوجيا المعلومات تأسس على أيدي طلبة الكلية عام 2023 يتبع لكتلة النشامى في جامعة آل البيت",
                          style:
                          TextStyle(fontSize: 70.r, fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 150.r,
                        ),
                        Text("رؤيتنا",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 130.r)),
                        Text(
                          "تقديم المساعدة للطلبة، وتنمية روح المبادرة لديهم وبناء جيل واعي، يملك مسؤولية اتجاه وطنه وأمته",
                          style:
                          TextStyle(fontSize: 70.r, fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 150.r,
                        ),
                        Text(
                          "أهدافنا",
                          style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 130.r),
                        ),
                        GoalsScreen()
                      ],
                    )),
                SizedBox(
                  height: 150.r,
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
                      alignment: Alignment.center,
                      color: Colors.blue[900],
                      height: 900.r,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 100.r,
                          ),
                          Text(
                            "منشئين التطبيق",
                            style: TextStyle(color: Colors.white, fontSize: 100.r),
                          ),
                          SizedBox(
                            height: 50.r,
                          ),
                          Text(
                            "قام بتطويره و برمجته : بشار الشقور",
                            style: TextStyle(color: Colors.white, fontSize: 70.r),
                          ),
                          SizedBox(
                            height: 50.r,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 100.r,
                              ),
                              InkWell(
                                  onTap: () {
                                    launchUrl(Uri.parse(
                                        "https://www.instagram.com/bshrztshqwr/"));
                                  },
                                  child: Image.asset(
                                    "images/Instagram.png",
                                    width: 100.r,
                                    height: 100.r,
                                  )),
                              SizedBox(
                                width: 100.r,
                              ),
                              InkWell(
                                  onTap: () {
                                    launchUrl(Uri.parse(
                                        "https://www.linkedin.com/in/bashar-shaqour-320b922a7/?lipi=urn%3Ali%3Apage%3Ad_flagship3_profile_verification_details%3B%2FQt%2BCqYdS%2BaBT1PwZlFADQ%3D%3D"));
                                  },
                                  child: Image.asset(
                                    "images/linkein_logo.png",
                                    width: 100.r,
                                    height: 100.r,
                                  )),
                              SizedBox(
                                width: 100.r,
                              ),
                              InkWell(
                                  onTap: () {
                                    launchUrl(Uri.parse(
                                        "https://www.facebook.com/profile.php?id=100067921209651"));
                                  },
                                  child: Image.asset(
                                    "images/facebook.png",
                                    width: 100.r,
                                    height: 100.r,
                                  )),
                              SizedBox(
                                width: 100.r,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 50.r,
                          ),
                          Text(
                            "قام بتصميم الديزاين : وليد زياد",
                            style: TextStyle(color: Colors.white, fontSize: 70.r),
                          ),
                        ],
                      ),
                    )),
              ])));}
    });
  }
}

class GoalsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 100.r),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GoalItem(
              number: '01',
              description:
                  'شرح وتبسيط المواد للطلبة وزيادة الفائدة عن طريق الشروحات المصورة والمكتوبة'),
          GoalItem(
              number: '02',
              description:
                  'توفير الإفادة النوعية بكافة المجالات التكنولوجية ونشر قيم ديننا الحنيف بين الطلبة عن طريق الأنشطة المختلفة'),
          GoalItem(
              number: '03',
              description:
                  'تقديم الفائدة للمتطوعين بالفريق وتنمية مهاراتهم بشتى المجالات'),
        ],
      ),
    );
  }
}

class GoalItem extends StatelessWidget {
  final String number;

  final String description;

  const GoalItem({
    required this.number,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
            child: Container(
          margin: EdgeInsets.all(50.r),
          child: Text(
            description,
            style: TextStyle(fontSize: 60.r),
            textAlign: TextAlign.end,
          ),
        )),
        Column(
          children: [
            Text(
              number,
              style: TextStyle(fontSize: 90.r, color: Colors.blue),
            ),
            CustomPaint(
              size: Size(9.r, 250.r), // طول الخط
              painter: DashedLinePainter(),
            ),
          ],
        ),
      ],
    );
  }
}

class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 3;

    var max = size.height;
    var dashWidth = 5;
    var dashSpace = 3;
    double startY = 0;
    while (startY < max) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY + dashWidth), paint);
      startY += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
