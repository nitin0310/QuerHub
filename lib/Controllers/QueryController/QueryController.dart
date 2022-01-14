import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:querhub/Models/UserModel.dart';

class QueryController extends GetxController{
  CollectionReference queryReference = FirebaseFirestore.instance.collection('Queries');
  CollectionReference myQueriesReference = FirebaseFirestore.instance.collection('Users').doc(UserModel.uid).collection('MyQueries');

  Future createQuery(String title, String description) async {
    Map<String,String> data = {
      'title' : '${title}',
      'description' : '${description}',
      'userUID' : UserModel.uid
    };
    queryReference.add(data).then((value) {
      myQueriesReference.doc(value.id).set(data);
      Get.snackbar("Upload done", "Your query has been uploaded.");
      Get.back();
    });

  }
}