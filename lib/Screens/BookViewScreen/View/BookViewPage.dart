import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_project/Screens/HomeScreen/Controller/HomeController.dart';
import 'package:sizer/sizer.dart';

class BookViewPage extends StatefulWidget {
  const BookViewPage({Key? key}) : super(key: key);

  @override
  State<BookViewPage> createState() => _BookViewPageState();
}

class _BookViewPageState extends State<BookViewPage> {

  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            onPressed: (){
              Get.back();
            },
            icon: Icon(Icons.arrow_back_ios_new),
          ),
          title: Text("Browse",style: TextStyle(color: Colors.white,fontSize: 26.sp),),
          backgroundColor: Colors.deepOrangeAccent.shade100,
          centerTitle: false,
        ),
        body: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: Get.height/1.5,
                width: Get.width/1.21,
                margin: EdgeInsets.only(top: Get.width/2.3,),
                padding: EdgeInsets.symmetric(horizontal: Get.width/15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0,0),
                          blurRadius: 15
                      )
                    ]
                ),
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: Get.height/18,
                        width: Get.width/1.4,
                        color: Colors.white,
                        margin: EdgeInsets.only(top: Get.width/2.3),
                        alignment: Alignment.center,
                        child: Text(
                          "${homeController.bookDataModel.value.name}",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.sp,
                            overflow: TextOverflow.ellipsis
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: Get.height/21,
                        width: Get.width/1.5,
                        color: Colors.white,
                        //margin: EdgeInsets.only(top: Get.width/2.3),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${double.parse(homeController.bookDataModel.value.rating!) <= 1.0 ? "⭐" : double.parse(homeController.bookDataModel.value.rating!) <= 2.0 ? "⭐ ⭐" : double.parse(homeController.bookDataModel.value.rating!) <= 3.0 ? "⭐ ⭐ ⭐" : double.parse(homeController.bookDataModel.value.rating!) <= 4.0 ? "⭐ ⭐ ⭐ ⭐" : double.parse(homeController.bookDataModel.value.rating!) <= 5.0 ? "⭐ ⭐ ⭐ ⭐ ⭐" : ""}",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 13.sp,
                                overflow: TextOverflow.ellipsis
                              ),
                            ),
                            SizedBox(width: Get.width/15,),
                            Text(
                              "${homeController.bookDataModel.value.rating}",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13.sp,
                                overflow: TextOverflow.ellipsis
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(top: Get.width/21),
                        child: Text(
                          "Author Name  :  ${homeController.bookDataModel.value.author_name}",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 9.sp,
                              overflow: TextOverflow.ellipsis
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(top: Get.width/60),
                        child: Text(
                          "Publish Year  :  ${homeController.bookDataModel.value.publish_year}",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 9.sp,
                              overflow: TextOverflow.ellipsis
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(top: Get.width/15),
                        child: Text(
                          "${homeController.bookDataModel.value.author_about} ",
                          maxLines: 10,
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 13.sp,
                              overflow: TextOverflow.ellipsis
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: Get.height/3.6,
                width: Get.width/2.5,
                margin: EdgeInsets.only(top: Get.width/6,),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0,0),
                          blurRadius: 15
                      )
                    ]
                ),
                alignment: Alignment.center,
                child: Container(
                  height: Get.height/4,
                  width: Get.width/2.9,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: ClipRRect(borderRadius: BorderRadius.circular(12),child: Image.file(File("${homeController.bookDataModel.value.image}"),fit: BoxFit.fill,)),
                ),
              ),
            )
          ],
        ),
        // body: ,
      ),
    );
  }
}
