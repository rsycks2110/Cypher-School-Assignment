import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_app_using_bloc/data/model/income_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/expense_model.dart';

class FireBaseRepository{
static FirebaseFirestore mFirebaseFireStore = FirebaseFirestore.instance;
  static const String collectionReference = "expenses";
  static const String collectionReference2="income";

 static addExpense(ExpenseModel newExpense) async{
   mFirebaseFireStore.collection(collectionReference).add(newExpense.toMap()).then((value) async {
         return mFirebaseFireStore.collection(collectionReference).doc(value.id).update({"u_id":value.id});
    });
  }
static addIncome(IncomeModel newIncome) async{
  mFirebaseFireStore.collection(collectionReference2).add(newIncome.toMap()).then((value) async {
    return mFirebaseFireStore.collection(collectionReference2).doc(value.id).update({"u_id":value.id});
  });
}
  static Future<void> updateExpense(ExpenseModel updateExpense) async{
  await mFirebaseFireStore.collection(collectionReference).doc(updateExpense.expense_id).update(updateExpense.toMap());
  }
 static Future<void> deleteExpense(ExpenseModel deleteExpense) async{
  await mFirebaseFireStore.collection(collectionReference).doc(deleteExpense.expense_id).delete();
 }
  static Stream<QuerySnapshot<Map<String, dynamic>>>  fetchExpense(ExpenseModel allExpense) {
  return mFirebaseFireStore.collection(collectionReference).snapshots()!;
  }



}
