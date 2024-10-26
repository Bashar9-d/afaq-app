
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../MytextField.dart';
import '../database_page.dart';

class AddEmailDoctor extends StatefulWidget {
  const AddEmailDoctor({super.key});

  @override
  State<AddEmailDoctor> createState() => _AddEmailDoctorState();
}

class _AddEmailDoctorState extends State<AddEmailDoctor> {
  GlobalKey<FormState>formkey=GlobalKey();
  TextEditingController controllerName=TextEditingController();
  TextEditingController controllerEmail=TextEditingController();
  CollectionReference Doctors = FirebaseFirestore.instance.collection('Doctor');

  Future<void> addSubject() async{
    // Call the user's CollectionReference to add a nderw user
    return await Doctors
        .add({
      "Doctor_Name":controllerName.text,
      "Doctor_Email":controllerEmail.text
    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
  @override
  Widget build(BuildContext context) {
    return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Mytextfield(Hinttext: "Name Doctor", Mycontroller:controllerName ),
            SizedBox(height: 30.r,),
            Mytextfield(Hinttext: "Doctor Email", Mycontroller: controllerEmail)

            ,Container(
                margin: EdgeInsets.symmetric(vertical: 40.r),
                width: 1000.r,
                decoration: BoxDecoration(color: Colors.blue,borderRadius:BorderRadius.circular(100.r) ),
                child:MaterialButton(
                  onPressed:(){
                    addSubject();
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=> DatabasePage(selectedindex: 1,)), (route)=>false);
                  },child: Text("Create",style: TextStyle(fontSize: 50.r),), )
            )],
        );
  }
}
