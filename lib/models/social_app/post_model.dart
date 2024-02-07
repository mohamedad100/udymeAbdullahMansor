import 'comment_model.dart';

class PostModel{

  String? name;
  String? uId;
  String? image;
  String? dateTime;
  String? text;
  String? postImage;
  List? usersIdsOfLikes;
  List<CommentModel>? comments;

  PostModel({
    this.name,
    this.uId,
    this.image,
    this.dateTime,
    this.text,
    this.postImage,
    this.usersIdsOfLikes,
    this.comments,

  });
  PostModel.fromJson(Map<String,dynamic>json){
    name = json['name'];
    uId = json['uId'];
    image = json['image'];
    dateTime = json['dateTime'];
    text = json['text'];
    postImage = json['postImage'];

  }

  Map<String,dynamic>toMap(){
    return{
      'name': name,
      'uId':uId,
      'image':image,
      'dateTime':dateTime,
      'postImage':postImage,
      'text':text,

    };

  }
}