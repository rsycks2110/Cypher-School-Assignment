import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_app_using_bloc/ui/expense_management/home_page.dart';
import 'package:expense_app_using_bloc/ui/widgets/app_widgts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget{

   static final Login_Value="isLoggedIn";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController=TextEditingController();

  TextEditingController passwordController=TextEditingController();

   UserCredential? credential;

   bool visibility=true;

  @override
  Widget build(BuildContext context) {
    bool isLandScape = MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Login",style: mTextStyle16(),),
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height:40,
                child: mTextField(mController: emailController,mLabel: Text("Email"),mHintText: "Email")),
            SizedBox(height: 15,),
            SizedBox(height: 40,
                  child: TextField(
                    controller: passwordController,
                    obscureText: visibility,
                    decoration: InputDecoration(
                        hintText: "Enter Password Here",
                        labelText: "Password",
                        hintStyle: TextStyle(fontSize: 12),
                        labelStyle: TextStyle(color: Colors.grey,fontSize: 12,fontWeight: FontWeight.normal),
                        suffix:InkWell(
                          onTap: (){
                            visibility=!visibility;
                            setState(() {

                            });

                          },
                            child: Icon(Icons.remove_red_eye)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey.withOpacity(0.5))
                        ),
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey.withOpacity(0.5))
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey.withOpacity(0.5))
                        )
                    ),
                  )),
            SizedBox(height: 25,),
            Container(
                height: MediaQuery.of(context).size.height*.07,
                width: double.infinity,
                child: mButton(onTap: () async{
                  try {
                     credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: emailController.text.toString(),
                        password: passwordController.text.toString(),
                    );
                     print(credential!.user!.uid!);
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.setString("u_id",(credential!.user!.uid!) );
                    prefs.setInt(LoginPage.Login_Value, 1);
                    if(credential!.user!.uid!=null){

                       FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;
                       DocumentReference<Map<String, dynamic>> expenses =  firebaseFireStore.collection("users").doc("${credential!.user!.uid}");
                       var docRef = expenses.collection("expenses");
                     Navigator.push(context, MaterialPageRoute(builder: (context){
                       return DashBoard();
                     }));
                    }
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'user-not-found') {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Center(child: Text('No user found for that email.'))));
                    } else if (e.code == 'wrong-password') {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Center(child: Text('Wrong password provided for that user.'))));
                    }else if(e.code=='invalid-email'){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Given Email Is Invalid.')));
                    }
                  }

                },mTitle: "Login"))
          ],
        ),
      )
    );
  }

  Widget MainUI({required BuildContext context}){
    return Padding(
      padding:  EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          mTextField(mController: emailController,mLabel: Text("Email"),mHintText: "Email"),
          SizedBox(height: 15,),
          mTextField(mController: passwordController,mLabel: Text("Password"),mHintText: "Password"),
          SizedBox(height: 25,),
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return DashBoard();
              }));
            },
            child: Container(
              height: 50,
                width: double.infinity,
                child: mButton(onTap: (){},mTitle: "Login")),
          )
        ],
      ),
    );
  }

  Widget LandScapeUI({required BuildContext context}){
    return Row(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Welcome Here",style: mTextStyle16(),),
              SizedBox(height: 30,),
            ],
          ),
        ),

          Expanded(child: MainUI(context: context)
        )

      ],
    );
  }

  Widget PortraitUI({required BuildContext context}){
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text("Welcome Here",style: mTextStyle16(),),
      SizedBox(height: 30,),
     MainUI(context: context)
    ],);
  }
}


