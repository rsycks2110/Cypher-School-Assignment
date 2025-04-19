import 'package:expense_app_using_bloc/data/local/expense_database.dart';
import 'package:expense_app_using_bloc/ui/home/bloc/home_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent,HomeState>{
  DataBaseHelper db;
  HomeBloc({required this.db}):super(HomeInitialState());

}
