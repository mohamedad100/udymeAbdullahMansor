import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/shop_app/cubit/cubit.dart';
import 'package:untitled/modules/shop_app/register/cubit/states.dart';

import '../../../layout/shop_app/shop_layout.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../login/cubit/cubit.dart';
import '../login/cubit/states.dart';
import 'cubit/cubit.dart';

class ShopRegisterScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=> ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit,ShopRegisterState>(
        listener: (BuildContext context, ShopRegisterState state) {
          if (state is ShopRegisterSuccessState) {
            if (state.loginRegisterModel!.status) {
              print(state.loginRegisterModel?.data?.token);
              print(state.loginRegisterModel?.message);
              CacheHelper.saveData(
                  key: 'token', value: state.loginRegisterModel?.data?.token).then((
                  value) {
                token = state.loginRegisterModel!.data!.token!;
                ShopCubit.get(context).getUserModel();
                ShopCubit.get(context).getHomeData();
                ShopCubit.get(context).getCategorieData();
                ShopCubit.get(context).getFavorites();
                // context.read<ShopCubit>().getUserModel();
                // context.read<ShopCubit>().getHomeData();
                // context.read<ShopCubit>().getCategorieData();
                // context.read<ShopCubit>().getFavorites();
                navigateAndFinish(context, ShopLayout());
              });

              showToast(
                  text: state.loginRegisterModel!.message,
                  states: ToastStates.SUCCESS
              );
            } else {
              print(state.loginRegisterModel?.message);
              showToast(
                  text: state.loginRegisterModel!.message,
                  states: ToastStates.ERROR
              );
            }
          }

        },
        builder: (BuildContext context, ShopRegisterState state) {
          return  Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'REGISTER',
                          style: Theme
                              .of(context)
                              .textTheme
                              .headlineMedium,
                        ),
                        Text(
                          'register now to browse our hot offers',
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        defultFormField(
                            controller: nameController,
                            type: TextInputType.name,
                            validate: (value) {
                              if (value == null || value.isEmpty) {
                                return 'please enter your name address';
                              }
                            },
                            label: 'name',
                            prefix: Icons.person
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        defultFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validate: (value) {
                              if (value == null || value.isEmpty) {
                                return 'please enter your email address';
                              }
                            },
                            label: 'Email address',
                            prefix: Icons.email_outlined
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        defultFormField(
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            suffix: ShopRegisterCubit
                                .get(context)
                                .suffix,
                            SuffixBressed: () {
                              ShopRegisterCubit.get(context)
                                  .changePasswordVisibility();
                            },
                            onSubmit: (value) {

                            },
                            isPassword: ShopRegisterCubit
                                .get(context)
                                .isPassword,

                            validate: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'password is too short';
                              }
                            },
                            label: 'Password address',
                            prefix: Icons.lock_outlined
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        defultFormField(
                            controller: phoneController,
                            type: TextInputType.phone,
                            validate: (value) {
                              if (value == null || value.isEmpty) {
                                return 'please enter your phone';
                              }
                            },
                            label: 'phone',
                            prefix: Icons.phone
                        ),
                        SizedBox(
                          height: 30,
                        ),

                        ConditionalBuilder(
                          condition: state is ! ShopRegisterLoadingState,
                          builder: (context) =>
                              defaultButton(
                                  function: () {
                                    if (formKey.currentState!.validate()) {
                                      ShopRegisterCubit.get(context).userRegister(
                                        email: emailController.text,
                                        password: passwordController.text,
                                        name: nameController.text,
                                        phone: phoneController.text,
                                      );
                                    }
                                  },
                                  text: 'register',
                                  isUpperCase: true
                              ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),

                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },

      ),
    );
  }
}
