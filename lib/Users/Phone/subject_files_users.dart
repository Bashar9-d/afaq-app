import 'package:afaq/Users/Phone/my_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../home_page.dart';
import 'list_page.dart';

class SubjectFilesUsers extends StatefulWidget {
  const SubjectFilesUsers(
      {super.key,
        required this.Sup_Data,
        required this.Titile,
        required this.Url_Image});

  final List<List<QueryDocumentSnapshot>> Sup_Data;

  final String Titile;
  final String Url_Image;

  @override
  State<SubjectFilesUsers> createState() => _SubjectFilesUsersState();
}

class _SubjectFilesUsersState extends State<SubjectFilesUsers>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  GlobalKey<ScaffoldState> keyscafolder=GlobalKey();
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this, initialIndex: 3);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> Body = [
      // محتويات تاب ملخصات
  Column(children: [...List.generate(widget.Sup_Data[3].length, (i){   return InkWell(
    onTap: () {
      launchUrl(Uri.parse(widget.Sup_Data[3][i]["Url_File"]));
    },
    child: Container(
        margin: EdgeInsets.symmetric(horizontal: 30.r, vertical: 10.r),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black, width: 1)),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "${widget.Sup_Data[3][i]["Name_File"]}  ",
                style: TextStyle(fontSize: 70.r),
              ),
              const Icon(Icons.book)
            ])),
  );})],) ,
      // محتويات تاب امتحانات محوسبة
      Column(children: [...List.generate( widget.Sup_Data[2].length,(i) {
            return InkWell(
              onTap: () {
                launchUrl(Uri.parse(widget.Sup_Data[2][i]["Url_File"]));
              },
              child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 30.r, vertical: 10.r),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black, width: 1)),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "${widget.Sup_Data[2][i]["Name_File"]}  ",
                          style: TextStyle(fontSize: 70.r),
                        ),
                        const Icon(Icons.laptop_windows)
                      ])),
            );
          }),]),
      // محتويات تاب السلايدات
    Column(children: [...List.generate(widget.Sup_Data[1].length,(i) {
            return InkWell(
              onTap: () {
                launchUrl(Uri.parse(widget.Sup_Data[1][i]["Url_File"]));
              },
              child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 30.r, vertical: 10.r),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black, width: 1)),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "${widget.Sup_Data[1][i]["Name_File"]}  ",
                          style: TextStyle(fontSize: 70.r),
                        ),
                        const Icon(Icons.book)
                      ])),
            );
          }),]),
      // محتويات تاب تست بانك
      Column(
        children: [
          Container(
              margin: EdgeInsets.symmetric(vertical: 20.r, horizontal: 30.r),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black, width: 1)),
              child: ExpansionTile(
                title: const Text(
                  "تست بانك ميد",
                  textAlign: TextAlign.end,
                ),
                children: widget.Sup_Data[0]
                    .where((item) => item["Mid_or_Final"] == 0)
                    .map((item) {
                  return ListTile(
                    title: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("${item["Name_File"]}  "),
                          const Icon(Icons.picture_as_pdf)
                        ]),
                    onTap: () {
                      launchUrl(Uri.parse(item["Url_File"]));
                    },
                  );
                }).toList(),
              )),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 30.r),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black, width: 1)),
              child: ExpansionTile(
                title: const Text(
                  "تست بانك فاينل",
                  textAlign: TextAlign.end,
                ),
                children: widget.Sup_Data[0]
                    .where((item) => item["Mid_or_Final"] == 1)
                    .map((item) {
                  return ListTile(
                    title: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("${item["Name_File"]}  "),
                          const Icon(Icons.picture_as_pdf)
                        ]),
                    onTap: () {
                      launchUrl(Uri.parse(item["Url_File"]));
                    },
                  );
                }).toList(),
              )),
        ],
      ),
    ];

    return
      LayoutBuilder(builder: (context, constraints) {
      if(constraints.maxWidth<800){
      return DefaultTabController(
      length: 4,
      child: Scaffold(
        key: keyscafolder,
        endDrawer: Drawer(child: MyDrawer(keyscafolder: keyscafolder),),
        appBar: AppBar(
          backgroundColor: Colors.blue[900],
          iconTheme: IconThemeData(size: 80.r, color: Colors.black),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ClipPath(
                clipper: TopWaveClipper(),
                child: Container(
                  color: Colors.blue[900],
                  height: 900.r,
                  child: Center(
                    child: Image.network(widget.Url_Image,
                        height: 800.r, width: 1500.r, fit: BoxFit.fill),
                  ),
                ),
              ),
              TabBar(
                isScrollable: true,
                controller: tabController,
                tabs: [
                  Tab(child: Text("ملخصات", style: TextStyle(fontSize: 50.r))),
                  Tab(
                      child: Text("امتحانات محوسبة",
                          style: TextStyle(fontSize: 50.r))),
                  Tab(child: Text("السلايدات", style: TextStyle(fontSize: 50.r))),
                  Tab(child: Text("تست بانك", style: TextStyle(fontSize: 50.r))),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.7, // Adjust height as needed
                child: TabBarView(
                  controller: tabController,
                  children: Body,
                ),
              ),
            ],
          ),
        ),
      ),
    );}
      else{return DefaultTabController(
        length: 4,
        child: Scaffold(
          key: keyscafolder,

          appBar: AppBar(
            backgroundColor: Colors.blue[900],
            iconTheme: IconThemeData(size: 80.r, color: Colors.black),
            title:Container(
                alignment: const Alignment(1,0),child: const ListPage()),

          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                ClipPath(
                  clipper: TopWaveClipper(),
                  child: Container(
                    color: Colors.blue[900],
                    height: 900.r,
                    child: Center(
                      child: Image.network(widget.Url_Image,
                          height: 800.r, width: 1500.r, fit: BoxFit.fill),
                    ),
                  ),
                ),
                TabBar(
                  isScrollable: true,
                  controller: tabController,
                  tabs: [
                    Tab(child: Text("ملخصات", style: TextStyle(fontSize: 50.r))),
                    Tab(
                        child: Text("امتحانات محوسبة",
                            style: TextStyle(fontSize: 50.r))),
                    Tab(child: Text("السلايدات", style: TextStyle(fontSize: 50.r))),
                    Tab(child: Text("تست بانك", style: TextStyle(fontSize: 50.r))),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7, // Adjust height as needed
                  child: TabBarView(
                    controller: tabController,
                    children: Body,
                  ),
                ),

              ],
            ),
          ),
        ),
      );}


  });}

}
