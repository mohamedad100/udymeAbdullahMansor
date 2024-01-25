
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/news_app/cubit/states.dart';
import 'package:untitled/modules/news_app/business/business_screen.dart';
import 'package:untitled/modules/news_app/science/science_screen.dart';
import 'package:untitled/modules/news_app/sports/sports_screen.dart';
import 'package:untitled/shared/network/remote/dio_helper.dart';


class NewsCubit extends Cubit<NewsStates>{

  NewsCubit() : super (NewsInitialState() as NewsStates);

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItem=[
    BottomNavigationBarItem(
        icon: Icon(
          Icons.business,
        ),
      label: 'Business'

    ),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.sports,
        ),
        label: 'Sports'

    ),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.science_outlined,
        ),
        label: 'Science'

    ),


  ];

  List<Widget> screens = [
  BusinessScreen(),
  SportsScreen()  ,
  ScienceScreen(),



  ];

  void changeBottomNavBar(int index)
  {
    currentIndex =index;
    emit(NewsBottomNavState());

}

 List<dynamic> business=[];

  void getBusiness()
  {
    emit(NewsGetBusinessLoadingState());
    //DioHelber.init();
    DioHelber.getData(
        url: 'v2/top-headlines',
        query: {
          'country':'eg',
          'apiKey':'28463e4b146543e883b184910990c1e2',
          'category':'business',

        }
    ).then((value) {
      print(value);
      business=value?.data['articles'];

      emit(NewsGetBusinessSuccessState());
    }).catchError((error){

      print('2020ytytyt');
      print(  error.toString());

      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  List<dynamic> sports=[];

  void getSports()
  {
    emit(NewsGetSportsLoadingState());
    //DioHelber.init();
    DioHelber.getData(
        url: 'v2/top-headlines',
        query: {
          'country':'eg',
          'apiKey':'28463e4b146543e883b184910990c1e2',
          'category':'sports',
        }
    ).then((value) {
      print(value);
      sports=value?.data['articles'];

      emit(NewsGetSportsSuccessState());
    }).catchError((error){

      print('2020ytytyt');
      print(  error.toString());

      emit(NewsGetSportsErrorState(error.toString()));
    });
  }

  List<dynamic> science=[];

  void getScience()
  {
    emit(NewsGetScienceLoadingState());
    //DioHelber.init();
    DioHelber.getData(
        url: 'v2/top-headlines',
        query: {
          'country':'eg',
          'apiKey':'28463e4b146543e883b184910990c1e2',
          'category':'science',

        }
    ).then((value) {
      print(value);
      science=value?.data['articles'];

      emit(NewsGetScienceSuccessState());
    }).catchError((error){

      print('2020ytytyt');
      print(  error.toString());

      emit(NewsGetScienceErrorState(error.toString()));
    });
  }

  List<dynamic> search=[];

  void getSearch(String value)
  {
    emit(NewsGetSearchLoadingState());
    DioHelber.getData(
        url: 'v2/everything',
        query: {
          'apiKey':'28463e4b146543e883b184910990c1e2',
          'q':'$value',

        }
    ).then((value) {
      print(value);
      search=value?.data['articles'];

      emit(NewsGetSearchSuccessState());
    }).catchError((error){

      print('2020ytytyt');
      print(  error.toString());

      emit(NewsGetSearchErrorState(error.toString()));
    });
  }

}