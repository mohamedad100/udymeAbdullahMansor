// class CommentModel{
//   String? senderId;
//   String? dateTime;
//   String? text;
//
//   CommentModel({
//     this.senderId,
//     this.dateTime,
//     this.text
// });
//
//   CommentModel.fromJson(Map<String,dynamic>json){
//     senderId=json['senderId'];
//     dateTime=json['dateTime'];
//     text=json['text'];
//
//   }
//   Map<String,dynamic>toMap(){
//   return {
//     'senderId': senderId,
//     'dateTime': dateTime,
//     'text': text,
//
//   };
//   }
// }
/////
class CommentModel{

  String? name;
  String? senderId;
  String? dateTime;
  String? text;
  String? image;

  CommentModel({
    this.name,
    this.senderId,
    this.dateTime,
    this.text,
    this.image,


  });
  CommentModel.fromJson(Map<String,dynamic>json){
    name = json['name'];
    senderId = json['senderId'];
    dateTime = json['dateTime'];
    text = json['text'];
    image = json['image'];

  }

  Map<String,dynamic>toMap(){
    return{
      'name': name,
      'senderId':senderId,
      'dateTime':dateTime,
      'text':text,
      'image':image,

    };

  }
}