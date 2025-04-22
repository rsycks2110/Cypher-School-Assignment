import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_app_using_bloc/bloc/expense_bloc.dart';
import 'package:expense_app_using_bloc/bloc/expense_event.dart';
import 'package:expense_app_using_bloc/bloc/expense_state.dart';
import 'package:expense_app_using_bloc/data/firebase/firebase_repository.dart';
import 'package:expense_app_using_bloc/data/model/cat_model.dart';
import 'package:expense_app_using_bloc/data/model/date_wise_expense_model.dart';
import 'package:expense_app_using_bloc/data/model/expense_model.dart';
import 'package:expense_app_using_bloc/ui/widgets/app_widgts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';

import '../../domain/app_colors.dart';
import '../../domain/app_constants.dart';

class FetchExpense extends StatefulWidget{

  @override
  State<FetchExpense> createState() => _FetchExpenseState();
}

class _FetchExpenseState extends State<FetchExpense> with SingleTickerProviderStateMixin {

var mUsers;

  @override
  void initState() {
    super.initState();

   // BlocProvider.of<ExpenseBloc>(context).add(FetchExpenseEvent());
     tabController=TabController(length: 4, vsync: this);
     tabController!.addListener((){
       setState(() {

       });
     });
  }


FirebaseFirestore mFirebaseFireStore=FirebaseFirestore.instance;
TabController? tabController;
DateFormat mTodayFormat=DateFormat().add_Hms();
DateFormat mFormat=DateFormat().add_yMMMd();
List<DateWiseExpModel> listDateWiseExp=[];
List<MonthWiseExpModel> listMonthWiseExp=[];
List<YearWiseExpModel> listYearWiseExp=[];
List<WeekWiseExpModel> listWeekWiseExpModel=[];

static  List listMonth=["Jan","Feb","March","April",'May',"June","July","Aug","Sep","Oct","Nov","Dec"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body:
    // BlocBuilder<ExpenseBloc,ExpenseState>(builder: (context,state){
    //   if(state is ExpenseLoadingState){
    //     return Center(child: CircularProgressIndicator());
    //   } else if(state is ExpenseLoadedState){
    //     return ListView.builder(itemBuilder: (context,index){
    //       return ListTile();
    //     });
    //   } else if(state is ExpenseErrorState){
    //     return Center(child: Text(state.errorMsg));
    //   }
    //   return Container();
    // }),

    StreamBuilder(
    stream: mFirebaseFireStore.collection("expenses").snapshots(),
    builder: (context,snapshot){
      if(snapshot.connectionState == ConnectionState.waiting){
    return Center(child: CircularProgressIndicator());
      }
      else if(snapshot.connectionState==ConnectionState.active){
    if(snapshot.hasData){
      List<ExpenseModel> mExpenses=[];
      for(QueryDocumentSnapshot<Map<String,dynamic>> eachDoc in snapshot.data!.docs){
        mExpenses.add(ExpenseModel.fromMap(eachDoc.data()));
      }
      filterDateWiseExp(mExpenses);
      filterMonthWiseExp(mExpenses);
      filterWeekWiseExp(mExpenses);
      var mData= snapshot.data!.docs;

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage("assets/images/childNew.png"),
              ),
              Container(),
              Icon(Icons.notification_important,color: Colors.deepPurple,),
            ],
          ),
          Center(
              child: Text("Account Balance",style: mTextStyle12(mColor: AppColors.incomeColor),)),
          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.currency_rupee,size: 30,),
              Text("38000",style: mTextStyle30(),),
            ],
          ),
          SizedBox(height: 15,),
          Row(children: [
            SizedBox(
              width: MediaQuery.of(context).size.width*0.46,
              child: mFetchContainer(
                mColor: Colors.green,mType: "Income",mValue: "\u{20B9} 50000" ),
            ),
            SizedBox(width: 10,),
            SizedBox(
              width: MediaQuery.of(context).size.width*0.46,
              child: mFetchContainer(
                mColor: Colors.red,mType: "Expenses ",mValue: "\u{20B9} 12000"),
            ),
          ],),
          SizedBox(height: 20,),
          Container(
            child:TabBar(
              controller: tabController,
              indicator: BoxDecoration(), // hides underline
              labelPadding: EdgeInsets.zero,
                overlayColor: MaterialStateProperty.all(Colors.transparent),
              tabs: List.generate(4, (index) {
                final isSelected = tabController!.index == index;
                final titles = ["Today","Week","Month","Year"];
                return Container(
                  height: 25,width: 70,
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.amber.shade400 : Colors.transparent,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    titles[index],
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                );
              }),
            ),
          ),
          Container(
            height: 10,
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Recent Transaction",style: mTextStyle14(),),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.grey.shade300
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("See All",style: mTextStyle12(),),
                  ),
                ),
              ],
            ),
          ),
         Expanded(
           child: TabBarView(
             controller: tabController,
             children: [
               ListView.builder(
                 itemCount: listMonthWiseExp.length,
                 itemBuilder: (context, index) {
                   return Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: listMonthWiseExp[index].expenses.map((expense) {
                       return ListTile(
                         leading: Container(
                           width: 50,height: 50,

                           child: Padding(
                             padding: const EdgeInsets.all(12.0),
                             child: Image.asset(AppConstants.mCategories.where((each)=>each.id==int.parse(expense.cat_value!)).toList()[0].imgURL ?? "",height: 30,width: 30,fit: BoxFit.fill,
                             ),
                           ),
                           decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(10),
                             color: Colors.primaries[Random().nextInt(Colors.primaries.length-1)].shade100,
                           ),),
                         title: Text(expense.expense_type ?? "",style: mTextStyle12(),),
                         subtitle: Text(expense.expense_desc ?? "",style: mTextStyle12(mColor: Colors.grey) )  ,
                         trailing: Column(
                           children: [
                             Text('-\u{20B9}${expense.expense_amount}',style: mTextStyle12(mColor: Colors.red),),
                           //  Text(mFormat.format(DateTime.fromMillisecondsSinceEpoch(int.parse(listDateWiseExp[index].date))),style: mTextStyle12(mColor: Colors.grey),)
                           ],
                         ),
                       );
                     }).toList(),
                   );
                 },
               ),
               ListView.builder(
                 itemCount: listWeekWiseExpModel.length,
                 itemBuilder: (context, index) {
                   final weekData = listWeekWiseExpModel[index];
                   return ExpansionTile(
                     title: Text("${weekData.weekLabel} - ₹${weekData.totalAmount}", style: mTextStyle14()),
                     children: weekData.expenses.map((eachData) {
                       return ListTile(
                         leading: Container(
                           width: 50,
                           height: 50,
                           decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(10),
                             color: Colors.primaries[Random().nextInt(Colors.primaries.length)].shade100,
                           ),
                           child: Padding(
                             padding: const EdgeInsets.all(12.0),
                             child: Image.asset(
                               AppConstants.mCategories.where((each) => each.id == int.parse(eachData.cat_value!)).first.imgURL ?? "",
                               height: 30,
                               width: 30,
                               fit: BoxFit.fill,
                             ),
                           ),
                         ),
                         title: Text(AppConstants.mCategories[int.parse(eachData.cat_value!) - 1].name! ?? "", style: mTextStyle12()),
                         subtitle: Text(eachData.expense_desc! ?? "", style: mTextStyle12(mColor: Colors.grey)),
                         trailing: Column(
                           crossAxisAlignment: CrossAxisAlignment.end,
                           children: [
                             Text('-\u{20B9}${eachData.expense_amount}', style: mTextStyle12(mColor: Colors.red)),
                             Text(mTodayFormat.format(DateTime.fromMillisecondsSinceEpoch(int.parse(eachData.expense_createdAt!))), style: mTextStyle12(mColor: Colors.grey)),
                           ],
                         ),
                       );
                     }).toList(),
                   );
                 },
               ),
               ListView.builder(
                   shrinkWrap: true,
                   physics: NeverScrollableScrollPhysics(),
                   itemCount: listMonthWiseExp.length,
                   itemBuilder: (context,index){
                   //  var eachData=ExpenseModel.fromMap(mData[index].data());
                     return Column(
                       children: listMonthWiseExp[index].expenses.map((expense){
                       return ListTile(
                           leading: Container(
                             width: 50,height: 50,
                             child: Padding(
                               padding: const EdgeInsets.all(12.0),
                               child: Image.asset(AppConstants.mCategories.where((each)=>each.id==int.parse(expense.cat_value!)).toList()[0].imgURL ?? "",height: 30,width: 30,fit: BoxFit.fill,
                               ),
                             ),
                             decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(10),
                               color: Colors.primaries[Random().nextInt(Colors.primaries.length-1)].shade100,
                             ),),
                           title: Text(AppConstants.mCategories[int.parse(expense.cat_value!)-1].name! ?? "",style: mTextStyle12(),),
                           subtitle: Text(expense.expense_desc! ?? "",style: mTextStyle12(mColor: Colors.grey) )  ,
                           trailing: Column(
                             children: [
                               Text('-\u{20B9}${expense.expense_amount}',style: mTextStyle12(mColor: Colors.red),),
                            //  Text(listMonthWiseExp[index].month)));,style: mTextStyle12(mColor: Colors.grey)

                             ],
                           ),
                         );
                       }).toList()
                     );
                   }),
               ListView.builder(
                   shrinkWrap: true,
                   physics: NeverScrollableScrollPhysics(),
                   itemCount: mData.length,
                   itemBuilder: (context,index){
                     var eachData=ExpenseModel.fromMap(mData[index].data());
                     return ListTile(
                       leading: Container(
                         width: 50,height: 50,

                         child: Padding(
                           padding: const EdgeInsets.all(12.0),
                           child: Image.asset(AppConstants.mCategories.where((each)=>each.id==int.parse(eachData.cat_value!)).toList()[0].imgURL ?? "",height: 30,width: 30,fit: BoxFit.fill,
                           ),
                         ),
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(10),
                           color: Colors.primaries[Random().nextInt(Colors.primaries.length-1)].shade100,
                         ),),
                       title: Text(AppConstants.mCategories[int.parse(eachData.cat_value!)-1].name! ?? "",style: mTextStyle12(),),
                       subtitle: Text(eachData.expense_desc! ?? "",style: mTextStyle12(mColor: Colors.grey) )  ,
                       trailing: Column(
                         children: [
                           Text('-\u{20B9}${eachData.expense_amount}',style: mTextStyle12(mColor: Colors.red),),
                           Text(mTodayFormat.format(DateTime.fromMillisecondsSinceEpoch(int.parse(eachData.expense_createdAt!))),style: mTextStyle12(mColor: Colors.grey),)
                         ],
                       ),
                     );
                   }),
             ],
           ),
        )


        ],
      ),
    );
    }
    if(snapshot.hasError){
      return Center(child: Text("Error Coccured"));
    };
      }
      return Container();
    }),

    );
  }
