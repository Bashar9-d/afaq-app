import 'package:afaq/Users/Phone/calculate_the_average.dart';
import 'package:afaq/Users/Phone/college_page.dart';
import 'package:afaq/Users/Phone/doctor_email_page.dart';
import 'package:afaq/Users/Phone/major_page.dart';
import 'package:afaq/Users/Phone/subject_page.dart';
import 'package:afaq/Users/Phone/who_we_are.dart';
import 'package:afaq/Users/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List<bool> colors = [false, false, false, false, false, false, false];

  List listname = [
  ["الصفحة الرئيسية",const HomePage()],
   [ "مكتبة المواد",const SubjectPage()],
   [ "تخصصات الكلية",const MajorPage()],
   [ "ايميلات الدكاترة",const DoctorEmailPage()],
   [ "حساب المعدل",const CalculateTheAverage()],
    ["كلية تكنولوجيا المعلومات",const CollegePage()],
    ["من نحن؟",const WhoWeAre()]
  ];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      textDirection: TextDirection.rtl,
      crossAxisAlignment: WrapCrossAlignment.end,
      children: List.generate(listname.length, (index) {
        return Padding(padding:EdgeInsets.symmetric(horizontal: 50.r), child:_page(listname[index][0], index,listname[index][1]));
      }),
    );
  }

  Widget _page(String name, int i,Widget page) {
    return InkWell(
      onTap: () {
        if(page.toString()== const HomePage().toString()) {
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => page),(rote)=>false);
        }else{Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));}
      },
      onHover: (isHovered) {
        setState(() {
          colors[i] = isHovered;
        });
      },
      child: Text(
        name,
        style: TextStyle(
          color: colors[i] ? Colors.blue : Colors.white,
          fontSize: 70.r,
        ),
      ),
    );
  }
}
