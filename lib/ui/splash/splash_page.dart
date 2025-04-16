import 'dart:async';
import 'package:expense_app_using_bloc/domain/app_constants.dart';
import 'package:expense_app_using_bloc/ui/splash/splashPageFinal.dart';
import 'package:expense_app_using_bloc/ui/user_on_board/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}
class _SplashPageState extends State<SplashPage> {
@override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
        return SplashPageFinal();
     }));
    });
  }
  @override
  Widget build(BuildContext context) {
  return Scaffold(
      body: Container(
       width: double.infinity,
        height: double.infinity,
       decoration:BoxDecoration(
         image: DecorationImage(image: AssetImage("assets/images/cipher_image.PNG",),fit:BoxFit.fill)
       ),
       //Image.asset("assets/images/cipher_image.PNG"),
        ),
      );
  }
}
