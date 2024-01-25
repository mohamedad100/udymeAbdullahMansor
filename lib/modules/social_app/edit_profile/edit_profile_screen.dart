import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/layout/social_app/cubit/cubit.dart';
import 'package:untitled/layout/social_app/cubit/states.dart';
import 'package:untitled/shared/components/components.dart';

class EditProfileScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (BuildContext context, SocialStates state) {},
      builder: (BuildContext context, SocialStates state) {
        var userModel = SocialCubit.get(context).userModel;
       // var profileImage = SocialCubit.get(context).profileImage;
        var file = SocialCubit.get(context).file;
        var coverImage = SocialCubit.get(context).coverImage;
        nameController.text = userModel!.name!;
        phoneController.text = userModel!.phone!;

        bioController.text = userModel.bio!;


        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Edit Profile',
            action: [
              defaultTextButton(function: () {
                SocialCubit.get(context).updateUser(name:nameController.text, phone:phoneController.text, bio:bioController.text);
              }, text: 'Update'),
              SizedBox(
                width: 15,
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if(state is SocialUserUpdateLoadingStates)
                  LinearProgressIndicator(),
                  if(state is SocialUserUpdateLoadingStates)
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 190,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 140,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(4),
                                    //عملتله حواف من فوق بس
                                    topRight: Radius.circular(4),
                                  ),
                                  image: DecorationImage(
                                    image:// NetworkImage('${userModel?.cover}'),
                                    coverImage ==null ?  NetworkImage('${userModel.cover}') : FileImage(coverImage)as ImageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    SocialCubit.get(context).getCoverImage();
                                  },
                                  icon: CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.blue,
                                    child: Icon(
                                      Icons.camera_alt_outlined,
                                      size: 16,
                                      color: Colors.white,
                                    ),
                                  )),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 64,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 60,
                                backgroundImage:
                              //  profileImage ==null ?  NetworkImage('${userModel?.image}') : FileImage(profileImage),
                                file ==null ?  NetworkImage('${userModel?.image}') : FileImage(file)as ImageProvider,
            
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  SocialCubit.get(context).getImage();
                                },
                                icon: CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.blue,
                                  child: Icon(
                                    Icons.camera_alt_outlined,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  if(SocialCubit.get(context).file != null ||SocialCubit.get(context).coverImage != null )
                  Row(
                    children: [
                      if(SocialCubit.get(context).file != null)
                      Expanded(
                        child: Column(
                          children: [
                            defaultButton(
                                function: (){
                                  SocialCubit.get(context).uploadProfileImage(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      bio: bioController.text
                                  );
                                },
                                text: 'upload profile '),
                            if(state is SocialUserUpdateLoadingStates)
                             SizedBox(height: 5,),
                            if(state is SocialUserUpdateLoadingStates)
                             LinearProgressIndicator(),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      if(SocialCubit.get(context).coverImage != null)
                      Expanded(
                        child: Column(
                          children: [
                            defaultButton(
                                function: (){
                                  SocialCubit.get(context).uploadCoverImage(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      bio: bioController.text
                                  );
                                },
                                text: 'upload cover '),
                            if(state is SocialUserUpdateLoadingStates)
                             SizedBox(height: 5,),
                            if(state is SocialUserUpdateLoadingStates)
                             LinearProgressIndicator(),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if(SocialCubit.get(context).file != null ||SocialCubit.get(context).coverImage != null )
                    SizedBox(
                    height: 20,
                  ),
                  defultFormField(
                      controller: nameController,
                      type: TextInputType.name,
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return 'name must not be empty';
                        }
                      },
                      label: 'Name',
                      prefix: Icons.person,
            
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  defultFormField(
                    controller: bioController,
                    type: TextInputType.text,
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return 'bio must not be empty';
                      }
                    },
                    label: 'bio',
                    prefix: Icons.info,
            
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  defultFormField(
                    controller: phoneController,
                    type: TextInputType.phone,
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return 'phone must not be empty';
                      }
                    },
                    label: 'phone',
                    prefix: Icons.phone,
            
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
