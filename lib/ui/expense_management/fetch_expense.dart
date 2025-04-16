import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_app_using_bloc/data/firebase/firebase_repository.dart';
import 'package:expense_app_using_bloc/data/model/date_wise_expense_model.dart';
import 'package:expense_app_using_bloc/data/model/expense_model.dart';
import 'package:expense_app_using_bloc/ui/widgets/app_widgts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
     tabController=TabController(length: 4, vsync: this);
     tabController!.addListener((){
       setState(() {

       });
     });
  }

FirebaseFirestore mFirebaseFireStore=FirebaseFirestore.instance;
TabController? tabController;
DateFormat mTodayFormat=DateFormat().add_Hms();
List<DateWiseExpModel> listDateWiseExp=[];
List<MonthWiseExpModel> listMonthWiseExp=[];
List<YearWiseExpModel> listYearWiseExp=[];
List<WeekWiseExpModel> listWeekWiseExpModel=[];
List<ExpenseModel> mExpenses=[];
static  List listMonth=["Jan","Feb","March","April",'May',"June","July","Aug","Sep","Oct","Nov","Dec"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: StreamBuilder(
    stream: mFirebaseFireStore.collection("expenses").snapshots(),
    builder: (context,snapshot){
      if(snapshot.connectionState == ConnectionState.waiting){
    return Center(child: CircularProgressIndicator());
      }
      else if(snapshot.connectionState==ConnectionState.active){
    if(snapshot.hasData){
      filterDateWiseExp(mExpenses);
      filterMonthWiseExp(mExpenses);


      for(QueryDocumentSnapshot<Map<String,dynamic>> eachDoc in snapshot.data!.docs){
        mExpenses.add(ExpenseModel.fromMap(eachDoc.data()));
      }
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
          Row(children: [
            SizedBox(
              width: MediaQuery.of(context).size.width*0.46,
              child: mFetchContainer(
                mColor: Colors.green,mType: "Income 50000", ),
            ),
            SizedBox(width: 10,),
            SizedBox(
              width: MediaQuery.of(context).size.width*0.46,
              child: mFetchContainer(
                mColor: Colors.red,mType: "Expenses 12000",),
            ),
          ],),
          SizedBox(height: 10,),
          Container(
            child:TabBar(
              controller: tabController,
              indicator: BoxDecoration(), // hides underline
              labelPadding: EdgeInsets.zero,
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
            // TabBar(
            //     unselectedLabelColor: Colors.grey,
            //     indicatorColor:Colors.transparent ,
            //     indicator: UnderlineTabIndicator(borderSide: BorderSide(color: Colors.transparent,width: 0)),
            //     tabs: [
            //   Tab(
            //     child: Container(
            //       height: 30,width: 70,
            //       decoration: BoxDecoration(
            //         color: isSelected? Colors.transparent:Colors.amber.shade400,
            //         borderRadius: BorderRadius.circular(10),
            //       ),
            //       child: Center(child: Text("Today",style: mTextStyle12(mColor: Colors.grey),)),
            //     ),
            //   ),
            //       Tab(
            //         child: Container(
            //           height: 30,width: 70,
            //           decoration: BoxDecoration(
            //             color: isSelected? Colors.transparent:Colors.amber.shade400,
            //             borderRadius: BorderRadius.circular(10),
            //           ),
            //           child: Center(child: Text("Week",style: mTextStyle12(mColor: Colors.grey))),
            //         ),
            //       ),
            //       Tab(
            //         child: Container(
            //           height: 30,width: 70,
            //           decoration: BoxDecoration(
            //             color: isSelected? Colors.transparent:Colors.amber.shade400,
            //             borderRadius: BorderRadius.circular(10),
            //           ),
            //           child: Center(child: Text("Month",style: mTextStyle12(mColor: Colors.grey))),
            //         ),
            //       ),
            //       Tab(
            //         child: Container(
            //           height: 30,width: 70,
            //           decoration: BoxDecoration(
            //             color: isSelected? Colors.transparent:Colors.amber.shade400,
            //             borderRadius: BorderRadius.circular(10),
            //           ),
            //           child: Center(child: Text("Year",style: mTextStyle12(mColor: Colors.grey))),
            //         ),
            //       ),
            // ]),
          ),
          Container(
            height: 20,
          ),

          Row(
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
         Expanded(
           child: TabBarView(
             controller: tabController,
             children: [
               ListView.builder(
                   shrinkWrap: true,
                   physics: NeverScrollableScrollPhysics(),
                   itemCount: mData.length,
                   itemBuilder: (context,index){
                     var eachData=ExpenseModel.fromMap(mData[index].data());
                     return ListTile(
                       leading: Container(
                         width: 40,height: 40,
                         // child: Image.asset(AppConstants.mCategories.where((element) => element.id==).toList()[0].imgURL!),
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(10),
                           color: Colors.grey.shade200,
                         ),),
                       title: Text(eachData.cat_value!,style: mTextStyle12(),),
                       subtitle: Text(eachData.expense_desc!,style: mTextStyle12(mColor: Colors.grey),),
                       trailing: Column(
                         children: [
                           Text('-\u{20B9}${eachData.expense_amount}',style: mTextStyle12(mColor: Colors.red),),
                           Text(mTodayFormat.format(DateTime.fromMillisecondsSinceEpoch(int.parse(eachData.expense_createdAt!))),style: mTextStyle12(mColor: Colors.grey),)
                         ],
                       ),
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
                         width: 40,height: 40,
                         child: Image.asset(""),
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(10),
                           color: Colors.grey.shade200,
                         ),),
                       title: Text(eachData.cat_value!,style: mTextStyle12(),),
                       subtitle: Text(eachData.expense_desc!,style: mTextStyle12(mColor: Colors.grey),),
                       trailing: Column(
                         children: [
                           Text('-\u{20B9}${eachData.expense_amount}',style: mTextStyle12(mColor: Colors.red),),
                           Text(mTodayFormat.format(DateTime.fromMillisecondsSinceEpoch(int.parse(eachData.expense_createdAt!))),style: mTextStyle12(mColor: Colors.grey),)
                         ],
                       ),
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
                         width: 40,height: 40,
                         child: Image.asset(""),
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(10),
                           color: Colors.grey.shade200,
                         ),),
                       title: Text(eachData.cat_value!,style: mTextStyle12(),),
                       subtitle: Text(eachData.expense_desc!,style: mTextStyle12(mColor: Colors.grey),),
                       trailing: Column(
                         children: [
                           Text('-\u{20B9}${eachData.expense_amount}',style: mTextStyle12(mColor: Colors.red),),
                           Text(mTodayFormat.format(DateTime.fromMillisecondsSinceEpoch(int.parse(eachData.expense_createdAt!))),style: mTextStyle12(mColor: Colors.grey),)
                         ],
                       ),
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
                         width: 40,height: 40,
                         child: Image.asset(""),
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(10),
                           color: Colors.grey.shade200,
                         ),),
                       title: Text(eachData.cat_value!,style: mTextStyle12(),),
                       subtitle: Text(eachData.expense_desc!,style: mTextStyle12(mColor: Colors.grey),),
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

    String date = mTodayFormat.format(DateTime.fromMillisecondsSinceEpoch(int.parse(eachExp.expense_createdAt!)));
    if(!uniqueDates.contains(date)){
      uniqueDates.add(date);
    }
  }
  print(uniqueDates);

  for(String eachDate in uniqueDates){
    num eachDayAmt=0.0;
    List<ExpenseModel> eachDayExpense=[];
    for(ExpenseModel eachExpenses in allExpenses) {
      String date=mTodayFormat.format(DateTime.fromMillisecondsSinceEpoch(int.parse(eachExpenses.expense_createdAt!)));
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
}
