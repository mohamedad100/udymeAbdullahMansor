import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/models/shop_app/login_model.dart';
import 'package:untitled/modules/shop_app/login/cubit/states.dart';
import 'package:untitled/modules/shop_app/register/cubit/states.dart';
import 'package:untitled/shared/network/remote/dio_helper.dart';

import '../../../../models/shop_app/register_model.dart';
import '../../../../shared/network/end_points.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterState> {
  ShopRegisterCubit() : super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);
  ShopRegisterModel? loginRegisterModel;
  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,

  }) {
    emit(ShopRegisterLoadingState());

    DioHelber.postData(url: REGISTER, data: {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,

    }).then((value) {
      print(value?.data);
      loginRegisterModel=ShopRegisterModel.fromJson(value?.data);
      print('wasaaaaaaal');

      print(loginRegisterModel?.status);
      print(loginRegisterModel?.message);

      emit(ShopRegisterSuccessState(loginRegisterModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopRegisterErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changePasswordVisibility(){
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off;
    emit(ShopRegisterChangePasswordVisibilityState());

  }
}
