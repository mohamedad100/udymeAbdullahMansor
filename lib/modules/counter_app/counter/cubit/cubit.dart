
import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/modules/counter_app/counter/cubit/states.dart';

class CounterCubit extends Cubit<CounterStates>{

  CounterCubit():super(CounterInitialState());

  static CounterCubit get(context) =>BlocProvider.of(context);
  int counter = 1;

  void minus(){
    counter --;

    emit(CounterMinusState());
  }

  void plus(){
    counter ++;

    emit(CounterPlusState());
  }



}