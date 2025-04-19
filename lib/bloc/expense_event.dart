import '../../data/model/expense_model.dart';

abstract class ExpenseEvent {}
class AddExpenseEvent extends ExpenseEvent{
  ExpenseModel newExpense;
  AddExpenseEvent({required this.newExpense});
}
class FetchExpenseEvent extends ExpenseEvent{
}
class UpdateExpenseEvent extends ExpenseEvent{
  ExpenseModel newExpense;
  UpdateExpenseEvent({required this.newExpense});
}
class DeleteExpenseEvent extends ExpenseEvent{
  String expenseId;
  DeleteExpenseEvent({required this.expenseId});
}