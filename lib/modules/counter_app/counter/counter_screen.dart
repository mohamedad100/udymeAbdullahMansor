import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/modules/counter_app/counter/cubit/cubit.dart';
import 'package:untitled/modules/counter_app/counter/cubit/states.dart';

class CounterScreen extends StatelessWidget {


  // 1.constructor
  // 2.init state
  // 3.build

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (BuildContext context) =>CounterCubit(),
      child: BlocConsumer<CounterCubit,CounterStates>
        (
        listener:(context,state) {},
        builder:(context,state){
          return Scaffold(
            appBar: AppBar(
              title: Text(
                  'Counter'
              ),
            ),
            body: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(onPressed: () {

                   CounterCubit.get(context).minus();


                  },
                      child:Text('MINUS')),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      '${CounterCubit.get(context).counter}',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 50,
                      ),

                    ),
                  ),
                  TextButton(onPressed: () {

                    CounterCubit.get(context).plus();

                  },
                      child:Text('PLUS')),
                ],
              ),
            ),
          );
        } ,
      ),
    );
  }
}

