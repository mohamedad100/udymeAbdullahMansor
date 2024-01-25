import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/models/shop_app/login_model.dart';
import 'package:untitled/modules/shop_app/login/cubit/states.dart';
import 'package:untitled/modules/shop_app/register/cubit/states.dart';
import 'package:untitled/modules/social_app/social_register/cubit/states.dart';
import 'package:untitled/shared/network/remote/dio_helper.dart';

import '../../../../models/shop_app/register_model.dart';
import '../../../../models/social_app/social_user_app.dart';
import '../../../../shared/network/end_points.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterState> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(SocialRegisterLoadingState());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      emit(SocialRegisterSuccessState());
      print(value.user?.email);
      print(value.user?.uid);
      userCreate(
          name: name,
          email: email,
          phone: phone,
          uId: value.user!.uid
      );
    }).catchError((error) {
      emit(SocialRegisterErrorState(error.toString()));
    });
  }

  void userCreate({
    required String name,
    required String email,
    required String phone,
    required String uId,
  }) {
    SocialUserModel model = SocialUserModel(
        name: name,
        email: email,
        phone: phone,
        uId: uId,
        cover: 'https://img.freepik.com/free-photo/variety-eggs-cup-grey-surface_114579-37787.jpg?w=740&t=st=1705162372~exp=1705162972~hmac=eadfb50e101fc9a570bac44bf6fe3d2baa9483d60eb8588d0f423f38d55c1578',
        image: 'https://img.freepik.com/free-photo/young-bearded-man-with-striped-shirt_273609-5677.jpg?w=740&t=st=1705157282~exp=1705157882~hmac=4b9a3fe8e2783a2dd1bd980826085e4b103d8cc868c855a42f0aa10ef1d30119',
        bio: 'Write you bio..',
        isEmailVerification: false
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(SocialCreateUserSuccessState());
    })
        .catchError((error){
      emit(SocialCreateUserErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off;
    emit(SocialRegisterChangePasswordVisibilityState());
  }
}
