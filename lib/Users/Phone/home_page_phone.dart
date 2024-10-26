
import 'package:afaq/Users/Phone/doctor_email_page.dart';
import 'package:afaq/Users/Phone/subject_page.dart';
import 'package:afaq/Users/Phone/who_we_are.dart';
import 'package:animate_on_hover/animate_on_hover.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';
import '../home_page.dart';
import 'calculate_the_average.dart';
import 'college_page.dart';
import 'major_page.dart';
class HomePagePhone extends StatefulWidget {
  const HomePagePhone({super.key, required this.keyscafolder});
  final GlobalKey<ScaffoldState> keyscafolder;
  @override
  State<HomePagePhone> createState() => _HomePagePhoneState();
}
class _HomePagePhoneState extends State<HomePagePhone> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipPath(
          clipper: TopWaveClipper(),
          child: Container(
              color: Colors.blue[900],
              height: 1200.r,
              child: Center(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          margin: EdgeInsets.only(top: 120.r),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.only(left: 30.r),
                                width: 500.r,
                                height: 150.r,
                                child: Image.asset(
                                  "images/afaq-Logo[1].png",
                                  fit: BoxFit.fill,
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    widget.keyscafolder.currentState!.openEndDrawer();},
                                  icon: Icon(
                                    Icons.dehaze,
                                    color: Colors.black,
                                    size: 100.r,
                                  ))
                            ],
                          )),
                      WidgetAnimator(
                          incomingEffect:
                          WidgetTransitionEffects.incomingSlideInFromRight(
                            duration: const Duration(seconds: 2),
                          ),
                          child: Container(
                              margin: EdgeInsets.only(top: 180.r),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      " علينا ",
                                      style: TextStyle(
                                        color: HexColor("#25D6DD"),
                                        fontSize: 100.r,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'علامتك الكاملة ',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 100.r,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ]))),
                      WidgetAnimator(
                          incomingEffect:
                          WidgetTransitionEffects.incomingSlideInFromLeft(
                            duration: const Duration(seconds: 2),
                          ),
                          child: Text(
                            'ادرس أي مادة في كلية الأمير الحسين بن عبدالله\nلتكنولوجيا المعلومات من خلال موقع آفاق التكنولوجيا ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 50.r,
                            ),
                            textAlign: TextAlign.center,
                          )),
                      Container(
                          margin: EdgeInsets.only(bottom: 100.r, top: 50.r),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(right: 50.r),
                                  height: 100.r,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: HexColor("#25D6DD"),
                                          width: 3)),
                                  child: MaterialButton(
                                    onPressed: () {Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>const WhoWeAre()));},
                                    child: Text(
                                      "اقرأ المزيد",
                                      style: TextStyle(
                                          color: HexColor("#004AAD"),
                                          fontSize: 40.r),
                                    ),
                                  )),
                              Container(
                                  margin: EdgeInsets.only(left: 50.r),
                                  height: 100.r,
                                  color: HexColor("#25D6DD"),
                                  child: MaterialButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                              const SubjectPage()));
                                    },
                                    color: HexColor("#25D6DD"),
                                    child: Text("ابدأ الدراسة",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 40.r)),
                                  ))
                            ],
                          ))
                    ]),
              )),
        ),
        Text(
          "خدماتنا",
          style: TextStyle(fontSize: 100.r, fontWeight: FontWeight.w900),
        ),
        SizedBox(
          height: 100.r,
        ),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.center,
          children: [

            _Sections("images/book.PNG", "مكتبة المواد",
                "تحتوي مكتبة المواد على جميع احتياجات الطالب لكل مادة من ملخصات ودفاتر وتست بانك و امتحانات محوسبة تحاكي الامتحانات الواقعية",() {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>const SubjectPage()));
              },),
            _Sections("images/major.png", "التخصصات",
                "شرح كامل ومعلومات عن كل تخصص بالكلية وايضا تقديم الخطة الشجرية لجميع التخصصات",()
              {Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const MajorPage())); },),
            _Sections("images/Calculate_the_average.png", "احسب معدلك",
                "يمكنك حساب معدلك الفصلي والتراكمي بشكل دقيق ومعرفة التقدير الخاص بك",() {

                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const CalculateTheAverage()));
              },),
            _Sections("images/Email.png", "إيميلات الدكاترة",
                "نوفر جميع إيميلات الدكاترة في كلية الأمير الحسين بن عبد الله لتكنولوجيا المعلومات لتتمكن من التواصل معهم",() {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>const DoctorEmailPage()));
              },),
            _Sections("images/college.png", "ITكلية الـ",
                "تعريف عن الكلية لتتعرف عليها وايضاً صور للكلية وخريطة تشمل الكلية من الداخل والخارج واماكن المختبرات",() {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>const CollegePage()));
              },)

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
    );
  }
  Widget _Sections(String img, String name, String description,void Function()? Function) {
    return Container(
        margin: EdgeInsets.all(50.r),
        padding: EdgeInsets.symmetric(vertical: 50.r),
        width: 950.r,
        height: 950.r,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black, width: 2)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              img,
              width: 230.r,
              height: 230.r,
            ),
            Text(
              name,
              style: TextStyle(
                  fontSize: 90.r, fontWeight: FontWeight.w600),
            ),
            Text(
              description,
              style: TextStyle(
                  fontSize: 50.r, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            InkWell(
              onTap:Function ,
              child: Container(
                margin: EdgeInsets.only(top: 35.r),
                height: 110.r,
                width: 800.r,
                color: HexColor("#25D6DD"),
                child: Text(
                  name,
                  style:
                  TextStyle(fontSize: 60.r, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        )).increaseSizeOnHover(1.1,duration:  const Duration(milliseconds:400));
  }
}
