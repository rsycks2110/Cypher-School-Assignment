import 'package:expense_app_using_bloc/domain/app_colors.dart';
import 'package:expense_app_using_bloc/ui/expense_management/add_expense.dart';
import 'package:expense_app_using_bloc/ui/expense_management/expense_graph.dart';
import 'package:expense_app_using_bloc/ui/expense_management/fetch_expense.dart';
import 'package:expense_app_using_bloc/ui/expense_management/profile_page.dart';
import 'package:expense_app_using_bloc/ui/widgets/app_widgts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'add_income.dart';

class DashBoard extends StatefulWidget{

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  List<Widget> dashBoardPages=[
    FetchExpense(),
    Container(child: Center(child: Text("Transaction",style: mTextStyle30(),)),),
    ExpenseGraph(),
    ProfilePage()

  ];

  int selectedIndex=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:dashBoardPages[selectedIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        width: 40,height: 40,
        child: FloatingActionButton(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: AppColors.secondaryGreyColor,
          shape: CircleBorder(),
          onPressed: (){
   showModalBottomSheet(context: context, builder:(context){
     return bottomSheetContent(context);
   });
        },
        child: Icon(Icons.add),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (value){
          selectedIndex=value;
          setState(() {
          });
        },
        destinations: [

          NavigationDestination(icon: Icon(Icons.home_filled), label: "Home"),
          NavigationDestination(icon: Icon(Icons.money), label: "Transactions"),
          NavigationDestination(icon: Icon(Icons.graphic_eq), label:"Budget"),
          NavigationDestination(icon: Icon(Icons.account_box_outlined), label: "Profile"),
        ],),
    );
  }
 Widget bottomSheetContent(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height*0.5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                    child: Icon(Icons.arrow_back_outlined)),
              ],
            ),
            SizedBox(height: 30,),
            Text("Select Your Input.......  ",style: mTextStyle16(),),
            SizedBox(height: 30,),
            mButton(onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return AddIncome();
              }));
            },mTitle: "Add Income",mColor: AppColors.primaryColor),
            SizedBox(height: 15),
        mButton(onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return AddExpense();
          }));
        },mTitle: "Add Expense",mColor: AppColors.primaryColor)
          ],
        ),
      ),
    );
 }
}