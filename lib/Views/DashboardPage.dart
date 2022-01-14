import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:querhub/Controllers/AuthController/Authentication.dart';
import 'package:querhub/Controllers/QueryController/QueryController.dart';
import 'package:querhub/Views/Services/CreateQuery.dart';
import '../Models/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Dashboard extends StatefulWidget {

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Authentication authController = Get.put(Authentication());
  QueryController queryController = Get.put(QueryController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.create_outlined),
        backgroundColor: Colors.black,
        onPressed: () => Get.to(CreateQuery()),
      ),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text("QuerHub",style: TextStyle(color: Colors.white,fontSize: 18.0,fontWeight: FontWeight.w400),),
        ),
        actions: [
          IconButton(icon: Icon(Icons.delete_outline,color: Colors.redAccent,),onPressed: (){},),
          IconButton(icon: Icon(Icons.logout), onPressed: ()=> logout(),iconSize: 20.0,),
        ],
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: queryController.queryReference.snapshots(),
        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){

          if(snapshot.connectionState == ConnectionState.none){
            return Center(child: Text("No internet Connection",style: TextStyle(color: Colors.black54,fontSize: 18.0),),);
          }
          else if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          }

          if(snapshot.data!.size == 0){
            return Center(child: Text("Nothing to show",style: TextStyle(color: Colors.black54,fontSize: 18.0),),);
          }else{
            return ListView.builder(
              itemCount: snapshot.data!.size,
              itemBuilder: (BuildContext context,int index){
                return Padding(
                  padding: const EdgeInsets.only(top: 5.0, left: 5.0, right: 5.0),
                  child: ListTile(
                    tileColor: Colors.black12,
                    title: Text(snapshot.data!.docs[index]['title']),
                    subtitle: Text(snapshot.data!.docs[index]['description']),
                    onTap: (){},
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Future logout() async {
    authController.logoutUser();
  }
}
