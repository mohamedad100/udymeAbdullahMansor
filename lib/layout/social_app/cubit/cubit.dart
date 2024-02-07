import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/layout/social_app/cubit/states.dart';
import 'package:untitled/models/social_app/comment_model.dart';
import 'package:untitled/models/social_app/message_model.dart';
import 'package:untitled/models/social_app/social_user_app.dart';
import 'package:untitled/modules/social_app/settings/settings_screen.dart';
import 'package:untitled/modules/social_app/users/users_screen.dart';
import 'package:untitled/shared/components/constants.dart';

import '../../../models/shop_app/search_model.dart';
import '../../../models/social_app/post_model.dart';
import '../../../modules/social_app/chats/chats_screen.dart';
import '../../../modules/social_app/feeds/feeds_screen.dart';
import '../../../modules/social_app/new_post/new_post_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialStates());

  static SocialCubit get(context) => BlocProvider.of(context);

  SocialUserModel? userModel;

  void getUserData() {
    emit(SocialGetUsersLoadingStates());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      print(value.data());
      print('saaaaaaaaa77777');
      userModel = SocialUserModel.fromJson(value.data()!);
      emit(SocialGetUsersSuccessStates());
    }).catchError((error) {
      print(error.toString());
      print('errrrrrrrrrrrror');
      emit(SocialGetUsersErrorStates(error.toString()));
    });
  }

  int currentIndex = 0;
  List<Widget> screens = [
    FeedsScreen(),
    ChatsScreen(),
    NewPostScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];
  List<String> titels = [
    'Home',
    'Chats',
    'Post',
    'Users',
    'Settings',
  ];

  void ChangeBottomNav(int index) {
    if(index == 1)
      getUsers();
    if (index == 2)
      emit(SocialNewPostStates());
    else {
      currentIndex = index;

      emit(SocialChangeBottomNavStates());
    }
  }

  // File? profileImage;
  // var picker = ImagePicker();
  //
  // Future<void> getProfileImage() async {
  //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  //   if(pickedFile != null){
  //
  //     profileImage = File(pickedFile.path);
  //     emit(SocialCoverImagePickedSuccessStates());
  //   }else{
  //     print('no image selected');
  //     emit(SocialCoverImagePickedErrorStates());
  //   }
  // }
  File? file;

  getImage() async {
    final ImagePicker picker = ImagePicker();

    // final XFile? imagecamera = await picker.pickImage(source: ImageSource.camera);
    // file=File(imagecamera!.path);
    final XFile? imagecamera =
        await picker.pickImage(source: ImageSource.gallery);
    file = File(imagecamera!.path);
    emit(SocialProfileImagePickedSuccessStates());
  }

  File? coverImage;

  getCoverImage() async {
    final ImagePicker picker = ImagePicker();

    final XFile? imagecameraa =
        await picker.pickImage(source: ImageSource.gallery);
    coverImage = File(imagecameraa!.path);
    emit(SocialCoverImagePickedSuccessStates());
  }

  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
    String? cover,
    String? image,
  }) async {
    emit(SocialUserUpdateLoadingStates());
    var refStorage = FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(file!.path).pathSegments.last}')
        .putFile(file!)
        .then((value){
          value.ref.getDownloadURL().then((value) {
        //  emit(SocialUploadProfileImageSuccessStates());
          print(value);
          updateUser(
              name:name ,
              phone:phone ,
              bio:bio,
              image: value,
          );

          }).catchError((error){

            emit(SocialUploadProfileImageErrorStates());
          });
    })
        .catchError((error){
      emit(SocialUploadProfileImageErrorStates());

    });
  }




  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
    String? cover,
    String? image,
  }) async {
    emit(SocialUserUpdateLoadingStates());
    var refStorage = FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value){
      value.ref.getDownloadURL().then((value) {        //value.ref.getDownloadURL() معناها جيبلي لينك الصوره الي اترفعت
      //  emit(SocialUploadCoverImageSuccessStates());
        print(value);
        updateUser(
            name: name,
            phone: phone,
            bio: bio,
            cover: value
        );

      }).catchError((error){

        emit(SocialUploadCoverImageErrorStates());
      });
    })
        .catchError((error){
      emit(SocialUploadCoverImageErrorStates());

    });
  }


  // void updateUserImage({
  //   required String name,
  //   required String phone,
  //   required String bio,
  // }){
  //    emit(SocialUserUpdateLoadingStates());
  //   if(coverImage !=null){
  //     uploadCoverImage();
  //   }else if(file !=null)
  //   {
  //     uploadProfileImage();
  //   }else if(coverImage !=null && file !=null){
  //
  //
  //   }
  //
  //   else
  //   {
  //     updateUser(
  //         name: name,
  //         phone: phone,
  //         bio: bio,
  //     );
  //
  //   }
  //
  //
  // }


  void updateUser({
    required String name,
    required String phone,
    required String bio,
    String? cover,
    String? image,
  }){

    SocialUserModel model = SocialUserModel(
        name: name,
        phone: phone,
        bio: bio,
        email: userModel?.email,
        cover:cover?? userModel?.cover,
        image:image?? userModel?.image,
        uId: userModel?.uId,
        isEmailVerification: false
    );


    FirebaseFirestore.
    instance.collection('users').
    doc(userModel?.uId).
    update(model.toMap()).
    then((value) {
      getUserData();
    }).catchError((error){
      emit(SocialUserUpdateErrorStates());
    });
  }

 //دي ميثودات عمل البوست
  File? postImage;

  getPostImage() async {
    final ImagePicker picker = ImagePicker();

    final XFile? imagecameraa =
    await picker.pickImage(source: ImageSource.gallery);
    postImage = File(imagecameraa!.path);
    emit(SocialPostImagePickedSuccessStates());
  }

  void removePostImage(){

    postImage = null;
    emit(SocialRemovePostImageStates());
  }


  void uploadPostImage({

    required String dateTime,
    required String text,

  }) async {
    emit(SocialCreatePostLoadingStates());
    var refStorage = FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value){
      value.ref.getDownloadURL().then((value) {        //value.ref.getDownloadURL() معناها جيبلي لينك الصوره الي اترفعت
        //  emit(SocialUploadCoverImageSuccessStates());
        print(value);
        createPost(
            dateTime: dateTime,
             text: text,
            postImage: value,
        );

      }).catchError((error){

        emit(SocialCreatePostErrorStates());
      });
    })
        .catchError((error){
      emit(SocialCreatePostErrorStates());

    });
  }

  void createPost({
    required String dateTime,
    required String text,
    String? postImage,
  }){
    emit(SocialCreatePostLoadingStates());

    PostModel model = PostModel(
        name: userModel?.name,
        image:userModel?.image,
        uId: userModel!.uId,
        dateTime: dateTime,
        text: text,
        postImage: postImage??'',
    );


    FirebaseFirestore.
    instance.collection('posts').
    add(model.toMap()).
    then((value) {
      emit(SocialCreatePostSuccessStates());

    }).catchError((error){
      emit(SocialCreatePostErrorStates());
    });
  }


  List<PostModel> posts= [];
  List<String> postsId= [];
  List<int> likes= [];
  // Map<String, List> idsOfLikes = {};
  //Map<String , List<CommentModel>> coment ={};
  void getPosts(){
    // emit(SocialGetPostsLoadingStates());
    FirebaseFirestore.instance
        .collection('posts')
        .get()
        .then((post) {

          post.docs.forEach((element) {
            element.reference
                .collection('likes')
                .get()
                .then((value) {
              likes.add(value.docs.length);
              List idsOfLikes = [];
              value.docs.forEach((element2) {
                idsOfLikes.add(element2.id);
              });

              // idsOfLikes[element.id] = ids;
              //comment
              List<CommentModel> comments = [];
              element.reference
                  .collection('comment')
                  .get().then((value) {
                    value.docs.forEach((element3) {
                      CommentModel theCommentModel = CommentModel.fromJson(element3.data());
                      comments.add(theCommentModel);

                    });
              }).catchError((error){});
            //  coment[element.id] = comments;

              //
              postsId.add(element.id);

              PostModel thePostModel = PostModel.fromJson(element.data());
              thePostModel.usersIdsOfLikes = idsOfLikes;
              thePostModel.comments = comments;
              posts.add(thePostModel);


            })
              .catchError((error){});

            // postsId.add(element.id);
            // posts.add(PostModel.fromJson(element.data()));

          });

          print('doneeeeeeeeeeeeeeeeeeee');
          emit(SocialGetPostsSuccessStates());

    })
        .catchError((error){
      emit(SocialGetPostsErrorStates(error.toString()));
    });
  }

  ///
  void likePost(String postId){
   FirebaseFirestore.instance
       .collection('posts')
       .doc(postId)
       .collection('likes')
       .doc(userModel!.uId)
       .set({
       'like':true,
   })
       .then((value){

         emit(SocialLikePostSuccessStates());
   })
       .catchError((error){
     emit(SocialLikePostErrorStates(error.toString()));
   });
  }
  /////
  void disslikePost(String postId){
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .delete()
        .then((value){
      emit(SocialDisLikePostSuccessStates());
    })
        .catchError((error){
      emit(SocialDisLikePostErrorStates(error.toString()));
    });
  }
