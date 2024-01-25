import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/social_app/cubit/states.dart';
import 'package:untitled/shared/components/components.dart';

import '../../modules/social_app/new_post/new_post_screen.dart';
import 'cubit/cubit.dart';

class SocialLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (BuildContext context, SocialStates state) {
        if(state is SocialNewPostStates){
          navigateTo(context, NewPostScreen());
        }
      },
      builder: (BuildContext context, SocialStates state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.titels[cubit.currentIndex]),
            actions: [
              IconButton(onPressed: (){}, icon: Icon(Icons.notifications_none)),
              IconButton(onPressed: (){}, icon: Icon(Icons.search_outlined)),

            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar:BottomNavigationBar(
           currentIndex: cubit.currentIndex,
           onTap: (index){
           cubit.ChangeBottomNav(index);
           },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home),
              label: 'Home'
              ),
              BottomNavigationBarItem(icon: Icon(Icons.chat),
                  label: 'Chats'
              ),
              BottomNavigationBarItem(icon: Icon(Icons.upload_file),
                  label: 'Post'
              ),
              BottomNavigationBarItem(icon: Icon(Icons.location_on_outlined),
                  label: 'Users'
              ),
              BottomNavigationBarItem(icon: Icon(Icons.settings),
                  label: 'Settings'
              ),




            ],) ,
        );
      },
    );
  }
}
