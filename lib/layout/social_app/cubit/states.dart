abstract class SocialStates{}

class SocialInitialStates extends SocialStates{}

class SocialGetUsersLoadingStates extends SocialStates{}

class SocialGetUsersSuccessStates extends SocialStates{}

class SocialGetUsersErrorStates extends SocialStates{
  final String error;

  SocialGetUsersErrorStates(this.error);
}

//get all users
class SocialGetAllUsersLoadingStates extends SocialStates{}

class SocialGetAllUsersSuccessStates extends SocialStates{}

class SocialGetAllUsersErrorStates extends SocialStates{
  final String error;

  SocialGetAllUsersErrorStates(this.error);
}

//get posts
class SocialGetPostsLoadingStates extends SocialStates{}

class SocialGetPostsSuccessStates extends SocialStates{}

class SocialGetPostsErrorStates extends SocialStates{
  final String error;

  SocialGetPostsErrorStates(this.error);
}
//Like post
class SocialLikePostSuccessStates extends SocialStates{}

class SocialLikePostErrorStates extends SocialStates{
  final String error;

  SocialLikePostErrorStates(this.error);
}
//dis like
class SocialDisLikePostSuccessStates extends SocialStates{}

class SocialDisLikePostErrorStates extends SocialStates{
  final String error;

  SocialDisLikePostErrorStates(this.error);
}
//iLike post
class SocialCommentPostSuccessStates extends SocialStates{}

class SocialCommentPostErrorStates extends SocialStates{
  final String error;

  SocialCommentPostErrorStates(this.error);
}
//
class SocialChangeBottomNavStates extends SocialStates{}

class SocialNewPostStates extends SocialStates{}

class SocialProfileImagePickedSuccessStates extends SocialStates{}

class SocialProfileImagePickedErrorStates extends SocialStates{}

class SocialCoverImagePickedSuccessStates extends SocialStates{}

class SocialCoverImagePickedErrorStates extends SocialStates{}

class SocialUploadProfileImageSuccessStates extends SocialStates{}

class SocialUploadProfileImageErrorStates extends SocialStates{}

class SocialUploadCoverImageSuccessStates extends SocialStates{}

class SocialUploadCoverImageErrorStates extends SocialStates{}

class SocialUserUpdateLoadingStates extends SocialStates{}

class SocialUserUpdateErrorStates extends SocialStates{}

//create post
class SocialCreatePostLoadingStates extends SocialStates{}

class SocialCreatePostSuccessStates extends SocialStates{}

class SocialCreatePostErrorStates extends SocialStates{}

class SocialPostImagePickedSuccessStates extends SocialStates{}

class SocialPostImagePickedErrorStates extends SocialStates{}

class SocialRemovePostImageStates extends SocialStates{}
//chat

class SocialSendMessageSuccessStates extends SocialStates{}

class SocialSendMessageErrorStates extends SocialStates{}

class SocialGetMessageSuccessStates extends SocialStates{}










