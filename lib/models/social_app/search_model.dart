class SearchModel{

  String? name;
  String? email;
  String? phone;
  String? uId;
  String? image;
  String? bio;
  String? cover;
  SearchModel({
    this.name,
    this.email,
    this.phone,
    this.uId,
    this.image,
    this.bio,
    this.cover,
  });
  SearchModel.fromJson(Map<String,dynamic>json){
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    uId = json['uId'];
    image = json['image'];
    bio = json['bio'];
    cover = json['cover'];
  }

  Map<String,dynamic>toMap(){
    return{
      'email':email,
      'name': name,
      'phone':phone,
      'uId':uId,
      'image':image,
      'bio':bio,
      'cover':cover,
    };

  }
}