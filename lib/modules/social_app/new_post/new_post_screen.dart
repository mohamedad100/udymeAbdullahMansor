import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/social_app/cubit/cubit.dart';
import 'package:untitled/layout/social_app/cubit/states.dart';
import 'package:untitled/shared/components/components.dart';

import '../feeds/feeds_screen.dart';

class NewPostScreen extends StatelessWidget {
var textController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (BuildContext context, SocialStates state) {  },
      builder: (BuildContext context, SocialStates state) {
        return Scaffold(
          appBar:defaultAppBar(
            context: context,
            title: 'Create Post',
            action:[
              // defaultTextButton(function: (){}, text: 'post')
              TextButton(
                  onPressed: (){
                    var now = DateTime.now();
                    if(SocialCubit.get(context).postImage == null){
                      SocialCubit.get(context).createPost(
                          dateTime: now.toString(),
                          text: textController.text,
                      );
                    }else{
                      SocialCubit.get(context).uploadPostImage(
                          dateTime: now.toString(),
                          text: textController.text
                      );
                    }
                    SocialCubit.get(context).getPosts();
                    Navigator.pop(context);
                  },
                  child: Text(
                    'post',
                    style: TextStyle(
                        color: Colors.blue
                    ),)),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if(state is SocialCreatePostLoadingStates)
                LinearProgressIndicator(),
                if(state is SocialCreatePostLoadingStates)
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(
                          'https://img.freepik.com/free-photo/attractive-young-man-wearing-glasses-casual-clothes-showing-ok-good-sign-approval-like-something-standing-against-blue-background_1258-73346.jpg?w=740&t=st=1705075226~exp=1705075826~hmac=28cd7da4362a5467c7da54a5316306441ee9ef4041f5f4c616763da45fa39448'),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Text(
                        'Mohamed Adel',
                        style: TextStyle(height: 1.4),
                      ),),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration:InputDecoration(
                        hintText: 'What is in your mind..',
                        border: InputBorder.none,
                    ) ,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                if(SocialCubit.get(context).postImage !=null)
                Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Container(
                      height: 140,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        image: DecorationImage(
                          image:FileImage(SocialCubit.get(context).postImage!),
                          //coverImage ==null ?  NetworkImage('${userModel.cover}') : FileImage(coverImage)as ImageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          SocialCubit.get(context).removePostImage();
                        },
                        icon: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.blue,
                          child: Icon(
                            Icons.close,
                            size: 16,
                            color: Colors.white,
                          ),
                        )),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed: (){
                            SocialCubit.get(context).getPostImage();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.image,
                              color:Colors.blue ,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text('add photo',
                              style: TextStyle(color: Colors.blue),
                              ),
                            ],
                          ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: (){},
                        child:Text('#tags',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

        );
      },

    );
  }
}
