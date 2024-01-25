import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/social_app/cubit/cubit.dart';
import 'package:untitled/layout/social_app/cubit/states.dart';
import 'package:untitled/models/social_app/post_model.dart';
import 'package:untitled/shared/components/components.dart';
import 'package:untitled/shared/styles/colors.dart';

class FeedsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, SocialStates state) {
        return ConditionalBuilder(
          condition: SocialCubit.get(context).posts.length > 0 && SocialCubit.get(context).userModel != null,
          builder: (BuildContext context) {
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    //بيقطع حواف الصوره
                    elevation: 5,
                    //ظل للصوره
                    margin: EdgeInsets.all(8.0),
                    //padding الصوره
                    child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        Image(
                          image: NetworkImage(
                              'https://img.freepik.com/free-photo/side-view-blurry-kid-holding-ice-cream-cone_23-2149426716.jpg?w=740&t=st=1705072603~exp=1705073203~hmac=0cc36416b2daf631b6110bffdbbae86d5953743c3c45d0d7f58e7d9bdcc3fcac'),
                          fit: BoxFit.cover,
                          height: 200,
                          width: double.infinity,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Chats with Friends',
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    //shrinkWrap & physics لازم احطها لليست ادام هي جوه سينجل اسكرول فيو
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => buildPostItem(SocialCubit.get(context).posts[index],context,index),
                    itemCount:SocialCubit.get(context).posts.length,
                    separatorBuilder: (BuildContext context, int index) =>SizedBox(
                      height: 8,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                ],
              ),
            );
          },
          fallback: (BuildContext context)=> Center(child: CircularProgressIndicator()),


        );
      },



    );
  }

  Widget buildPostItem(PostModel model,context,index) => Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 5,
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(
                        '${model.image}'),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${model.name}',
                            style: TextStyle(height: 1.4),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.check_circle,
                            color: defaultColor,
                            size: 16,
                          ),
                        ],
                      ),
                      Text(
                        '${model.dateTime}',
                        style: TextStyle(
                            fontSize: 12, color: Colors.grey, height: 1.4),
                      ),
                    ],
                  )),
                  SizedBox(
                    width: 15,
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.more_horiz,
                        size: 16,
                      )),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey[300],
                ),
              ),
              Text(
                '${model.text}',
                style: TextStyle(height: 1.3, fontSize: 14),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(bottom: 10, top: 5),
              //   child: Container(
              //     width: double.infinity,
              //     child: Wrap(
              //       children: [
              //         Padding(
              //           padding: const EdgeInsetsDirectional.only(end: 6),
              //           child: Container(
              //             height: 20,
              //             child: MaterialButton(
              //                 onPressed: () {},
              //                 minWidth: 1.0,
              //                 padding: EdgeInsets.zero,
              //                 child: Text(
              //                   '#softWare',
              //                   style: TextStyle(color: Colors.blue),
              //                 )),
              //           ),
              //         ),
              //         Padding(
              //           padding: const EdgeInsetsDirectional.only(end: 6),
              //           child: Container(
              //             height: 20,
              //             child: MaterialButton(
              //                 onPressed: () {},
              //                 minWidth: 1.0,
              //                 padding: EdgeInsets.zero,
              //                 child: Text(
              //                   '#softWare',
              //                   style: TextStyle(color: Colors.blue),
              //                 )),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              if(model.postImage != '')
              Padding(
                padding: const EdgeInsetsDirectional.only(
                  top: 15
                ),
                child: Container(
                  height: 140,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    image: DecorationImage(
                      image: NetworkImage(
                          '${model.postImage}'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            children: [
                              Icon(
                                Icons.favorite_border,
                                color: Colors.red,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                '${SocialCubit.get(context).likes[index]}',
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.chat_bubble_outline,
                                color: Colors.amber,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                '0 comment',
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  color: Colors.grey[300],
                  height: 1,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 18,
                            backgroundImage: NetworkImage(
                                '${SocialCubit.get(context).userModel?.image}'),
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Text(
                            'write a comment..',
                            style: TextStyle(
                                fontSize: 12, color: Colors.grey, height: 1.4),
                          ),
                        ],
                      ),
                      onTap: () {},
                    ),
                  ),
                  InkWell(
                    child: Row(
                      children: [
                        Icon(
                          Icons.favorite_border,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          'Like',
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    onTap: () {
                      SocialCubit.get(context).likePost(SocialCubit.get(context).postsId[index]);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