/////
  
  void commentPost({
    postId,
    required String text,
    required String dateTime,
  }){

    CommentModel model = CommentModel(
      text: text,
      senderId: userModel?.uId,
      name: userModel?.name,
      image:userModel?.image,
      dateTime: dateTime
    );
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comment')
        .add(model.toMap())
        .then((value) {
          emit(SocialCommentPostSuccessStates());


    }).catchError((error){
      emit(SocialCommentPostErrorStates(error.toString()));
    });
    
  }

  
  List<SocialUserModel>? users;

  void getUsers(){
    users = [];
   // if(users?.length ==0)
    FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        if(element.data()['uId'] != userModel?.uId)
        users?.add(SocialUserModel.fromJson(element.data()));

      });
      emit(SocialGetAllUsersSuccessStates());
    })
        .catchError((error){
      emit(SocialGetAllUsersErrorStates(error.toString()));
    });
  }

  void sendMessage({
    @required String? receiverId,
    @required String? dateTime,
    @required String? text,

  }){

    MessageModel model = MessageModel(
      text: text,
      senderId: userModel?.uId,
      receiverId: receiverId,
      dateTime: dateTime
    );
    //set my chat
    FirebaseFirestore.instance
    .collection('users')
    .doc(userModel?.uId)
    .collection('chats')
    .doc(receiverId)
    .collection('message')
    .add(model.toMap())
    .then((value) {
      emit(SocialSendMessageSuccessStates());
    })
    .catchError((error){
      emit(SocialSendMessageErrorStates());

    });
    //set receiver chat
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel?.uId)
        .collection('message')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessStates());

    })
        .catchError((error){
      emit(SocialSendMessageErrorStates());

    });
  }

  List<MessageModel> message=[];

  void getMessage({@required String? receiverId,}){

    FirebaseFirestore.instance
    .collection('users')
    .doc(userModel?.uId)
    .collection('chats')
    .doc(receiverId)
    .collection('message')
    .orderBy('dateTime', descending: true)
    .snapshots()
    .listen((event) {
      message=[];
      event.docs.forEach((element) {

        message.add(MessageModel.fromJson(element.data()));
      });
      emit(SocialGetMessageSuccessStates());
    });
  }


  //search from database
 List<SearchModel> search=[];
 Stream<List<SocialUserModel>> searchDataBase(String query){
    return FirebaseFirestore.instance
        .collection('users')
        .where('name', isGreaterThanOrEqualTo: query.toUpperCase())
        .where('name', isLessThanOrEqualTo: '${query.toLowerCase()}\uf8ff')
        .snapshots().map((jsonOfDocs){
          List<SocialUserModel> users = [];
          jsonOfDocs.docs.forEach((element) {
            users.add(SocialUserModel.fromJson(element.data()));
          });
          return users;
    });
}

}
