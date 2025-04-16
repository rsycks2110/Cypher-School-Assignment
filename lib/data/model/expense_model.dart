

import 'package:expense_app_using_bloc/data/local/expense_database.dart';

class ExpenseModel{
  String? expense_id;
  String? u_id;
  String? cat_value;
  String? expense_desc;
  num? expense_amount;
  String? expense_createdAt;
  String? expense_type;

  ExpenseModel({ this.expense_id, this.u_id,required this.cat_value,required this.expense_desc,
    required this.expense_createdAt,required this.expense_type, required this.expense_amount});

  factory ExpenseModel.fromMap(Map<String,dynamic> map){
    return ExpenseModel(
        expense_id : map[DataBaseHelper.Expense_Table_ID],
        u_id : map[DataBaseHelper.User_ID],
        cat_value : map[DataBaseHelper.Expense_Table_Cat_ID],
        expense_desc : map[DataBaseHelper.Expense_Table_Desc],
        expense_amount : map[DataBaseHelper.Expense_Table_Amount],
        expense_createdAt : map[DataBaseHelper.Expense_Table_CreatedAt],
        expense_type: map[DataBaseHelper.Expense_Table_Type]
    );
  }

  Map<String,dynamic> toMap(){
    return {
      // DataBaseHelper.Expense_Table_ID: expense_id,
      DataBaseHelper.User_ID: u_id,
      DataBaseHelper.Expense_Table_Cat_ID : cat_value,
      DataBaseHelper.Expense_Table_Desc : expense_desc,
      DataBaseHelper.Expense_Table_Amount : expense_amount,
      DataBaseHelper.Expense_Table_CreatedAt : expense_createdAt,
      DataBaseHelper.Expense_Table_Type : expense_type
    };
  }






}