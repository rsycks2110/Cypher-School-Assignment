import 'dart:async';

import 'package:expense_app_using_bloc/ui/expense_management/home_page.dart';
import 'package:expense_app_using_bloc/ui/user_on_board/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../user_on_board/register_page.dart';

class SplashPageFinal extends StatefulWidget{

  @override
  State<SplashPageFinal> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPageFinal> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      whereToGo();
    });
  }

  whereToGo() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int? isLogIN = await sharedPreferences.getInt(LoginPage.Login_Value);

    if (isLogIN == null || isLogIN == 0) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return RegisterPage();
      }));
    } else if (isLogIN == 1) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return DashBoard();
      }));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/cipher2final.PNG"),
                fit: BoxFit.fill)
        ),
      ),
    );
  }

}