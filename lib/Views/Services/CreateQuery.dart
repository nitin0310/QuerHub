import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:querhub/Controllers/QueryController/QueryController.dart';

class CreateQuery extends StatelessWidget {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  QueryController queryController = Get.put(QueryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload your query",style: TextStyle(fontSize: 18),), backgroundColor: Colors.black,
        actions: [
          IconButton(icon: Icon(Icons.my_library_add),color: Colors.white,onPressed: (){},),//my queries
          IconButton(icon: Icon(Icons.bookmark_border),color: Colors.orange,onPressed: (){},),//saved queries
        ],
      ),
      body: Column(
        children: [

          Form(
            key: formKey,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0, bottom: 10.0),
                  child: TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(
                      hintText: "Enter title",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                    validator: (value){
                      if(value!.length == 0) return "Enter valid title.";
                    },
                  ),
                ),


                Container(
                  margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                  child: TextFormField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                      hintText: "Enter description",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                    validator: (value){
                      if(value!.length == 0) return "Enter valid description.";
                    },
                  ),
                ),
              ],
            ),
          ),

          GestureDetector(
            onTap: () => createQuery(titleController.value.text, descriptionController.value.text),
            child: Container(
              margin: EdgeInsets.only(top: 15.0),
              width: (Get.width*2)/3,
              height: 45.0,
              decoration: BoxDecoration(
                color: Colors.blue[800],
                borderRadius: BorderRadius.all(Radius.circular(10.0))
              ),
              child: Center(
                child: Text("Upload",style: TextStyle(color: Colors.white,fontSize: 17.0),),
              ),
            ),
          )
        ],
      ),
    );
  }


  void createQuery(String title, String description){
    if(formKey.currentState!.validate()){
      queryController.createQuery(title, description);
    }
  }
}
