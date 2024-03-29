import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/social_app/cubit/cubit.dart';
import 'package:untitled/layout/social_app/cubit/states.dart';
import 'package:untitled/models/social_app/message_model.dart';
import 'package:untitled/models/social_app/social_user_app.dart';

class ChatDetailsScreen extends StatelessWidget {
 SocialUserModel? userModel;
 ChatDetailsScreen({this.userModel});
 var messageController = TextEditingController();
 final ScrollController controller = ScrollController();

 @override
  Widget build(BuildContext context) {
    return  Builder(
      builder: (BuildContext context) {
        SocialCubit.get(context).getMessage(receiverId: userModel?.uId);
      return  BlocConsumer<SocialCubit,SocialStates>(
          listener: (BuildContext context, SocialStates state) {  },
          builder: (BuildContext context, SocialStates state) {
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(userModel!.image!),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(userModel!.name!),
                  ],
                ),
              ),
              body: ConditionalBuilder(
                condition:SocialCubit.get(context).message.length > 0,
                builder: (BuildContext context)=> Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          reverse: true,
                      controller:controller,
                      physics: BouncingScrollPhysics(),
                            itemBuilder: (context,index){
                              var message = SocialCubit.get(context).message[index];
                             if(SocialCubit.get(context).userModel!.uId == message.senderId)
                               return buildMyMessage(message);

                               return buildMessage(message);
                            },
                            separatorBuilder: (context,index)=>SizedBox(
                              height: 15,
                            ),
                            itemCount: SocialCubit.get(context).message.length
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(15)
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,  // دا علشان كيرف الكونتينر يتطبق علي ال row
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: messageController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'type your message here...',
                                  hintStyle: TextStyle(
                                      color: Colors.grey[400]
                                  ),
                                ),
                                onTap: (){

                                },
                              ),
                            ),
                            Container(
                              height: 50,
                              color: Colors.blue,
                              child: MaterialButton(
                                onPressed: (){
                                  SocialCubit.get(context).sendMessage(
                                      receiverId: userModel?.uId,
                                      dateTime: DateTime.now().toString(),
                                      text: messageController.text
                                  );
                                  messageController.clear();
                                  //messageController.text='';
                                  // controller.animateTo(
                                  //   10000,
                                  //   duration: Duration(milliseconds: 300),
                                  //   curve: Curves.easeOut,
                                  // );
                                },
                                minWidth: 1,
                                child: Icon(
                                  Icons.send,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                fallback: (BuildContext context)=>Center(child: CircularProgressIndicator()),

              ),
            );
          },

        );
      },

    );
  }

  Widget buildMessage(MessageModel model)=>Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadiusDirectional.only(
            bottomEnd: Radius.circular(10),
            topStart: Radius.circular(10),
            topEnd: Radius.circular(10),
          ),

        ),
        padding: EdgeInsets.symmetric(
            vertical:5 ,
            horizontal: 10
        ),
        child: Text(model.text!)
    ),
  );

 Widget buildMyMessage(MessageModel model)=> Align(
   alignment: AlignmentDirectional.centerEnd,
   child: Container(
       decoration: BoxDecoration(
         color: Colors.blue.withOpacity(0.2),
         borderRadius: BorderRadiusDirectional.only(
           bottomStart: Radius.circular(10),
           topStart: Radius.circular(10),
           topEnd: Radius.circular(10),
         ),

       ),
       padding: EdgeInsets.symmetric(
           vertical:5 ,
           horizontal: 10
       ),
       child: Text(model.text!)
   ),
 );

}
