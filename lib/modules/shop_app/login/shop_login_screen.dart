import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled/layout/shop_app/cubit/cubit.dart';
import 'package:untitled/layout/shop_app/shop_layout.dart';
import 'package:untitled/modules/shop_app/login/cubit/cubit.dart';
import 'package:untitled/modules/shop_app/login/cubit/states.dart';
import 'package:untitled/modules/shop_app/register/shop_register_screen.dart';
import 'package:untitled/shared/components/components.dart';
import 'package:untitled/shared/components/constants.dart';
import 'package:untitled/shared/network/local/cache_helper.dart';

class ShopLoginScreen extends StatelessWidget {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginState>(
        listener: (BuildContext context, ShopLoginState state) {
          if (state is ShopLoginSuccessState) {
            if (state.loginModel.status) {
              print(state.loginModel.data?.token);
              print(state.loginModel.message);
              CacheHelper.saveData(
                  key: 'token', value: state.loginModel.data?.token).then((
                  value) {
                token = state.loginModel.data!.token!;
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
                  text: state.loginModel.message,
                  states: ToastStates.SUCCESS
              );
            } else {
              print(state.loginModel.message);
              showToast(
                  text: state.loginModel.message,
                  states: ToastStates.ERROR
              );
            }
          }
        },
        builder: (BuildContext context, ShopLoginState state) {
          return Scaffold(
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
                          'LOGIN',
                          style: Theme
                              .of(context)
                              .textTheme
                              .headlineMedium,
                        ),
                        Text(
                          'login now to browse our hot offers',
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
                            suffix: ShopLoginCubit
                                .get(context)
                                .suffix,
                            SuffixBressed: () {
                              ShopLoginCubit.get(context)
                                  .changePasswordVisibility();
                            },
                            onSubmit: (value) {
                              if (formKey.currentState!.validate()) {
                                ShopLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            isPassword: ShopLoginCubit
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
                          height: 30,
                        ),

                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          builder: (context) =>
                              defaultButton(
                                  function: () {
                                    if (formKey.currentState!.validate()) {
                                      ShopLoginCubit.get(context).userLogin(
                                        email: emailController.text,
                                        password: passwordController.text,
                                      );
                                    }
                                  },
                                  text: 'login',
                                  isUpperCase: true
                              ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),

                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('dont have an account?'),
                            defaultTextButton(
                                function: () {
                                  navigateTo(context, ShopRegisterScreen());
                                },
                                text: 'register'
                            )
                          ],
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
