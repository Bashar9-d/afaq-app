import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Mytextfield extends StatefulWidget {
  final String Hinttext;
  final TextEditingController Mycontroller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  const Mytextfield({
    super.key,
    required this.Hinttext,
    required this.Mycontroller, this.validator, this.onChanged,
  });

  // استخدام ValueNotifier لمراقبة التغيير وإعلام جميع الحقول


  @override
  State<Mytextfield> createState() => _MytextfieldState();
}

class _MytextfieldState extends State<Mytextfield> {
  static bool isShow=true;
  @override
  Widget build(BuildContext context) {
    return  widget.Hinttext.toUpperCase().contains("PASSWORD")
            ? TextFormField(

      validator: widget.validator,
          obscureText: isShow,
          controller: widget.Mycontroller,
          onChanged: widget.onChanged,
          decoration: InputDecoration(
            label: Text("Enter your ${widget.Hinttext}"),
            labelStyle: const TextStyle(color: Colors.grey),
            hintStyle: const TextStyle(color: Colors.grey),
            filled: true,
            fillColor: Colors.grey[300],
              suffixIcon:MaterialButton(
                height: 3,
                child: SizedBox(width: 50.r,child: isShow? Image.asset("images/eye_slash.png"):Image.asset("images/remove_red_eye.png")) ,
                onPressed: (){
                  isShow=!isShow;
                  setState(() {});},),
            border: const OutlineInputBorder(borderSide: BorderSide(width: 0, style: BorderStyle.none),
              borderRadius: BorderRadius.all(Radius.circular(100)),),
              focusedBorder:OutlineInputBorder(
              borderSide: BorderSide(width: 3.r, color: Colors.blue),
              borderRadius:  BorderRadius.all(Radius.circular(100.r)),
            ),
          ),
        )
            : TextFormField(
      validator: widget.validator,
          controller: widget.Mycontroller,
          decoration: InputDecoration(
            label: Text("Enter Your ${widget.Hinttext}"),
            labelStyle: const TextStyle(color: Colors.grey),
            hintStyle: const TextStyle(color: Colors.grey),
            filled: true,
            fillColor: Colors.grey[300],
            border: const OutlineInputBorder(
              borderSide: BorderSide(width: 0, style: BorderStyle.none),
              borderRadius: BorderRadius.all(Radius.circular(100)),
            ),

            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 3.r, color: Colors.blue),
              borderRadius:  BorderRadius.all(Radius.circular(100.r)),
            ),
          ),
        );
  }
}
