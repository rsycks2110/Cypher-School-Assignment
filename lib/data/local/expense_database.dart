import 'package:expense_app_using_bloc/data/model/expense_model.dart';
import 'package:expense_app_using_bloc/data/model/income_model.dart';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseHelper {

  DataBaseHelper._();
  static final DataBaseHelper db = DataBaseHelper._();

  Database? mdb ;

  // Login Page Keys
  static const String  Expense_DataBase = "expense.db";
  static const String  Login_Table = "login_table";
  static const String   User_ID= "user_id";
  static const String  Login_Table_First_Name = "first_name";
  static const String  Login_Table_Last_Name = "last_name";
  static const String  Login_Table_UserName = "user_name";
  static const String  Login_Table_Mobile = "mobile_number";
  static const String  Login_Table_Email = "email";
  static const String  Login_Table_Password = "password";
  static const String  Login_Table_RePassword = "retype_password";

  // Expense keys
  static const String Expense_Table = "expense_table";
  static const String Expense_Table_ID = "expense_id";
  static const String Expense_Table_Cat_ID = "cat_id";
  static const String Expense_Table_Title = "expense_title";
  static const String Expense_Table_Desc = "expense_desc";
  static const String Expense_Table_Amount = "expense_amount";
  static const String Expense_Table_Type = "expense_type";
  static const String Expense_Table_CreatedAt = "expense_createdAt";
  //
  //Income keys
  static const String Income_Table = "income_table";
  static const String Income_Table_ID = "income_id";
  static const String Income_Table_Cat_ID = "cat_id";
  static const String Income_Table_Title = "income_title";
  static const String Income_Table_Desc = "income_desc";
  static const String Income_Table_Amount = "income_amount";
  static const String Income_Table_Type = "income_type";
  static const String Income_Table_CreatedAt = "income_createdAt";


  Future<Database> getDB() async{
    if(mdb!=null){
      return mdb!;
    } else{
      return await OpenDB();
    }
  }
  Future<Database> OpenDB() async {
    var rootPath= await getApplicationDocumentsDirectory();
    var dbPath = join(rootPath.path,Expense_DataBase);
    return  await  openDatabase(dbPath,version: 1,onCreate: (db,version){
      db.execute(
          "create table $Login_Table ( $User_ID integer primary key autoincrement , $Login_Table_First_Name text , $Login_Table_Last_Name text "
              ", $Login_Table_UserName text , $Login_Table_Mobile integer ,"" $Login_Table_Email text unique , $Login_Table_Password"
              " text , $Login_Table_RePassword text)"
      );
      db.execute(
          "create table $Expense_Table ("
              "$Expense_Table_ID integer primary key autoincrement,""$User_ID integer ,"
              "$Expense_Table_Cat_ID integer ,"
              "$Expense_Table_Title text ,"
              "$Expense_Table_Desc text,"
              "$Expense_Table_Type text"
              "$Expense_Table_Amount integer,"
              "$Expense_Table_CreatedAt text)   "
      );
      db.execute(
          "create table $Income_Table ("
              "$Income_Table_ID integer primary key autoincrement,""$User_ID integer ,"
              "$Income_Table_Cat_ID integer ,"
              "$Income_Table_Title text ,"
              "$Income_Table_Desc text,"
              "$Income_Table_Type text"
              "$Income_Table_Amount integer,"
              "$Income_Table_CreatedAt text)   "
      );
    });
  }
  // Future<bool> userSignUp({required UserModel newUser}) async {
  //   var database = await getDB();
  //   int check= await database.insert(Login_Table,newUser.toMap());
  //   return check>0;
  // }
  //
  // Future<bool> userLogin({required String email,required String password}) async{
  //
  //   var mainDataBase= await getDB();
  //
  //   // List<Map<String,dynamic>> data= await mainDataBase.query(Login_Table,where:"$User_ID","$Login_Table_Email=?" , "$Login_Table_Password=?",whereArgs:[email, password]);
  //   List<Map<String,dynamic>> data= await mainDataBase.rawQuery("Select User_ID, email , password From Login_Table");
  //   if(data.isNotEmpty) {
  //     var pref = await SharedPreferences.getInstance();
  //     pref.setInt(User_ID, data[0][User_ID]);
  //     //   pref.initPref();
  //     //   pref.setUser(id:data[0][User_ID]);
  //     //   print("$User_ID");
  //     // }
  //   }
  //   return data.isNotEmpty;
  // }

  Future<bool> addExpense({required ExpenseModel newExpense}) async{
    var mainDatabase = await getDB();
    var pref= await SharedPreferences.getInstance();
    newExpense.expense_id= pref.getString(User_ID);
    int rowsEffected= await mainDatabase.insert(Expense_Table, newExpense.toMap());
    return rowsEffected>0;
  }
  Future<bool> addIncome({required IncomeModel newIncome}) async{
    var mainDatabase = await getDB();
    var pref= await SharedPreferences.getInstance();
    newIncome.income_id= pref.getString(User_ID);
    int rowsEffected= await mainDatabase.insert(Expense_Table, newIncome.toMap());
    return rowsEffected>0;
  }
  Future<List<ExpenseModel>> fetchExpense() async{
    var mainDatabase= await getDB();
    // var pref=AppPref();
    // pref.initPref();
    var pref = await SharedPreferences.getInstance();
    int id= pref.getInt(User_ID)??0;
    List<Map<String,dynamic>> allExpense= await mainDatabase.query(Login_Table,where:"$User_ID=?",whereArgs:[id]);
    List<ExpenseModel> mExpense=[];
    for(Map<String,dynamic> eachExpense in allExpense){
      mExpense.add(ExpenseModel.fromMap(eachExpense));
    }
    return mExpense;
  }

// emailValidateEvent({required String email}) async {
//  var db= await getDB();
//  var data=db.query(Login_Table,where:"$Login_Table_Email:$email");
//  int check= data.isnotEmpty;
//  return check;
// }
}