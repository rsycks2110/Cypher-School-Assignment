import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_app_using_bloc/data/firebase/firebase_repository.dart';
import 'package:expense_app_using_bloc/data/model/expense_model.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/local/expense_database.dart';
import 'expense_event.dart';
import 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent,ExpenseState>{

  DataBaseHelper db;
  ExpenseBloc({required this.db}):super(ExpenseInitialState()){
  on<AddExpenseEvent> ((event, emit) async {
    emit(ExpenseLoadingState());

    bool check = await db.addExpense(newExpense: event.newExpense);
    if (check) {
      List<ExpenseModel> allExpense = await db.fetchExpense();
      emit(ExpenseLoadedState(mExpense:allExpense ));
    } else{
      emit(ExpenseErrorState(errormsg: "Expense Not Added"));
      }
  }
  );
  on<FetchExpenseEvent>((event,emit) async{
    emit(ExpenseLoadingState());
    List<ExpenseModel> allExpense = await db.fetchExpense();
    emit(ExpenseLoadedState(mExpense: allExpense));
  });

  }


}
