import 'package:expense_app_using_bloc/data/model/expense_model.dart';

class DateWiseExpModel {
  String date;
  num totalAmt;
  List<ExpenseModel> expenses;

  DateWiseExpModel(
      {required this.date, required this.totalAmt, required this.expenses});


}
class MonthWiseExpModel {
  String month;
  num totalAmount;
  List<ExpenseModel> expenses;
  MonthWiseExpModel({required this.month,required this.totalAmount,required this.expenses});
}

class YearWiseExpModel{
  String year;
  num totalAmount;
  List<ExpenseModel> expenses;
  YearWiseExpModel({required this.year,required this.totalAmount,required this.expenses});

}
class WeekWiseExpModel{
  String week;
  num totalAmount;
  List<ExpenseModel> expenses;
  WeekWiseExpModel({required this.week,required this.totalAmount,required this.expenses});
}