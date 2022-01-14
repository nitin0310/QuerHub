import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowQuery extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text(""),//show title
          Text(""),//show description
          Divider(height: 2.0,),
          TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))
              )
            ),
          ),//to write comment
          Container(),//upload comment button

        ],
      ),
    );
  }
}
