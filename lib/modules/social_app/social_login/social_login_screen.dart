import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/social_app/social_app.dart';

import '../../../shared/components/components.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../social_register/social_register_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class SocialLoginScreen extends StatelessWidget {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
 var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit,SocialLoginState>(
        listener: (BuildContext context, SocialLoginState state) {
          if(state is SocialLoginErrorState){
            showToast(text: state.error, states: ToastStates.ERROR);
          }
          if(state is SocialLoginSuccessState){
            CacheHelper.saveData(
                key: 'uId', value: state.uId).then((value) {


              navigateAndFinish(context, SocialLayout());
            });
          }

        },
        builder: (BuildContext context, SocialLoginState state) {
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
                          'login now to communicate with Friends',
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
                            suffix: SocialLoginCubit
                                .get(context)
                                .suffix,
                            SuffixBressed: () {
                              SocialLoginCubit.get(context)
                                  .changePasswordVisibility();
                            },
                            onSubmit: (value) {
                              if (formKey.currentState!.validate()) {
                                SocialLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            isPassword: SocialLoginCubit
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
                          condition: state is! SocialLoginLoadingState,
                          builder: (context) =>
                              defaultButton(
                                  function: () {
                                    if (formKey.currentState!.validate()) {
                                      SocialLoginCubit.get(context).userLogin(
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
                                  navigateTo(context, SocialRegisterScreen());
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
