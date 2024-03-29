import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/components/components.dart';
import '../../../shared/cubit/cubit.dart';
import '../../../shared/cubit/states.dart';

class DoneTasksScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<AppCubit,AppStates>(

        listener:(context,state){},
        builder:(context,state){
          var tasks=AppCubit.get(context).doneTasks;
          child:
          return ListView.separated(
              itemBuilder: ( context , index)=>buildTaskItem(tasks[index],context),
              separatorBuilder:( context , index)=> Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey[300],
              ),
              itemCount: tasks.length
          );
        }

    );
  }
}
