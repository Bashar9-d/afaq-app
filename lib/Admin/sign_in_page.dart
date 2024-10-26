import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'MytextField.dart';
import 'home/database_page.dart';


class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController Email = TextEditingController();
  TextEditingController Password = TextEditingController();
  GlobalKey<FormState> KeyEmail = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
        body: ListView(children: [
          Container(
            width: 1000.r,
            height: 700.r,
            margin:  EdgeInsets.only(top:80.r),
            child: Image.asset(
              "images/afaq-Logo.png",
            ),
          ),
          Form(
              key: formstate,
              child: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 40.w,  // تناسب مع العرض
                    vertical: 40.h,    // تناسب مع الارتفاع
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Login",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 110.sp)),
                        Text(
                          "Login to continue using the app",
                          style: TextStyle(fontSize: 40.sp, color: Colors.grey),
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(height: 60.h),
                        Text("Email",
                            style: TextStyle(
                                fontSize: 80.sp, fontWeight: FontWeight.bold)),
                        Mytextfield(
                          key:  KeyEmail,
                            Hinttext: "Email",
                            Mycontroller: Email,
                            validator: (val) {
                              if (val == "") {
                                return "الرجاء ادخال البريد الالكتروني";
                              }
                              return null;
                            }),
                        SizedBox(height: 60.h),
                        Text("Password",
                            style: TextStyle(
                                fontSize: 80.sp, fontWeight: FontWeight.bold)),
                        Mytextfield(
                            Hinttext: "Password",
                            Mycontroller: Password,
                            validator: (val) {
                              if (val == "") {
                                return "الرجاء لدخال كلمة السر";
                              }
                              return null;

                            }),

                      ]))),
          Container(
              margin:  EdgeInsets.symmetric(horizontal: 40.h),
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(100.w)),
              child: MaterialButton(
                onPressed: () async {
                  if(formstate.currentState!.validate()) {
                    try {
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: Email.text.trim(),
                        password: Password.text.trim()
                    );
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>DatabasePage(selectedindex: 0)));
                  } on   FirebaseException catch (e) {
                    if (e.code == 'user-not-found') {
                      AwesomeDialog(
                        context: (context),
                        dialogType: DialogType.info,
                        desc: 'هذا البريد الالكتروني ليس لديه حساب ',
                        btnOkOnPress:(){},
                      ).show();

                    } else if (e.code == 'wrong-password') {
                      AwesomeDialog(
                        context: (context),
                        dialogType: DialogType.error,
                        desc: 'كلمه المرور التي ادخلتها خاطئة',
                        btnOkOnPress:(){},
                      ).show();

                    }else if(e.code=='too-many-requests'){
                      AwesomeDialog(
                        context: (context),
                        dialogType: DialogType.error,
                        desc: 'لفد استهلكت جميع محاولاتك الرجاء اعاده تعيين كلمه السر او المحاوله في وفت لاحق',
                        btnOkOnPress:(){},
                      ).show();

                    }
                  }
                  }

                },
                child:  Text(
                  "Login",
                  style: TextStyle(fontSize: 80.sp),
                ),
              )),
          SizedBox(
            height: 80.h,
          ),
            ]));
  }
}
