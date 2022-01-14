import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:querhub/Controllers/AuthController/Authentication.dart';
import 'package:querhub/Models/UserModel.dart';
import 'package:querhub/Views/Authentication/SignUp.dart';
import 'package:querhub/Views/DashboardPage.dart';

class Login extends StatelessWidget {

  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  Authentication authController = Get.put(Authentication());

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Login",style: TextStyle(color: Colors.white),),backgroundColor: Colors.black,centerTitle: true,),
      body: SingleChildScrollView(
          child: Center(
            child: Container(
              margin: EdgeInsets.only(left: 20.0,right: 20.0,top: 40.0),
              height: 500,

              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Center(
                      child: Icon(Icons.security,size: 85,color: Colors.black54,),
                    ),
                    SizedBox(height: 30.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text("Enter email"),
                        ),
                      ],
                    ),

                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.grey)
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.redAccent)
                          )
                      ),
                      validator: (value){
                        return (value != null && !value.contains("@gmail.com")) ? 'Invalid email! Please enter again' : null;
                      },
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text("Enter password"),
                        ),
                      ],
                    ),

                    TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      controller: passwordController,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.grey)
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.redAccent)
                          )
                      ),
                      obscureText: true,
                      validator: (value){
                        return (value != null && value.length < 8) ? "Password should be atleast 8 characters" : null;
                      },
                    ),

                    Container(
                      height: 50.0,
                      width: MediaQuery.of(context).size.width*2/3+50,
                      margin: EdgeInsets.only(top: 20.0,right: 30.0,left: 30.0),
                      child: MaterialButton(
                          color: Colors.blue[700],
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25))),
                          onPressed: ()=> loginUser(),
                          child: Center(child: Text("Login",style: TextStyle(color: Colors.white),),)
                      ),
                    ),

                    Container(
                      height: 50.0,
                      width: MediaQuery.of(context).size.width*2/3+50,
                      margin: EdgeInsets.only(top: 20.0,right: 30.0,left: 30.0),
                      child: MaterialButton(
                          color: Colors.black,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25))),
                          onPressed: ()=> Get.off(SignUp()),
                          child: Center(child: Text("Sign Up here",style: TextStyle(color: Colors.white),),)
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
      ),
    );
  }

  void loginUser() {
    if(validateUser()){
      authController.loginUser(emailController.value.text.toString() , passwordController.value.text.toString());
    }else{
      print("Error occurred while login");
    }
  }

  bool validateUser() {
    if(formKey.currentState!.validate()){
      return true;
    }
    return false;
  }
}
