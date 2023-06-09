import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login_project/Screens/AddBookScreen/Model/BookDataModel.dart';

class FirebaseHelper
{
  static FirebaseHelper firebaseHelper = FirebaseHelper._();
  FirebaseHelper._();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  String? UserUid;


  //SignUp Account Function
  Future<dynamic> CreateSignUp({required String email, required String password}) async
  {
    dynamic isSignUp;

    await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password).then(
      (value) {
        print("========= Successfully ");
        isSignUp = true;
      },
    ).catchError((error) {
      int len = 0;
      for(int i=0; i<error.toString().length; i++)
      {
        if(error.toString()[i].contains(']'))
        {
          len = i + 2;
          print("object====== $len");
          break;
        }
      }
      isSignUp = error.toString().substring(len,error.toString().length);
    },);

    return isSignUp;
  }

  //SignIn Account Function
  Future<dynamic> SignInUser({required String email, required String password})
  async {
    dynamic isSignIn;

    await firebaseAuth.signInWithEmailAndPassword(email: email, password: password)
    .then((value) {
      print("object== $value");
      isSignIn = true;
    })
    .catchError((error){
      int len = 0;
      for(int i=0; i<error.toString().length; i++)
        {
          if(error.toString()[i].contains(']'))
            {
              len = i + 2;
              print("object====== $len");
              break;
            }
        }
      isSignIn = error.toString().substring(len,error.toString().length);
    });
    print("===== $isSignIn");
    return isSignIn;
  }

  //Check User Login
  Future<bool> CheckSignIn()
  async {

    if(await firebaseAuth.currentUser != null)
      {
        return true;
      }
    return false;

  }

  //Sign Out User
  Future<void> SignOutUser()
  async {
    await FirebaseAuth.instance.signOut();
  }

  //Login With Google
  Future<dynamic> GoogleLogIn()
  async {

    dynamic isLogin;
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential)
    .then((value) {
      isLogin = true;
    })
    .catchError((error) {
      int len = 0;
      for(int i=0; i<error.toString().length; i++)
      {
        if(error.toString()[i].contains(']'))
        {
          len = i + 2;
          print("object====== $len");
          break;
        }
      }
      isLogin = error.toString().substring(len,error.toString().length);
    });
  }

  //Login With Facebook
  Future<dynamic> FacebookLogIn()
  async {

    dynamic isLogin;
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    FirebaseAuth.instance.signInWithCredential(facebookAuthCredential)
    .then((value) {
      isLogin = true;
    })
    .catchError((error) {
      int len = 0;
      for(int i=0; i<error.toString().length; i++)
      {
        if(error.toString()[i].contains(']'))
        {
          len = i + 2;
          print("object====== $len");
          break;
        }
      }
      isLogin = error.toString().substring(len,error.toString().length);
    });
    print("===== $isLogin");

    return isLogin;
  }

  //Read User Details
  void UserDetails()
  {
    User? user = firebaseAuth.currentUser;
    UserUid = user!.uid;
  }

  //Book Data
  //Insert Data(Book Data) In Cloud Firestore Database
  Future<void> InsertBookData(BookDataModel bookDataModel)
  async {
    UserDetails();
    await firebaseFirestore.collection("Users").doc(UserUid).collection('Books').add({
        'name' : bookDataModel.name,
        'image' : bookDataModel.image,
        'author_name' : bookDataModel.author_name,
        'author_about' : bookDataModel.author_about,
        'book_about' : bookDataModel.book_about,
        'rating' : bookDataModel.rating,
        'publish_year' : bookDataModel.publish_year,
        'category' : bookDataModel.category,
      });

  }

  //Read Data(Book Data) In Cloud Firestore Database
  Stream<QuerySnapshot<Map<String, dynamic>>> ReadBookData()
  {
    UserDetails();
    return firebaseFirestore.collection("Users").doc(UserUid).collection('Books').snapshots();
  }


  //Delete Data(Book Data) In Cloud Firestore Database
  void DeleteBookData({required String id})
  {
    print("====== DELETE $id");
    UserDetails();
    firebaseFirestore.collection("Users").doc(UserUid).collection('Books').doc(id).delete();
  }


  //Update Data(Book Data) In Cloud Firestore Database
  void UpdateBookData({required String id, required BookDataModel bookDataModel})
  {
    UserDetails();
    firebaseFirestore.collection("Users").doc(UserUid).collection("Books").doc(id).update({
        'name' : bookDataModel.name,
        'image' : bookDataModel.image,
        'author_name' : bookDataModel.author_name,
        'author_about' : bookDataModel.author_about,
        'book_about' : bookDataModel.book_about,
        'rating' : bookDataModel.rating,
        'publish_year' : bookDataModel.publish_year,
        'category' : bookDataModel.category,
      });
  }


  //Category Data
  //Insert Data(Category Data) In Cloud Firestore Database
  Future<void> InsertCategoryData(String CategoryName)
  async {
    UserDetails();
    await firebaseFirestore.collection("Users").doc(UserUid).collection('Category').add({'category_name' : CategoryName, 'selected' : false});

  }

  //Read Data(Category Data) In Cloud Firestore Database
  Stream<QuerySnapshot<Map<String, dynamic>>> ReadCategoryData()
  {
    UserDetails();
    return firebaseFirestore.collection("Users").doc(UserUid).collection('Category').snapshots();
  }

  //Delete Data(Category Data) In Cloud Firestore Database
  void DeleteCategoryData({required String id})
  {
    print("====== DELETE $id");
    UserDetails();
    firebaseFirestore.collection("Users").doc(UserUid).collection('Category').doc(id).delete();
  }


  //Update Data(Category Data) In Cloud Firestore Database
  void UpdateCategoryData({required String id, required String CategoryName, required bool Selected})
  {
    UserDetails();
    firebaseFirestore.collection("Users").doc(UserUid).collection("Category").doc(id).update({'category_name' : CategoryName,'selected' : Selected});
  }

}