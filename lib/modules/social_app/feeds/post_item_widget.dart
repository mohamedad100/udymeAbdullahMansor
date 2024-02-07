import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:untitled/shared/components/components.dart';

import '../../../layout/social_app/cubit/cubit.dart';
import '../../../models/social_app/comment_model.dart';
import '../../../models/social_app/post_model.dart';
import '../../../shared/styles/colors.dart';

class PostItemWidget extends StatefulWidget {
  final PostModel model;
  final BuildContext context;
  final int index;
  final bool isLiked;
 // final List<CommentModel>? comments;
  const PostItemWidget(this.model, this.context, this.index,this.isLiked, {super.key});

  @override
  State<PostItemWidget> createState() => _PostItemWidgetState();
}

class _PostItemWidgetState extends State<PostItemWidget> {
  bool? isLiking;
  var commentController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Card(
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
                  backgroundImage: NetworkImage('${widget.model.image}'),
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
                              '${widget.model.name}',
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
                          '${widget.model.dateTime}',
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
              '${widget.model.text}',
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
            if (widget.model.postImage != '')
              Padding(
                padding: const EdgeInsetsDirectional.only(top: 15),
                child: Container(
                  height: 140,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    image: DecorationImage(
                      image: NetworkImage('${widget.model.postImage}'),
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
                              '${SocialCubit.get(context).likes[widget.index]}',
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
                    onTap: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (context) => Container(
                          height: double.infinity,
                          width: double.infinity,
                          color: Colors.grey[200],

                          child: Column(
                            children: [
                              ConditionalBuilder(
                                  condition: widget.model.comments!=null&&widget.model.comments!.isNotEmpty,
                                  builder: (BuildContext context)=> Expanded(
                                    child: ListView.separated(
                                        itemBuilder: (context,index)=>Padding(
                                          padding: const EdgeInsets.only(
                                              top: 40,
                                              left: 15
                                          ),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  CircleAvatar(
                                                    radius: 25,
                                                    backgroundImage: NetworkImage('${widget.model.comments![index].image}'),

                                                  ),
                                                  SizedBox(width: 5),
                                                  Container(

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
                                                    child: Column(
                                                      children: [
                                                        Text('${widget.model.comments![index].name}',
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.w700
                                                          ),
                                                        ),
                                                        Text('${widget.model.comments![index].text}'),
                                                      ],
                                                    ),

                                                  ),
                                                ],
                                              ),

                                            ],
                                          ),
                                        ),
                                        separatorBuilder: (context,index)=>SizedBox(
                                          height: 5,
                                        ),
                                        itemCount: widget.model.comments!.length
                                    ),
                                  ),
                                  fallback:(BuildContext context)=> Center(child: Text("no comments!")),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
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
                                          controller: commentController,
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
                                            // SocialCubit.get(context).sendMessage(
                                            //     receiverId: userModel?.uId,
                                            //     dateTime: DateTime.now().toString(),
                                            //     text: messageController.text
                                            // );
                                            SocialCubit.get(context).commentPost(
                                                text: commentController.text,
                                                dateTime: DateTime.now().toString(),
                                              postId: SocialCubit.get(context).postsId[widget.index]
                                            );
                                            commentController.clear();

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
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                InkWell(
                  child: Row(
                    children: [
                      Icon(
                        isLiking == null
                            ? widget.isLiked
                            ? Icons.favorite
                            : Icons.favorite_border
                            : isLiking!
                            ? Icons.favorite
                            : Icons.favorite_border,
                        //SocialCubit.get(context).suffix,
                        color: Colors.red,
                    //    isLiking == null ? widget.isLiked? Icons.favorite: Icons.favorite_border: isLiking!? Icons.favorite: Icons.favorite_border,


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
                    // SocialCubit.get(context).likePost(SocialCubit.get(context).postsId[index]);
                    if(isLiking != null){
                      if(isLiking!){
                        SocialCubit.get(context).disslikePost(
                            SocialCubit.get(context).postsId[widget.index]);
                        setState(() {
                          isLiking = false;
                        });
                      }else{
                        SocialCubit.get(context)
                            .likePost(SocialCubit.get(context).postsId[widget.index]);
                        setState(() {
                          isLiking = true;
                        });
                      }
                    }else{
                      if (widget.isLiked) {
                        SocialCubit.get(context).disslikePost(
                            SocialCubit.get(context).postsId[widget.index]);
                        setState(() {
                          isLiking = false;
                        });
                      } else {
                        SocialCubit.get(context)
                            .likePost(SocialCubit.get(context).postsId[widget.index]);
                        setState(() {
                          isLiking = true;
                        });
                      }
                    }

                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
