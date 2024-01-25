import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:untitled/modules/todo_app/archived_tasks/archived_tasks_screen.dart';
import 'package:untitled/modules/todo_app/done_tasks/done_tasks_screen.dart';
import 'package:untitled/modules/todo_app/new_tasks/new_tasks_screen.dart';
import 'package:untitled/shared/components/components.dart';
import 'package:untitled/shared/cubit/cubit.dart';
import 'package:untitled/shared/cubit/states.dart';

import '../../shared/components/constants.dart';
//1.Create database
//2.Create tables
//3.open database
//4.insert to database
//5.get from database
//6.update in database
//7.delete from database

class HomeLayout extends StatelessWidget  {


  var scaffoldKey =GlobalKey<ScaffoldState>();
  var formKey =GlobalKey<FormState>();



  var titleController=TextEditingController();
  var timeController=TextEditingController();
  var dateController=TextEditingController();

  HomeLayout({super.key});




  @override
  Widget build(BuildContext context) {
    return BlocProvider(

      create: (BuildContext context) => AppCubit()..createDatabase()  ,

      child: BlocConsumer<AppCubit,AppStates>(
        listener: (BuildContext context, AppStates state) {
          if(state is AppInsertDatabaseState){
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context, AppStates state) {
          AppCubit cubit =AppCubit.get(context);
          return Scaffold (
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(
                  cubit.titles[cubit.currentIndex]
              ),
            ),
            body: ConditionalBuilder(
              condition: state is !AppGetDatabaseLoadingState,
              builder:(context)=>  cubit.screens[cubit.currentIndex],
              fallback: (context)=>CircularProgressIndicator(),
            ),
            floatingActionButton: FloatingActionButton(

              onPressed: ()  {

                if(cubit.isBottomSheetShown){

                  if(formKey.currentState!.validate())
                  {

                    cubit.insertToDatabase(title: titleController.text, time: timeController.text, date: dateController.text);
                    // insertToDatabase(
                    //   title:titleController.text ,
                    //   time: timeController.text,
                    //   date: dateController.text,
                    // ).then((value) {
                    //
                    //   gitDataFromDatabase(database).then((value) {
                    //     Navigator.pop(context);
                    //
                    //     //   setState(() {
                    //     //    tasks=value;
                    //     //    print(tasks);
                    //
                    //     //    isBottomSheetShown=false;
                    //
                    //     //    fabIcon=Icons.edit;
                    //     //  });
                    //
                    //
                    //
                    //
                    //   });
                    // });

                  }


                }
                else{
                  scaffoldKey.currentState?.showBottomSheet((context) =>
                      Container(
                        color: Colors.grey[200],
                        padding: const EdgeInsets.all(20.0),

                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,

                            children: [
                              defultFormField(
                                  controller: titleController,
                                  type: TextInputType.text,
                                  validate: (value){
                                    if(value==null || value.isEmpty){
                                      return 'title must not be empty';

                                    }
                                    return null;
                                  },
                                  label: 'Task Title',
                                  prefix: Icons.title
                              ),
                              SizedBox(
                                height: 20,
                              ),

                              defultFormField(
                                  controller: timeController,
                                  type: TextInputType.datetime,
                                  validate: (value){
                                    if(value==null || value.isEmpty){
                                      return 'time must not be empty';

                                    }
                                    return null;
                                  },
                                  label: 'Task Time',
                                  prefix: Icons.watch_later_outlined,
                                  onTap:(){
                                    showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    ).then((value) {
                                      timeController.text=value!.format(context);
                                      print(value.format(context));
                                    });
                                  }
                              ),
                              SizedBox(
                                height: 15,
                              ),

                              defultFormField(
                                  controller: dateController,
                                  type: TextInputType.datetime,
                                  validate: (value){
                                    if(value==null || value.isEmpty){
                                      return 'date must not be empty';

                                    }
                                    return null;
                                  },
                                  label: 'Task date',
                                  prefix: Icons.calendar_month,
                                  onTap:(){
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate:  DateTime.now(),
                                      lastDate: DateTime.parse('2024-4-3') ,
                                    ).then((value) {

                                      print(DateFormat.yMMMd().format(value!));

                                      dateController.text=DateFormat.yMMMd().format(value);

                                    });

                                  }
                              ),

                            ],
                          ),
                        ),
                      ) ).closed.then((value) {
                        cubit.changeBottomCheatState(isShow: false, icon: Icons.edit);


                  });

                  cubit.changeBottomCheatState(isShow: true, icon: Icons.add);



                }



              },

              child: Icon(cubit.fabIcon),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.currentIndex,
              onTap: (index){

                cubit.ChangeIndex( index);

              },


              items: [
                BottomNavigationBarItem(icon: Icon(
                    Icons.menu
                ),
                    label: 'Task'
                ),
                BottomNavigationBarItem(
                    icon: Icon(
                        Icons.check_circle_outline
                    ),
                    label: 'Done'
                ),
                BottomNavigationBarItem(
                    icon: Icon(
                        Icons.archive_outlined
                    ),
                    label: 'Archived'
                ),
              ],
            ),
          );
        },


      ),
    );
  }


 // Future<String> getName() async     //async بتفتح طريق للباك جروند عشان تشتغل فيه عن المين
 //     {
 //   return 'Mohamed adel';             // Future<String>   معناها انه ها يجي من قاعده البيانات فلمستقبل عشان بتاخد وقت
 // }


}


