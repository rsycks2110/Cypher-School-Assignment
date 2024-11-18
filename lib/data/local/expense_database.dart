import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
class DataBaseHelper {

  DataBaseHelper._();
  static final DataBaseHelper db = DataBaseHelper._();

  Database? mdb ;

  getDB() async{
    if(mdb!=null){
      return mdb;
    } else{
      return await OpenDB();
    }
  }
  OpenDB() async {
    var rootPath= await getApplicationDocumentsDirectory();
    var dbPath = join(rootPath.path,"exepnse.db");
    openDatabase(dbPath,version: 1,onCreate: (db,version){
      db.execute(
        "Create Table Expense ( )"
      );
    });
  }




}