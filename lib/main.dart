
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'Admin/home/database_page.dart';
import 'Users/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyDoQIGQHNzoumREjZ2FTfqzMDbDD2f42IU",
          authDomain: "afaq-firebase-a3d20.firebaseapp.com",
          projectId: "afaq-firebase-a3d20",
          storageBucket: "afaq-firebase-a3d20.appspot.com",
          messagingSenderId: "950468414813",
          appId: "1:950468414813:web:ca4190af6e16051fbf6cb4",
          measurementId: "G-HW0F4GJSX9"));}
  else{await Firebase.initializeApp();}

    runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return ScreenUtilInit(
        designSize:  const Size(1080, 2400),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowMaterialGrid: false,
            debugShowCheckedModeBanner: false,
            home: FirebaseAuth.instance.currentUser!=null? DatabasePage(selectedindex: 0) :const HomePage(),
          );
        },
      );
    });
  }
}
