import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_app_using_bloc/ui/expense_management/home_page.dart';
import 'package:expense_app_using_bloc/ui/user_on_board/login_page.dart';
import 'package:expense_app_using_bloc/ui/widgets/app_widgts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RegisterPage extends StatefulWidget{

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  TextEditingController nameController=TextEditingController();

  TextEditingController emailController=TextEditingController();

  TextEditingController passwordController=TextEditingController();
  UserCredential? credential;
  bool visibility= true;
@override
  Widget build(BuildContext context) {
   return Scaffold(
     body:SafeArea(
       child: Padding(
         padding: EdgeInsets.only(left: 15.0,right: 15,top: 15),
         child: ListView(
           children: [
            ListTile(
              leading: Icon(Icons.arrow_back_outlined),
              title: Center(child: Text("Sign Up",style: mTextStyle16(),)),
            ),
            SizedBox(height: MediaQuery.of(context).size.height*.08,),
             SizedBox(height: 40,
                 child: mTextField(mController: nameController,mLabel: Text("Name"),mHintText:"Enter Name Here")),
             SizedBox(height: 15,),
             SizedBox(height: 40,
                 child: mTextField(mController: emailController,mHintText:"Enter Email Here",mLabel: Text("Email"))),
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
                 SizedBox(height: 15,),
             Row(
               children: [
                 Checkbox(value: false, onChanged: (value){
                   value=true;
             }),
                 SizedBox(width: 5,),
                 RichText(text: TextSpan(
                   text: "By Signing up, you agree to the ",style: mTextStyle14(mFontWeight: FontWeight.bold),
                   children: [
                     TextSpan(text: "Terms of Service and Privacy Policy",style: mTextStyle12(mColor: Colors.deepPurple,mFontWeight: FontWeight.bold))
                   ]
                 ))
               ],
             ),
             SizedBox(height: 20,),
             Container(height: MediaQuery.of(context).size.height*.07,
               child: mButton(onTap: () async{

                 try {
                  credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                     email: emailController.text.toString(),
                     password:  passwordController.text.toString(),
                 );

                   emailController.clear();
                   passwordController.clear();
                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Center(child: Text("Registered Successfully"))));
                 }
                 on FirebaseAuthException catch(e){
                   if(e.code == 'weak-password') {
                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Center(child: Text('The password provided is too weak.'))));
                   }
                   else if(e.code == 'email-already-in-use') {
                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Center(child: Text('The account already exists for that email.'))));
                   }else if(e.code=='invalid-email'){
                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Given Email Is Invalid.')));
                   }
                }
                 catch(e){
                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                 }

               },mTitle: "Sign Up"
               ),
             ),
             SizedBox(height: 10,),
             Center(child: Text("Or with",style: mTextStyle12(mFontWeight: FontWeight.bold,mColor: Colors.grey),))
             ,SizedBox(height:20),
             Row(mainAxisAlignment: MainAxisAlignment.center,
               children: [
               FaIcon(FontAwesomeIcons.google,size: 16,),
               SizedBox(width: 5,),
               Text("Sign Up with Google",style: mTextStyle16(),)
             ],),
             SizedBox(height: 20,),
             Center(
               child: RichText(text: TextSpan(
                 children: [
                   TextSpan(text: "Already have an account? ",style: mTextStyle14(mColor: Colors.grey)),
                   TextSpan(text: "Login",style: mTextStyle14(mColor: Colors.deepPurpleAccent).copyWith(decoration: TextDecoration.underline),
                   recognizer: TapGestureRecognizer() ..onTap = (){
                     Navigator.push(context,MaterialPageRoute(builder: (context){
                       return LoginPage();
                     }));
                   }
                   )
                 ]
               )),
             )
           ],
         ),
       ),
     )
   );
  }
}