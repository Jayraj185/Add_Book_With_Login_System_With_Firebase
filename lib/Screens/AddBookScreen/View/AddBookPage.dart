import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_project/Screens/AddBookScreen/Model/BookDataModel.dart';
import 'package:login_project/Screens/HomeScreen/Controller/HomeController.dart';
import 'package:login_project/Utils/FirebaseHelper/FirebaseHelper.dart';
import 'package:login_project/Utils/ToastMessage.dart';
import 'package:sizer/sizer.dart';

class AddBookPage extends StatefulWidget {
  const AddBookPage({Key? key}) : super(key: key);

  @override
  State<AddBookPage> createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {

  HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    homeController.Check.value == 0 ? homeController.CategoryList.isNotEmpty ? homeController.DropDownValue.value = homeController.CategoryList[0]['name'] : "" : "";

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        key: homeController.AddBookkey,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text("${homeController.Check.value == 0 ? "Add" : "Update"} Book",style: TextStyle(color: Colors.white,fontSize: 26.sp),),
            backgroundColor: Colors.deepOrangeAccent.shade100,
            centerTitle: true,
          ),
          body: Padding(
            padding: EdgeInsets.only(left: Get.width/21,top: Get.width/15,right: Get.width/21,),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  TextFormField(
                    controller: homeController.Check.value == 0 ? homeController.txtBookName : homeController.txtUpdateBookName,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.menu_book,size: 21.sp,),
                      prefixIconColor: Colors.grey,
                      hintText: homeController.Check.value == 0 ? "Book Name" : "Update Book Name",
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
                          return "Please Add Book Name";
                        }
                      return null;
                    },
                  ),
                  SizedBox(height: Get.width/18,),
                  Container(
                    height: Get.height/12,
                    width: Get.width,
                    // color: Colors.red,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: Obx(
                              () => TextFormField(
                              controller: homeController.Check.value == 0 ? homeController.txtBookImgLink.value : homeController.txtUpdateBookImgLink.value,
                                keyboardType: TextInputType.none,
                                showCursor: false,
                                readOnly: true,
                                decoration: InputDecoration(
                                prefixIcon: Icon(Icons.image_rounded,size: 21.sp,),
                                prefixIconColor: Colors.grey,
                                hintText: homeController.Check.value == 0 ? "Image Link Click Button" : "Update Image Link Click Button",
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
                                  return "Please Add Image Link";
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return bottomSheet();
                                },
                            );
                          },
                          child: Container(
                            height: Get.width/8,
                            width: Get.width/8,
                            alignment: Alignment.centerRight,
                            child: Icon(Icons.image_outlined,size: 25.sp,),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: Get.width/18,),
                  TextFormField(
                    controller: homeController.Check.value == 0 ? homeController.txtAuthorName : homeController.txtUpdateAuthorName,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person,size: 21.sp,),
                      prefixIconColor: Colors.grey,
                      hintText: homeController.Check.value == 0 ? "Author Name" : "Update Author Name",
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
                        return "Please Add Author Name";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: Get.width/18,),
                  TextFormField(
                    controller: homeController.Check.value == 0 ? homeController.txtAboutAuthor : homeController.txtUpdateAboutAuthor,
                    textInputAction: TextInputAction.next,
                    maxLines: 4,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.edit,size: 21.sp,),
                      prefixIconColor: Colors.grey,
                      hintText: homeController.Check.value == 0 ? "About Author" : "Update About Author",
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
                        return "Please Add About Author";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: Get.width/18,),
                  TextFormField(
                    controller: homeController.Check.value == 0 ? homeController.txtAboutBook : homeController.txtUpdateAboutBook,
                    textInputAction: TextInputAction.next,
                    maxLines: 4,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.menu_book,size: 21.sp,),
                      prefixIconColor: Colors.grey,
                      hintText: homeController.Check.value == 0 ? "About Book" : "Update About Book",
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
                        return "Please Add About Book";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: Get.width/18,),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: homeController.Check.value == 0 ? homeController.txtBookRating : homeController.txtUpdateBookRating,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.star,size: 21.sp,),
                      prefixIconColor: Colors.grey,
                      hintText: homeController.Check.value == 0 ? "Rating Max. 5" : "Update Rating Max. 5",
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
                        return "Please Add Rating";
                      }
                      else if(double.parse(value) > 5.0)
                        {
                          return "Please Add Rating Maximum 5 Rating";
                        }
                      return null;
                    },
                  ),
                  SizedBox(height: Get.width/18,),
                  TextFormField(
                    controller: homeController.Check.value == 0 ? homeController.txtBookPublishYear : homeController.txtUpdateBookPublishYear,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.calendar_month,size: 21.sp,),
                      prefixIconColor: Colors.grey,
                      hintText: homeController.Check.value == 0 ? "Publish Year" : "Update Publish Year",
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
                        return "Please Add Publish Year";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: Get.width/18,),
                  Container(
                    height: Get.height/15,
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.black54)
                    ),
                    padding: EdgeInsets.symmetric(horizontal: Get.width/21),
                    child: Obx(
                      () => DropdownButtonHideUnderline(
                        child: DropdownButton(
                          borderRadius: BorderRadius.circular(15),
                          items: homeController.CategoryList.asMap().entries.map((e) => DropdownMenuItem(child: Text("${homeController.CategoryList[e.key]['name']}"),value: "${homeController.CategoryList[e.key]['name']}",)).toList(),
                          onChanged: (value) {
                            homeController.DropDownValue.value = value!;
                            print("====== ${homeController.DropDownValue.value}");
                          },
                          value: homeController.DropDownValue.value,
                  ),
                      ),
                    ),
                  ),
                  SizedBox(height: Get.width/18,),
                  InkWell(
                    onTap: (){
                      if(homeController.AddBookkey.currentState!.validate())
                        {
                          if(homeController.Check.value == 0)
                            {
                              BookDataModel bookDataModel = BookDataModel(
                                name: homeController.txtBookName.text,
                                image: homeController.txtBookImgLink.value.text,
                                author_name: homeController.txtAuthorName.text,
                                author_about: homeController.txtAboutAuthor.text,
                                book_about: homeController.txtAboutBook.text,
                                rating: homeController.txtBookRating.text,
                                category: homeController.DropDownValue.value,
                                publish_year: homeController.txtBookPublishYear.text,
                              );
                              FirebaseHelper.firebaseHelper.InsertBookData(bookDataModel);
                            }
                          else
                            {
                              BookDataModel bookDataModel = BookDataModel(
                                name: homeController.txtUpdateBookName.text,
                                image: homeController.txtUpdateBookImgLink.value.text,
                                author_name: homeController.txtUpdateAuthorName.text,
                                author_about: homeController.txtUpdateAboutAuthor.text,
                                book_about: homeController.txtUpdateAboutBook.text,
                                rating: homeController.txtUpdateBookRating.text,
                                category: homeController.DropDownValue.value,
                                publish_year: homeController.txtUpdateBookPublishYear.text,
                              );
                              FirebaseHelper.firebaseHelper.UpdateBookData(bookDataModel: bookDataModel,id: homeController.Id.value);
                            }
                          Get.back();
                          homeController.AddBookkey.currentState!.reset();
                          homeController.txtBookImgLink.value.clear();
                          homeController.txtUpdateBookImgLink.value.clear();
                        }
                      else
                        {
                          ToastMessage(msg: "Please Add Your Data");
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
                        "${homeController.Check.value == 0 ? "Add Book" : "Update Book"}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: Get.width/18,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget bottomSheet()
  {
    return Container(
      height: Get.height/6,
      padding: EdgeInsets.only(left: Get.width/30,),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: Get.height/60),
            child: Text(
              "Choose Any One",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.sp
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: Get.height/40),
            child: Row(
              children: [
                IconButton(onPressed: () async {
                  ImagePicker imagePicker = ImagePicker();
                  XFile? image = await imagePicker.pickImage(source: ImageSource.camera);
                  homeController.Check == 0 ? homeController.txtBookImgLink.value = TextEditingController(text: image!.path) : homeController.txtUpdateBookImgLink.value = TextEditingController(text: image!.path);
                  Get.back();
                }, icon: Icon(Icons.camera_enhance_outlined,color: Colors.black,)),
                SizedBox(width: Get.width/21,),
                IconButton(onPressed: () async {
                  ImagePicker imagePicker = ImagePicker();
                  XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);
                  homeController.Check == 0 ? homeController.txtBookImgLink.value = TextEditingController(text: image!.path) : homeController.txtUpdateBookImgLink.value = TextEditingController(text: image!.path);
                  Get.back();
                }, icon: Icon(Icons.image_outlined,color: Colors.black,)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
