import 'dart:async';
import 'package:expense_app_using_bloc/domain/app_constants.dart';
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
    Timer(Duration(seconds: 5),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
        return LoginPage();
      }));
    });
  }
  @override
  Widget build(BuildContext context) {
  return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 60,
            child: FlutterLogo(),
            ),
            SizedBox(height: 30,),
            Text(AppConstatnts.app_name),
            SizedBox(height: 30,),
            Text(AppConstatnts.app_tag_line)
          ],
        ),
      )
    );
  }
}
