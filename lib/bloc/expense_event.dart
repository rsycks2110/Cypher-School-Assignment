import '../../data/model/expense_model.dart';

abstract class ExpenseEvent {}
class AddExpenseEvent extends ExpenseEvent{
  ExpenseModel newExpense;
  AddExpenseEvent({required this.newExpense});
}
class FetchExpenseEvent extends ExpenseEvent{
  String userId;
  FetchExpenseEvent({required this.userId});
}
