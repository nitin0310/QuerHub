
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:querhub/Models/UserModel.dart';
import 'package:querhub/Views/Authentication/SignUp.dart';
import 'package:querhub/Views/DashboardPage.dart';

class Authentication extends GetxController {

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  CollectionReference usersReference = FirebaseFirestore.instance.collection('Users');

  Future registerUser(String userName, String email, String password) async {
    UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    usersReference.doc(userCredential.user!.uid).set({
      'username':'${userName}',
      'uid':'${userCredential.user!.uid}',
      'email':'${userCredential.user!.email}',
    }).whenComplete((){
      UserModel.username = userName;
      UserModel.uid = userCredential.user!.uid;
      UserModel.email = email;
      Get.offAll(Dashboard());
    }).catchError((e) => print(e.toString()));
  }

  Future loginUser(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password).then((credential) {
      usersReference.doc(credential.user!.uid).get().then((value) {
        UserModel.username = value.get('username');
        UserModel.email = value.get('email');
        UserModel.uid = credential.user!.uid;
      });
    }).whenComplete(() => Get.offAll(() => Dashboard())).catchError((e) => print(e.toString()));
  }

  Future logoutUser() async {
    await _firebaseAuth.signOut().whenComplete(() => Get.offAll(() => SignUp())).catchError((e) => print(e.toString()));
  }
}