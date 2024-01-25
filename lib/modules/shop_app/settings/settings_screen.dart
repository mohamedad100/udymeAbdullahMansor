import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/shop_app/cubit/cubit.dart';
import 'package:untitled/layout/shop_app/cubit/states.dart';
import 'package:untitled/shared/components/components.dart';
import 'package:untitled/shared/components/constants.dart';

import '../login/shop_login_screen.dart';

class SettingsScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (BuildContext context, ShopStates state) {

        },
        builder: (BuildContext context, ShopStates state) {
          var model = ShopCubit.get(context).userModel;
          nameController.text = model!.data!.name!;
          emailController.text = model.data!.email!;
          phoneController.text = model.data!.phone!;
          return ConditionalBuilder(
            condition: ShopCubit.get(context).userModel != null,
            builder: (BuildContext context) =>  Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      if(state is ShopLoadingUpdateUserStates)
                      LinearProgressIndicator(),
                      SizedBox(
                        height: 10,
                      ),
                      defultFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          validate: (value){
                            if(value==null || value.isEmpty) {
                              return 'password address must not be empty';
                            }
                            return null;
                          },
                          label: 'Name',
                          prefix: Icons.person
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      defultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (value){
                            if(value==null || value.isEmpty) {
                              return 'email must not be empty';
                            }
                            return null;
                          },
                          label: 'Email',
                          prefix: Icons.email_outlined
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      defultFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          validate: (value){
                            if(value==null || value.isEmpty) {
                              return 'phone must not be empty';
                            }
                            return null;
                          },
                          label: 'phone',
                          prefix: Icons.phone
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      defaultButton(
                          function: (){
                            if (formKey.currentState!.validate()){
                              ShopCubit.get(context).updateUserModel(
                                  name: nameController.text,
                                  email: emailController.text,
                                  phone:phoneController.text
                              );
                  
                            }
                  
                          },
                          text: 'Update'
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      defaultButton(
                          function: (){
                            signOut(context);
                          },
                          text: 'Logout'
                      ),
                    ],
                  ),
                ),
              ),
            ),
            fallback: (BuildContext context) => CircularProgressIndicator(),
          );
        });
  }
}
