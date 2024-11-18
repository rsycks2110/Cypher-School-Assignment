import 'package:expense_app_using_bloc/ui/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return MaterialApp(
     debugShowCheckedModeBanner: false,
     home:SplashPage(),
     theme:ThemeData(
       primarySwatch: Colors.orange
     )
   );
  }

}