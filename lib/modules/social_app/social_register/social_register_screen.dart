import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/social_app/social_app.dart';
import '../../../shared/components/components.dart';


import 'cubit/cubit.dart';
import 'cubit/states.dart';

class SocialRegisterScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=> SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit,SocialRegisterState>(
        listener: (BuildContext context, SocialRegisterState state) {
          if (state is SocialCreateUserSuccessState) {
            navigateAndFinish(context, SocialLayout());

          }

        },
        builder: (BuildContext context, SocialRegisterState state) {
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
                          'register now to communicate with Friends',
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
                            suffix: SocialRegisterCubit
                                .get(context)
                                .suffix,
                            SuffixBressed: () {
                              SocialRegisterCubit.get(context)
                                  .changePasswordVisibility();
                            },
                            onSubmit: (value) {

                            },
                            isPassword: SocialRegisterCubit
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
                          condition: state is ! SocialCreateUserSuccessState,
                          builder: (context) =>
                              defaultButton(
                                  function: () {
                                    if (formKey.currentState!.validate()) {
                                      SocialRegisterCubit.get(context).userRegister(
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
