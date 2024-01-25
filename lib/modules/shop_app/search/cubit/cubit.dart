import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/models/shop_app/search_model.dart';
import 'package:untitled/modules/shop_app/search/cubit/states.dart';
import 'package:untitled/shared/components/constants.dart';
import 'package:untitled/shared/network/remote/dio_helper.dart';

import '../../../../shared/network/end_points.dart';

class SearchCubit extends Cubit<SearchStates>{
  SearchCubit() : super(SearchInitialStates()) ;

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? searchModel;

  void search (String text){

    emit(SearchLoadingStates());

    DioHelber.postData(url: SEARCH, data: {
      'text':text,
      'token':token
    }).then((value) {
      searchModel = SearchModel.fromJson(value?.data);
       emit(SearchSuccessedStates());
    }).catchError((error){

      emit(SearchErrorStates());
      print(error.toString());
    });
  }

}