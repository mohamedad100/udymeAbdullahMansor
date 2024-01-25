import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/models/shop_app/login_model.dart';
import 'package:untitled/modules/shop_app/login/cubit/states.dart';
import 'package:untitled/shared/network/remote/dio_helper.dart';

import '../../../../shared/network/end_points.dart';

class ShopLoginCubit extends Cubit<ShopLoginState> {
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);
   ShopLoginModel? loginModel;
  void userLogin({required String email, required String password}) {
    emit(ShopLoginLoadingState());

    DioHelber.postData(url: 'login', data: {
      'email': email,
      'password': password,
    }).then((value) {
      print(value?.data);
      loginModel=ShopLoginModel.fromJson(value?.data);
      print('wasaaaaaaal');

      print(loginModel?.status);
      print(loginModel?.message);

      emit(ShopLoginSuccessState(loginModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopLoginErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changePasswordVisibility(){
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off;
    emit(ShopLoginChangePasswordVisibilityState());

  }
}
