import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/social_app/cubit/cubit.dart';
import 'package:untitled/layout/social_app/cubit/states.dart';
import 'package:untitled/shared/components/components.dart';

import '../edit_profile/edit_profile_screen.dart';

class SettingsScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (BuildContext context, SocialStates state) {  },
      builder: (BuildContext context, SocialStates state) {
        var userModel = SocialCubit.get(context).userModel;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 190,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topCenter,

                      child: Container(
                        height: 140,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft:Radius.circular(4) ,    //عملتله حواف من فوق بس
                            topRight:Radius.circular(4) ,
                          ),
                          image: DecorationImage(
                            image: NetworkImage(
                                '${userModel?.cover}'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 64,
                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(
                            '${userModel?.image}'),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text('${userModel?.name}',
                style: Theme.of(context).textTheme.bodyLarge,

              ),
              Text('${userModel?.bio}',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14
                  )


              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 20
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text('100',
                              style: Theme.of(context).textTheme.bodyLarge,

                            ),
                            Text('post',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14
                                )


                            ),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text('200',
                              style: Theme.of(context).textTheme.bodyLarge,

                            ),
                            Text('photos',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14
                                )


                            ),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text('10k',
                              style: Theme.of(context).textTheme.bodyLarge,

                            ),
                            Text('Followers',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14
                                )


                            ),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text('64',
                              style: Theme.of(context).textTheme.bodyLarge,

                            ),
                            Text('Followings',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14
                                )


                            ),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                      child:OutlinedButton(
                          onPressed: (){},
                          child: Text(
                            'Add Photos ',
                            style: TextStyle(
                              color: Colors.blue
                            ),
                          ),
                      ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  OutlinedButton(
                    onPressed: (){
                      navigateTo(context, EditProfileScreen());
                    },
                    child: Icon(
                      Icons.edit_sharp,
                    color: Colors.blue,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  OutlinedButton(onPressed: (){}, child: Text('subscribe')),
                  SizedBox(width: 20,),
                  OutlinedButton(onPressed: (){}, child: Text('unsubscribe')),

                ],
              ),


            ],
          ),
        );
      },

    );
  }
}
