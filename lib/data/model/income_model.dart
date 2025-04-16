

import 'package:expense_app_using_bloc/data/local/expense_database.dart';

 class IncomeModel{
  String? income_id;
  String? u_id;
  String? cat_value;
  String? income_desc;
  num? income_amount;
  String? income_createdAt;
  String? income_type;

  IncomeModel({ this.income_id, this.u_id,required this.cat_value,required this.income_desc,
    required this.income_createdAt,required this.income_type, required this.income_amount});

  factory IncomeModel.fromMap(Map<String,dynamic> map){
    return IncomeModel(
        income_id : map[DataBaseHelper.Income_Table_ID],
        u_id : map[DataBaseHelper.User_ID],
        cat_value : map[DataBaseHelper.Income_Table_Cat_ID],
        income_desc : map[DataBaseHelper.Income_Table_Desc],
        income_amount : map[DataBaseHelper.Income_Table_Amount],
        income_createdAt : map[DataBaseHelper.Income_Table_CreatedAt],
        income_type: map[DataBaseHelper.Income_Table_Type]
    );
  }

  Map<String,dynamic> toMap(){
    return {
      // DataBaseHelper.Expense_Table_ID: expense_id,
      DataBaseHelper.User_ID: u_id,
      DataBaseHelper.Income_Table_Cat_ID : cat_value,
      DataBaseHelper.Income_Table_Desc : income_desc,
      DataBaseHelper.Income_Table_Amount : income_amount,
      DataBaseHelper.Income_Table_CreatedAt : income_createdAt,
      DataBaseHelper.Income_Table_Type : income_type
    };
  }






}