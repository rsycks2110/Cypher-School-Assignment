import 'package:expense_app_using_bloc/ui/user_on_board/register_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget{

  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool isLandScape = MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Login Page"),
      ),
      body: isLandScape ? LandScapeUI(context: context) : PortraitUI(context: context),
    );
  }
  Widget MainUI({required BuildContext context}){
    return Column(mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
            child:TextField(
              controller: emailController,
              decoration: InputDecoration(
                  hintText: "Enter Your Email Here",
                  hintStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.w300,color: Colors.orange),
                  labelText: "Email",
                  labelStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.w300,color: Colors.green),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)
                  )
              ),
            )
        ),
        SizedBox(height: 30,),
        SizedBox(
            child:TextField(
              controller: passwordController,
              decoration: InputDecoration(
                  hintText: "Enter Your Password Here",
                  labelStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.w300,color: Colors.green),
                  hintStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.w300,color:Colors.orange),
                  labelText: "Password",
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)
                  )
              ),
            )
        ),
        SizedBox(height: 30,),
        SizedBox(height: 40,width: MediaQuery.of(context).size.width/3,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange,foregroundColor: Colors.yellow,
                  shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)) ),
              onPressed: (){
                }, child: Text("Login",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.white),)),
        ),
        SizedBox(height: 30,),
        RichText(text: TextSpan(
            style: TextStyle(fontSize: 20,fontWeight: FontWeight.w300,color: Colors.purple),
            children: <TextSpan>[
              TextSpan(
                  text: "Don't ",style: TextStyle(fontWeight: FontWeight.w300,color: Colors.red)
              ),
              TextSpan(
                  text: "Have "
              ),
              TextSpan(
                  text: "An Account",style: TextStyle(fontWeight: FontWeight.w400,color: Colors.deepOrange)
              ),
              TextSpan(text: "  "),
              TextSpan(text:"Register Here",style: TextStyle(fontWeight: FontWeight.w400,color: Colors.purple),
              recognizer: TapGestureRecognizer()
                ..onTap= (){
                Navigator.push(context,MaterialPageRoute(builder: (context){
                  return RegisterPage();
                }));
    }


              )

            ]
        ))
      ],
    );
  }
  Widget LandScapeUI({required BuildContext context}){
    return Row(
      children: [
        Expanded(
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Welcome Here",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w500,color: Colors.greenAccent),

              ),
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
      Text("Welcome Here",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w500,color: Colors.greenAccent),),
      SizedBox(height: 30,),
     MainUI(context: context)
    ],);
  }


}


