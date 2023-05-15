import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:get/get.dart';
import 'package:login_project/Screens/AddBookScreen/Model/BookDataModel.dart';
import 'package:login_project/Screens/AddBookScreen/View/AddBookPage.dart';
import 'package:login_project/Screens/BookViewScreen/View/BookViewPage.dart';
import 'package:login_project/Screens/HomeScreen/Controller/HomeController.dart';
import 'package:login_project/Utils/FirebaseHelper/FirebaseHelper.dart';
import 'package:login_project/Utils/ToastMessage.dart';
import 'package:sizer/sizer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    print("==== INIT =====");
    FirebaseHelper.firebaseHelper.UserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text("Browse",style: TextStyle(color: Colors.white,fontSize: 26.sp),),
          centerTitle: true,
          backgroundColor: Colors.deepOrangeAccent.shade100,
          leading: Padding(
            padding: EdgeInsets.only(left: Get.width/60),
            child: IconButton(
              onPressed: () async {
                await FirebaseHelper.firebaseHelper.SignOutUser();
                Get.offNamed('SignIn');
              },
              icon: Icon(Icons.logout,color: Colors.white,),
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: Get.width/60),
              child: IconButton(
                onPressed: () async {
                  Get.back();
                  Get.defaultDialog(
                   title: "Choose Any One",
                   content: Row(
                     mainAxisSize: MainAxisSize.min,
                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                     children: [
                       TextButton(onPressed: (){
                         homeController.Check.value = 0;
                         Get.back();
                         if(homeController.CategoryList.isNotEmpty) {
                           Get.to(
                               AddBookPage(), transition: Transition.downToUp,
                               duration: Duration(milliseconds: 500));
                         }
                         else
                           {
                             ToastMessage(msg: "Please Add Your Book Category",color: Colors.red);
                           }
                       }, child: const Text("Add Book")),
                       SizedBox(width: Get.width/15,),
                       TextButton(onPressed: (){
                         Get.back();
                         Get.defaultDialog(
                          title: "Add Book Category",
                          content: Form(
                            key: homeController.AddCategorykey,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: Get.width/30),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  TextFormField(
                                    controller: homeController.txtBookCategoryName,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.menu_book,size: 21.sp,),
                                      prefixIconColor: Colors.grey,
                                      hintText: "Book Category name",
                                      hintStyle: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 15.sp
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(6),
                                          borderSide: BorderSide(color: Colors.grey,width: 2)
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(6),
                                          borderSide: BorderSide(color: Colors.grey,width: 2)
                                      ),
                                    ),
                                    validator: (value) {
                                      if(value!.isEmpty)
                                      {
                                        return "Please Add Book Category Name";
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: Get.height/30,),
                                  InkWell(
                                    onTap: (){
                                      if(homeController.AddCategorykey.currentState!.validate())
                                        {
                                          FirebaseHelper.firebaseHelper.InsertCategoryData(homeController.txtBookCategoryName.text);
                                          Get.back();
                                          ToastMessage(msg: "Your Category Is Insert Successful",color: Colors.green);
                                          homeController.AddCategorykey.currentState!.reset();
                                        }
                                      else
                                        {
                                          ToastMessage(msg: "Please Add Your Data",color: Colors.deepOrangeAccent.shade100);
                                          Get.back();
                                        }
                                    },
                                    child: Container(
                                      height: Get.height/15,
                                      width: Get.width/1.3,
                                      decoration: BoxDecoration(
                                          color: Colors.deepOrangeAccent.shade100,
                                          borderRadius: BorderRadius.circular(15)
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Add Book Category",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.sp
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        );
                       }, child: const Text("Add Category")),
                     ],
                   )
                 );
                },
                icon: Icon(Icons.add,color: Colors.white,),
              ),
            )
          ],
        ),
        /*
        Center(
          child: Text("Add Your Books",style: TextStyle(color: Colors.black,fontSize: 21.sp),)
        )

        ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Container(
              height: Get.height/3,
              width: Get.width,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      height: Get.height/3.3,
                      width: Get.width/1.3,
                      margin: EdgeInsets.only(right: Get.width/21),
                      padding: EdgeInsets.only(left: Get.width/4.1),
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: Get.height/14,
                            width: Get.width,
                            // color: Colors.red,
                            alignment: Alignment.bottomLeft,
                            child: Text("Long Range", maxLines: 1,style: TextStyle(color: Colors.black,fontSize: 23.sp,fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis),),
                          ),
                          Container(
                            height: Get.height/18,
                            width: Get.width,
                            // color: Colors.yellowAccent,
                            alignment: Alignment.centerLeft,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("⭐ ⭐ ⭐ ⭐ ⭐", maxLines: 1,style: TextStyle(fontSize: 12.sp),),Text("", maxLines: 1,style: TextStyle(color: Colors.black,fontSize: 23.sp,fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis),),
                                SizedBox(width: Get.width/30,),
                                Text("5.0", maxLines: 1,style: TextStyle(color: Colors.grey,fontSize: 12.sp,),),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(bottom: Get.width/30,right: Get.width/30),
                              width: Get.width,
                              // color: Colors.blue,
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Long Range — Author C.J. Box. Wyoming game warden Joe Pickett must investigate an attempted murder--a crime committed from a confoundingly long distance--in the riveting new novel from #1 New York Times bestselling author C. J. Box.",
                                maxLines: 7,
                                style: TextStyle(color: Colors.grey,fontSize: 12.sp,overflow: TextOverflow.ellipsis),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      height: Get.height/4.1,
                      width: Get.width/2.9,
                      margin: EdgeInsets.only(left: Get.width/21),
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
                        height: Get.height/4.5,
                        width: Get.width/3.3,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                        ),
                        alignment: Alignment.center,
                        child: ClipRRect(borderRadius: BorderRadius.circular(12),child: Image.network("https://m.media-amazon.com/images/I/51YnP1b6BjL.jpg",fit: BoxFit.fill,)),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        )
         */
        body: Column(
          children: [
            Container(
              height: Get.height/15,
              width: Get.width,
              // color: Colors.red,
              padding: EdgeInsets.symmetric(vertical: Get.width/60),
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseHelper.firebaseHelper.ReadCategoryData(),
                builder: (context, snapshot) {
                  if(snapshot.hasError)
                  {
                    return Center(child: Text("${snapshot.error}"),);
                  }
                  else if(snapshot.hasData)
                  {
                    homeController.CategoryList.clear();
                    var docs = snapshot.data!.docs;
                    for(var doc in docs)
                    {
                      Map name = doc.data() as Map;
                      // print("======= ${name['category_name']}");
                      homeController.CategoryList.add({'name' : name['category_name'], 'selected' : name['selected'], 'id' : doc.id,});
                    }

                    print("==== C Length ${homeController.CategoryList.length} ==== B Length ${homeController.BookDataList.length}");
                    // homeController.BooksList.clear();
                    // for(int i=0; i<homeController.CategoryList.length; i++)
                    // {
                    //   print("====== SELECTED ==== ${homeController.CategoryList[i]['selected']}");
                    //   if(homeController.CategoryList[i]['selected'] == true)
                    //   {
                    //     print("YES========== ${homeController.BookDataList.length}");
                    //     for(int j=0; j<homeController.BookDataList.length; j++)
                    //     {
                    //       print("=========== BOOK ==== ${homeController.BookDataList[j].category} ========= CAT ${homeController.CategoryList[i]['name']}");
                    //       if(homeController.BookDataList[j].category == homeController.CategoryList[i]['name'])
                    //       {
                    //         homeController.BooksList.add(homeController.BookDataList[j]);
                    //       }
                    //     }
                    //   }
                    // }
                    return Obx(
                          () => homeController.CategoryList.isNotEmpty
                              ? ListView.builder(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: homeController.CategoryList.length,
                        itemBuilder: (context, index) {
                          return FocusedMenuHolder(
                            onPressed: (){},
                            menuItems: [
                              FocusedMenuItem(
                                title: Text("Delete"),
                                onPressed: (){
                                  for(int i=0; i<homeController.CategoryList.length; i++)
                                  {
                                    print("======= $i $index");
                                    if(i == index)
                                    {
                                      for(int j=0; j<homeController.BookDataList.length; j++)
                                      {
                                        print("============ ${homeController.BookDataList[j].category} ${homeController.CategoryList[i]['name']}");
                                        if(homeController.BookDataList[j].category == homeController.CategoryList[i]['name'])
                                        {
                                          print("===== $index $j DELETE ${homeController.BookDataList[j].id} ${homeController.CategoryList[index]['id']}");
                                          FirebaseHelper.firebaseHelper.DeleteBookData(id: homeController.BookDataList[j].id!);
                                          // homeController.BooksList.add(homeController.BookDataList[j]);
                                        }
                                      }
                                      // print("============== ${homeController.BooksList[0].name}");
                                    }
                                  }
                                  FirebaseHelper.firebaseHelper.DeleteCategoryData(id: homeController.CategoryList[index]['id']);
                                  ToastMessage(msg: "Your Category Is Delete",color: Colors.green);
                                },
                                trailingIcon: Icon(Icons.delete_outline),
                              ),
                              FocusedMenuItem(
                                title: Text("Update"),
                                onPressed: (){
                                  homeController.txtUpdateBookCategoryName = TextEditingController(text: "${homeController.CategoryList[index]['name']}");
                                  Get.back();
                                  Get.defaultDialog(
                                      title: "Update Book Category",
                                      content: Form(
                                        key: homeController.AddCategorykey,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(horizontal: Get.width/30),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              TextFormField(
                                                controller: homeController.txtUpdateBookCategoryName,
                                                textInputAction: TextInputAction.next,
                                                decoration: InputDecoration(
                                                  prefixIcon: Icon(Icons.menu_book,size: 21.sp,),
                                                  prefixIconColor: Colors.grey,
                                                  hintText: "Update Book Category name",
                                                  hintStyle: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15.sp
                                                  ),
                                                  border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(6),
                                                      borderSide: BorderSide(color: Colors.grey,width: 2)
                                                  ),
                                                  focusedBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(6),
                                                      borderSide: BorderSide(color: Colors.grey,width: 2)
                                                  ),
                                                ),
                                                validator: (value) {
                                                  if(value!.isEmpty)
                                                  {
                                                    return "Please Add Book Category Name";
                                                  }
                                                  return null;
                                                },
                                              ),
                                              SizedBox(height: Get.height/30,),
                                              InkWell(
                                                onTap: (){
                                                  if(homeController.AddCategorykey.currentState!.validate())
                                                  {
                                                    FirebaseHelper.firebaseHelper.UpdateCategoryData(id: homeController.CategoryList[index]['id'], Selected: homeController.CategoryList[index]['selected'], CategoryName: homeController.txtUpdateBookCategoryName.text);
                                                    Get.back();
                                                    ToastMessage(msg: "Your Data Is Update",color: Colors.green);
                                                    homeController.AddCategorykey.currentState!.reset();
                                                  }
                                                  else
                                                  {
                                                    ToastMessage(msg: "Please Add Your Data",color: Colors.deepOrangeAccent.shade100);
                                                    Get.back();
                                                  }
                                                },
                                                child: Container(
                                                  height: Get.height/15,
                                                  width: Get.width/1.5,
                                                  decoration: BoxDecoration(
                                                      color: Colors.deepOrangeAccent.shade100,
                                                      borderRadius: BorderRadius.circular(15)
                                                  ),
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    "Update Book Category",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 17.sp
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                  );
                                },
                                trailingIcon: Icon(Icons.edit_outlined),
                              ),
                            ],
                            child: InkWell(
                              onTap: () {

                                for(int i=0; i<homeController.CategoryList.length; i++)
                                  {
                                    print("======= $i $index");
                                    if(i == index)
                                      {
                                        FirebaseHelper.firebaseHelper.UpdateCategoryData(CategoryName : homeController.CategoryList[i]['name'], Selected : true, id : homeController.CategoryList[i]['id']);
                                        homeController.BooksList.clear();
                                        for(int j=0; j<homeController.BookDataList.length; j++)
                                        {
                                          if(homeController.BookDataList[j].category == homeController.CategoryList[i]['name'])
                                          {
                                            homeController.BooksList.add(homeController.BookDataList[j]);
                                          }
                                        }
                                        // print("============== ${homeController.BooksList[0].name}");
                                      }
                                    else
                                      {
                                        FirebaseHelper.firebaseHelper.UpdateCategoryData(CategoryName : homeController.CategoryList[i]['name'], Selected : false, id : homeController.CategoryList[i]['id']);
                                      }
                                  }

                              },
                              child: Container(
                                height: Get.height/3,
                                width: Get.width/3,
                                margin: EdgeInsets.symmetric(horizontal: Get.width/90),
                                decoration: BoxDecoration(
                                  color: homeController.CategoryList[index]['selected'] == true ? Colors.deepOrangeAccent.shade100 : Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "${homeController.CategoryList[index]['name']}",
                                  maxLines: 1,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15.sp,
                                    fontWeight: homeController.CategoryList[index]['selected'] == true ? FontWeight.bold :FontWeight.normal,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      )
                              : Center(child: Text("Category Not Available\nPlease Add Category",style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.bold),),),
                    );
                  }
                  return  ListView.builder(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: homeController.CategoryList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        height: Get.height/3,
                        width: Get.width/3,
                        margin: EdgeInsets.symmetric(horizontal: Get.width/90),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(30),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseHelper.firebaseHelper.ReadBookData(),
              builder: (context, snapshot) {
                if(snapshot.hasError)
                {
                  return Center(child: Text("${snapshot.error}",style: TextStyle(color: Colors.black,fontSize: 15.sp),),);
                }
                else if(snapshot.hasData)
                {
                  // List<BookDataModel> dataList = [];
                  homeController.BookDataList.clear();
                  homeController.BooksList.clear();
                  var x = snapshot.data;
                  var data = x!.docs;
                  int count =0;
                  for(var a in data)
                  {
                    Map map = a.data() as Map;
                    BookDataModel bookDataModel = BookDataModel(
                        name: map['name'],
                        image: map['image'],
                        author_name: map['author_name'],
                        author_about: map['author_about'],
                        book_about: map['book_about'],
                        rating: map['rating'],
                        publish_year: map['publish_year'],
                        category: map['category'],
                        id: a.id
                    );
                    // homeController.BooksList.add(bookDataModel);
                    homeController.BookDataList.add(bookDataModel);
                  }
                  for(int i=0; i<homeController.CategoryList.length; i++)
                  {
                    if(homeController.CategoryList[i]['selected'] == true) {
                      // homeController.BooksList.clear();
                      count=1;
                      for(int j=0; j<homeController.BookDataList.length; j++) {
                        if(homeController.BookDataList[j].category == homeController.CategoryList[i]['name']) {
                          homeController.BooksList.add(homeController.BookDataList[j]);
                        }
                      }
                    }
                  }
                  // if(count==0)
                  //   {
                  //     homeController.BooksList= homeController.BookDataList;
                  //   }
                  print("========= ${homeController.BooksList.length}");
                  // print("=========Length ${homeController.BooksList.length}");
                  return Obx(
                      () => homeController.CategoryList.isNotEmpty ? homeController.BooksList.isNotEmpty
                          ? Expanded(
                            child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: homeController.BooksList.length,
                      itemBuilder: (context, index) {
                        return FocusedMenuHolder(
                            animateMenuItems: true,
                            menuWidth: 150,
                            menuItems: [
                              FocusedMenuItem(
                                title: Text("Delete"),
                                onPressed: (){
                                  FirebaseHelper.firebaseHelper.DeleteBookData(id: homeController.BooksList[index].id!);
                                  ToastMessage(msg: "Your Book Is Delete",color: Colors.green);
                                },
                                trailingIcon: Icon(Icons.delete_outline),
                              ),
                              FocusedMenuItem(
                                title: Text("Update"),
                                onPressed: (){
                                  homeController.Check.value = 1;
                                  homeController.Id.value = homeController.BooksList[index].id!;
                                  homeController.txtUpdateBookName = TextEditingController(text: "${homeController.BooksList[index].name}");
                                  homeController.txtUpdateBookImgLink.value = TextEditingController(text: "${homeController.BooksList[index].image}");
                                  homeController.txtUpdateAuthorName = TextEditingController(text: "${homeController.BooksList[index].author_name}");
                                  homeController.txtUpdateAboutAuthor = TextEditingController(text: "${homeController.BooksList[index].author_about}");
                                  homeController.txtUpdateAboutBook = TextEditingController(text: "${homeController.BooksList[index].book_about}");
                                  homeController.txtUpdateBookPublishYear = TextEditingController(text: "${homeController.BooksList[index].publish_year}");
                                  homeController.txtUpdateBookRating = TextEditingController(text: "${homeController.BooksList[index].rating}");
                                  homeController.DropDownValue.value = homeController.BooksList[index].category!;
                                  Get.to(AddBookPage(),transition: Transition.downToUp,duration: Duration(milliseconds: 500));
                                  ToastMessage(msg: "Your Data Is Update",color: Colors.green);
                                },
                                trailingIcon: Icon(Icons.edit_outlined),
                              ),
                            ],
                            child: InkWell(
                              onTap: (){
                                homeController.bookDataModel.value = homeController.BooksList[index];
                                Get.to(BookViewPage(),transition: Transition.downToUp,duration: Duration(milliseconds: 500));
                              },
                              child: Container(
                                height: Get.height/3,
                                width: Get.width,
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Container(
                                        height: Get.height/3.3,
                                        width: Get.width/1.3,
                                        margin: EdgeInsets.only(right: Get.width/21),
                                        padding: EdgeInsets.only(left: Get.width/4.1),
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
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: Get.height/14,
                                              width: Get.width,
                                              // color: Colors.red,
                                              alignment: Alignment.bottomLeft,
                                              child: Text("${homeController.BooksList[index].name}", maxLines: 1,style: TextStyle(color: Colors.black,fontSize: 23.sp,fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis),),
                                            ),
                                            Container(
                                              height: Get.height/18,
                                              width: Get.width,
                                              // color: Colors.yellowAccent,
                                              alignment: Alignment.centerLeft,
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    "${double.parse(homeController.BooksList[index].rating!) <= 1.0 ? "⭐" : double.parse(homeController.BooksList[index].rating!) <= 2.0 ? "⭐ ⭐" : double.parse(homeController.BooksList[index].rating!) <= 3.0 ? "⭐ ⭐ ⭐" : double.parse(homeController.BooksList[index].rating!) <= 4.0 ? "⭐ ⭐ ⭐ ⭐" : double.parse(homeController.BooksList[index].rating!) <= 5.0 ? "⭐ ⭐ ⭐ ⭐ ⭐" : ""}",
                                                    maxLines: 1,
                                                    style: TextStyle(fontSize: 12.sp),),
                                                  SizedBox(width: Get.width/30,),
                                                  Text("${homeController.BooksList[index].rating}", maxLines: 1,style: TextStyle(color: Colors.grey,fontSize: 12.sp,),),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                margin: EdgeInsets.only(bottom: Get.width/30,right: Get.width/30),
                                                width: Get.width,
                                                // color: Colors.blue,
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  "${homeController.BooksList[index].book_about}",
                                                  maxLines: 7,
                                                  style: TextStyle(color: Colors.grey,fontSize: 12.sp,overflow: TextOverflow.ellipsis),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        height: Get.height/4.1,
                                        width: Get.width/2.9,
                                        margin: EdgeInsets.only(left: Get.width/21),
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
                                          height: Get.height/4.5,
                                          width: Get.width/3.3,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          alignment: Alignment.center,
                                          child: ClipRRect(borderRadius: BorderRadius.circular(12),child: Image.file(File("${homeController.BooksList[index].image}"),fit: BoxFit.fill,)),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            onPressed: (){},
                        );
                      },
                    ),
                          )
                          : Expanded(child: Center(child: Text("This Category Data Not Available",style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.bold),),)) : const Text(""),
                  );
                }
                return Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return  Container(
                        height: Get.height/3,
                        width: Get.width,
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                height: Get.height/3.3,
                                width: Get.width/1.3,
                                margin: EdgeInsets.only(right: Get.width/21),
                                padding: EdgeInsets.only(left: Get.width/4.1),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                height: Get.height/4.1,
                                width: Get.width/2.9,
                                margin: EdgeInsets.only(left: Get.width/21),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
