
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:untitled/shared/cubit/states.dart';
import 'package:untitled/shared/network/local/cache_helper.dart';

import '../../modules/todo_app/archived_tasks/archived_tasks_screen.dart';
import '../../modules/todo_app/done_tasks/done_tasks_screen.dart';
import '../../modules/todo_app/new_tasks/new_tasks_screen.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit() : super(AppInitialStates());


  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex=0;
  List<Widget>screens=[
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen(),
  ];
  List<String>titles =[
    'New Tasks',
    'Archived Tasks',
    'Done Tasks',
  ];


 void ChangeIndex(int index){
   currentIndex=index;
   emit(AppChangeBottomNavigationBarStates());

 }

  Database? database;

  List<Map> newTasks =[];
  List<Map> doneTasks =[];
  List<Map> archivedTasks =[];


  bool isBottomSheetShown=false;
  IconData fabIcon= Icons.edit;



  void createDatabase()
  {
    database = openDatabase(
      'todo.db',
      version: 1,
      onCreate:(database,version)async{
        //id integer
        //title String
        //date String
        //time String
        //status String
        print('database created');

        await database.execute('CREATE TABLE tasks(id INTEGER PRIMARY KEY,title TEXT,date TEXT, time TEXT ,status TEXT ) ').then((value){
          print('table created');
        }).catchError((error){
          print('error when creating table ${error.toString()}');
        });

      },
      onOpen:(database){
        print('database opened');

        gitDataFromDatabase(database);
      },

    ).then((value) {
      database=value;
      emit(AppCreateDatabaseState());
    }) as Database?;
  }


   insertToDatabase({
    required String title,
    required String time,
    required String date,
  })async{

    await database?.transaction((txn)
    async{
      await txn.rawInsert('INSERT INTO tasks(title,date,time,status)VALUES("$title","$date","$time","new") ').then((value)
      {
        print(' $value inserted successfully');

        emit(AppInsertDatabaseState());

        gitDataFromDatabase(database);


      }).catchError((error){
        print('error when insert new record ${error.toString()}');

      });

    });

  }

  void gitDataFromDatabase(database)
  {

    newTasks=[];
    doneTasks=[];
    archivedTasks=[];

    emit(AppGetDatabaseLoadingState());

     database!.rawQuery('SELECT * FROM tasks').then((value) {




       emit(AppGetDatabaseState());

       value.forEach((element) {

         if(element['status']==['new'])
           newTasks.add(element);

        else if(element['status']==['done'])
           doneTasks.add(element);

         else if(element['status']==['archived'])
           archivedTasks.add(element);


       });

     });

  }

  void changeBottomCheatState({
    required bool isShow ,
    required IconData icon ,
})
  {
    isBottomSheetShown=isShow;
    fabIcon=icon;
    emit(AppChangeBottomSheetBarStates());

  }

  void updateData({
    required String states,
    required int id
})async
{

   database?.rawUpdate(
      'UPDATE Tasks SET states = ?,  WHERE id = ?',
      ['$states', '$id']).then((value) {

        gitDataFromDatabase(database);
        emit(AppUpdateDatabaseLoadingState());
   });

}

  bool isDark = false;

  void changeAppMode({bool? fromShared})
  {
    if (fromShared!=null)
      {
        isDark=fromShared;
        emit(AppChangeModeStates());

      }
   else {
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
       emit(AppChangeModeStates());
      });
    }

}





}