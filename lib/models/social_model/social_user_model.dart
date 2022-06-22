import 'package:cloud_firestore/cloud_firestore.dart';

class SocialUserModel
{
  String ? name;
   String  ?email;
   String ? phone;
   String ? uId;
  String? token;
  String ? image;
  String ? cover;
  String ? bio;
  FieldValue? dateTime;

  SocialUserModel({
     this.name,  this.token, this.email , this.phone , this.uId, this.image , this.cover , this.bio ,  this.dateTime,
});
  SocialUserModel.fromJson(Map<String,dynamic>?json)
  {
    name = json!['name'];
    email = json['email'];
    token = json['token'];

    phone = json['phone'];

    uId = json['uId'];
    image = json['image'];
    cover = json['cover'];
    bio = json['bio'];

  }
  Map<String,dynamic>toMap()
  {
    return {
      'name':name,
      'email':email,
      'phone':phone,
      'token': token,
      'uId':uId,
      'image':image,
      'cover':cover,
      'bio':bio,
      'dateTime':dateTime

    };
  }

}
