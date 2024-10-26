
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class MyDropdown extends StatefulWidget {
  MyDropdown({super.key, required this.list,this.onTap,  required this.icon, required this.color,});
  void Function()? onTap;
  List list;
 final Icon icon;
 final Color color;
  @override
  State<MyDropdown> createState() => _MyDropdownState();
}

String? selectedValue;

class _MyDropdownState extends State<MyDropdown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 50.h,horizontal:70.w ),
      width: 1000.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
        Container(
        height: 90.h,
        decoration: BoxDecoration(color:Colors.white,borderRadius: BorderRadius.circular(50.sp),border: Border.all(width:2)),
        child:  DropdownButton<String>(
          dropdownColor: Colors.white,
          underline: Container(),
            alignment: const Alignment(1,0),
            value: widget.list[0], // القيمة المختارة حاليا
            items: <String>[" س.م", '1', '2', '3','4','5','6']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),

              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                widget.list[0] = newValue; // تحديث القيمة المختارة
              });
            },
          )),
          Container(
            height: 90.h,
            decoration: BoxDecoration(color:Colors.white,borderRadius: BorderRadius.circular(50.sp),border: Border.all(width:2)),
            child:  DropdownButton<String>(
              underline:Container(),
              alignment: const Alignment(1,0),
            value: widget.list[1], // القيمة المختارة حاليا
            items: <String>[" رمز المادة", "A+","A","A-","B+","B","B-","C+","C","C-","D+","D","F"]
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(

                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                widget.list[1] = newValue; // تحديث القيمة المختارة
              });
            },
          ),),
          Container(
              height: 90.h,
              decoration: BoxDecoration(color:Colors.white,borderRadius: BorderRadius.circular(50.sp),border: Border.all(width:2)),
              child:  DropdownButton<String>(
                underline: Container(),
                alignment: const Alignment(1,0),
            value: widget.list[2], // القيمة المختارة حاليا
            hint: const Text("اختر خيارًا"),
            items: <String>[" الرمز السابق","A+","A","A-","B+","B","B-","C+","C","C-","D+","D","F"]
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                widget.list[2] = newValue; // تحديث القيمة المختارة
              });
            },
          )),
         InkWell(
              onTap: widget.onTap,
              child: Container(
                 decoration: BoxDecoration(color: widget.color,borderRadius:BorderRadius.circular(100.sp) ),
                  child: widget.icon))
        ],
      ),
    );
  }
}
