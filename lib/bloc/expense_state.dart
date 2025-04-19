import '../../data/model/expense_model.dart';

abstract class ExpenseState{}
class ExpenseInitialState extends ExpenseState{

}
class ExpenseLoadingState extends ExpenseState{
}
class ExpenseLoadedState extends ExpenseState{
  List<ExpenseModel> mExpense;
  ExpenseLoadedState({required this.mExpense});
}
class ExpenseErrorState extends ExpenseState{
  String errorMsg;
  ExpenseErrorState({required this.errorMsg});
}