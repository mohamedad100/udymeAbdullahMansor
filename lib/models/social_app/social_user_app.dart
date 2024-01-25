class SocialUserModel{

   String? name;
   String? email;
   String? phone;
   String? uId;
   String? image;
   String? bio;
   String? cover;
   late bool isEmailVerification;
   SocialUserModel({
     this.name,
     this.email,
     this.phone,
     this.uId,
     this.image,
     this.bio,
     this.cover,
     required this.isEmailVerification,
});
   SocialUserModel.fromJson(Map<String,dynamic>json){
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    uId = json['uId'];
    image = json['image'];
    bio = json['bio'];
    cover = json['cover'];
    isEmailVerification = json['isEmailVerification'];
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
       'isEmailVerification':isEmailVerification,
     };

   }
}