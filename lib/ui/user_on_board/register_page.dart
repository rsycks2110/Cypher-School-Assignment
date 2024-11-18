import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget{

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  TextEditingController nameController=TextEditingController();

  TextEditingController usernameController=TextEditingController();

  TextEditingController mobileController=TextEditingController();

  TextEditingController emailController=TextEditingController();

  TextEditingController passwordController=TextEditingController();

  TextEditingController rePasswordController=TextEditingController();

  List<Map<String,dynamic>> mNotes=[];
  static const String Customer_Username="UserName";
  static const String Customer_Password = "Password";
@override
  Widget build(BuildContext context) {
   return Scaffold(
  appBar: AppBar(
    leading: GestureDetector(onTap: (){
      Navigator.pop(context);
    },
        child: Icon(Icons.arrow_back,color: Colors.white,)),
  ),
     body: Container(
       color: Colors.white,
       width: double.infinity,
       height: double.infinity,
       child: Padding(
         padding: const EdgeInsets.all(10.0),
          child: Column(
           // shrinkWrap: true,
           children: [
             const Center(child: Text("Sign UP",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w500,color:Colors.green),)),
           SizedBox(height: 50,),
             SizedBox(height: 60,
               child: Row(
                 children: [
                   Expanded(
                     flex:3,
                     child: TextField(controller: nameController,
                     keyboardType: TextInputType.name,
                     decoration: InputDecoration(
                       hintText: "First Name",
                       enabledBorder: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(20),
                       ),
                       focusedBorder: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(20)
                     ),
                     ),
                   ),),
                   SizedBox(width: 10),
                   Expanded(
                     flex:3,
                     child: TextField(controller: nameController,
                       keyboardType: TextInputType.name,
                       decoration: InputDecoration(
                           hintText: "Last Name",

                         enabledBorder: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(20),
                         ),
                         focusedBorder: OutlineInputBorder(
                             borderRadius: BorderRadius.circular(20)
                       ),
                     ),
                   ),),
                 ],
               ),
             ),
             const SizedBox(height: 20,),
             SizedBox(height: 60,
               child: Expanded(
                 flex: 3,
                 child: Container(
                   child: TextField(controller: usernameController,
                     keyboardType: TextInputType.name,
                     decoration: InputDecoration(
                         hintText: "Enter UserName",

                       enabledBorder: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(20),
                       ),
                       focusedBorder: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(20)
                     ),
                   ),
                 ),
               ),
             ),),

             SizedBox(height: 60,
               child: Row(
                 children: [
                   Expanded(
                     flex: 5,
                     child: Container(
                       child: TextField(controller: mobileController,
                         keyboardType: TextInputType.number,
                         decoration: InputDecoration(
                           hintText: "Enter  Mobile Number ",

                           enabledBorder: OutlineInputBorder(
                             borderRadius: BorderRadius.circular(20),
                           ),
                           focusedBorder: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(20)
                         ),
                       ),
                     ),
                   ),),
                   SizedBox(width: 10),
                   Expanded(
                     flex: 5,
                     child: Container(
                       child: TextField(
                         controller: emailController,
                         decoration: InputDecoration(
                             hintText: "Enter  Email ",
                             enabledBorder: OutlineInputBorder(
                                 borderRadius: BorderRadius.circular(20),
                             ),
                           focusedBorder: OutlineInputBorder(
                             borderRadius: BorderRadius.circular(20)
                           )
                         ),
                       ),
                     ),
                   )
                 ],
               ),
             ),
             const SizedBox(height: 30,),

           SizedBox(height: 60,
           child: Row(
           children: [


         Expanded(
    flex: 9,
    child: Container(
    child: TextField(
      controller: passwordController,
    decoration: InputDecoration(
      hintText: "Enter Password ",
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide: BorderSide(
    color: Colors.black
    )
    )
    ),
    ),
    ),
    ),
             SizedBox(width: 10,),
             Expanded(
               flex: 9,
               child: Container(
                 child: TextField(controller: rePasswordController,
                   decoration: InputDecoration(
                       hintText: "Retype  Password",
                       border: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(20),
                           borderSide: BorderSide(
                               color: Colors.black
                           )
                       )
                   ),
                 ),
               ),
             )
    ],
    ),
    ),

             const SizedBox(height: 30,),
             SizedBox(height: 50,width: MediaQuery.of(context).size.width/3,
               child: ElevatedButton(onPressed: () async{


               },style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                   child: Text("Submit",style: TextStyle(fontSize:20,fontWeight: FontWeight.w500,color: Colors.white),)),
             )
           ],
         ),
       ),
     ),
   );
  }
}