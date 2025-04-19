import 'package:expense_app_using_bloc/data/local/expense_database.dart';
import 'package:expense_app_using_bloc/ui/expense_management/add_expense.dart';
import 'package:expense_app_using_bloc/ui/expense_management/add_income.dart';
import 'package:expense_app_using_bloc/ui/expense_management/fetch_expense.dart';
import 'package:expense_app_using_bloc/ui/expense_management/home_page.dart';
import 'package:expense_app_using_bloc/ui/expense_management/profile_page.dart';
import 'package:expense_app_using_bloc/ui/home/bloc/home_bloc.dart';
import 'package:expense_app_using_bloc/ui/splash/splash_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'firebase_options.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(BlocProvider(create: (context){
    return HomeBloc(db: DataBaseHelper.db);
  },child: MyApp()));
}
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return MaterialApp(
     debugShowCheckedModeBanner: false,
     home: SplashPage(),
     theme:ThemeData(
       primarySwatch: Colors.orange
     )
   );
  }

}