void filterDateWiseExp(List<ExpenseModel> allExpenses) {
  listDateWiseExp.clear();

  List<String> uniqueDates = [];
  for(ExpenseModel eachExp in allExpenses) {
    String date = mFormat.format(DateTime.fromMillisecondsSinceEpoch(int.parse(eachExp.expense_createdAt!)));
    if(!uniqueDates.contains(date)){
      uniqueDates.add(date);
    }
  }
  print(uniqueDates);

  for(String eachDate in uniqueDates){
    num eachDayAmt=0.0;
    List<ExpenseModel> eachDayExpense=[];
    for(ExpenseModel eachExpenses in allExpenses) {
      String date=mFormat.format(DateTime.fromMillisecondsSinceEpoch(int.parse(eachExpenses.expense_createdAt!)));
      if(date==eachDate){
        eachDayExpense.add(eachExpenses);
        if(eachExpenses.expense_type=="Debit"){
          eachDayAmt-= eachExpenses.expense_amount!;
        } else{
          eachDayAmt+= eachExpenses.expense_amount!;
        }
      }

    }
    listDateWiseExp.add(DateWiseExpModel(date: eachDate, totalAmt: eachDayAmt, expenses: eachDayExpense));

  }
  print(listDateWiseExp);


}
 void filterMonthWiseExp(List<ExpenseModel> allExpenses) {
  listMonthWiseExp.clear();
  List<String> uniqueMonths = [];
  for(ExpenseModel eachExp in allExpenses) {
    DateTime mdate=DateTime.fromMillisecondsSinceEpoch(int.parse(eachExp.expense_createdAt!));
    String month=("${listMonth[mdate.month-1]},${mdate.year}");
    if(!uniqueMonths.contains(month)){
      uniqueMonths.add(month);
    }
  }
  print(uniqueMonths);

  for(String eachMonth in uniqueMonths){
    num eachMonthAmt=0.0;
    List<ExpenseModel> eachMonthExpense=[];


    for(ExpenseModel eachExpenses in allExpenses) {
      DateTime mdate=DateTime.fromMillisecondsSinceEpoch(int.parse(eachExpenses.expense_createdAt!));
      String month=("${listMonth[mdate.month-1]},${mdate.year}");

      if(eachMonth==month){
        eachMonthExpense.add(eachExpenses);
        if(eachExpenses.expense_type=="Debit"){
          eachMonthAmt-= eachExpenses.expense_amount!;
        } else{
          eachMonthAmt+= eachExpenses.expense_amount!;
        }
      }

    }
    listMonthWiseExp.add(MonthWiseExpModel(month: eachMonth, totalAmount: eachMonthAmt, expenses: eachMonthExpense));

  }
  print(listMonthWiseExp);


}
void filterYearWiseExp(List<ExpenseModel> allExpenses){

}
void filterWeekWiseExp(List<ExpenseModel> allExpenses) {
  listWeekWiseExpModel.clear();
  Map<String, List<ExpenseModel>> weekGroups = {};

  for (var expense in allExpenses) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(int.parse(expense.expense_createdAt!));
    int weekOfYear = ((date.dayOfYear - date.weekday + 10) / 7).floor(); // ISO week
    String weekLabel = "Week $weekOfYear, ${date.year}";

    if (!weekGroups.containsKey(weekLabel)) {
      weekGroups[weekLabel] = [];
    }
    weekGroups[weekLabel]!.add(expense);
  }

  weekGroups.forEach((week, exps) {
    num total = 0;
    for (var e in exps) {
      if (e.expense_type == "Debit") {
        total -= e.expense_amount!;
      } else {
        total += e.expense_amount!;
      }
    }

    listWeekWiseExpModel.add(WeekWiseExpModel(
      weekLabel: week,
      totalAmount: total,
      expenses: exps,
    ));
  });

  print(listWeekWiseExpModel.map((e) => "${e.weekLabel}: ₹${e.totalAmount}").toList());
}

}
extension DateHelper on DateTime {
  int get dayOfYear {
    return int.parse(DateFormat("D").format(this));
  }
}