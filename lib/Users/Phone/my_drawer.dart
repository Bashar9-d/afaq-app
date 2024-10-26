import 'package:afaq/Admin/sign_in_page.dart';
import 'package:afaq/Users/Phone/subject_page.dart';
import 'package:afaq/Users/Phone/who_we_are.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../home_page.dart';
import 'calculate_the_average.dart';
import 'college_page.dart';
import 'doctor_email_page.dart';
import 'major_page.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key, required this.keyscafolder});

  final GlobalKey<ScaffoldState> keyscafolder;

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30.r, vertical: 100.r),
            alignment: Alignment.topLeft,
            child: InkWell(
              onTap: () {
                widget.keyscafolder.currentState!.closeEndDrawer();
              },
              child: const Icon(Icons.close),
            ),
          ),
          _buildDrawerItem("الصفحة الرئيسية", const HomePage()),
          _buildDrawerItem("مكتبة المواد", const SubjectPage()),
          _buildDrawerItem("تخصصات الكلية", const MajorPage()),
          _buildDrawerItem("ايميلات الدكاترة", const DoctorEmailPage()),
          _buildDrawerItem("حساب المعدل", const CalculateTheAverage()),
          _buildDrawerItem("كلية تكنولوجيا المعلومات", const CollegePage()),
          _buildDrawerItem("من نحن؟", const WhoWeAre()),
          SizedBox(height: 800.r),
          _buildDrawerItem("تسجيل الدخول", const SignInPage()),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(String title, Widget page) {
    return InkWell(
      onTap: () {
        if(page.toString()== const HomePage().toString()) {
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => page),(rote)=>false);
        }else{Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));}
      },
      child: Container(
        alignment: Alignment.topRight,
        margin: EdgeInsets.symmetric(horizontal: 30.r, vertical: 10.r),
        child: Text(
          title,
          style: TextStyle(fontSize: 70.r, color: Colors.blue[900]),
        ),
      ),
    );
  }
}
