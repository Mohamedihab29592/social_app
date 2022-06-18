
import 'package:cloud_firestore/cloud_firestore.dart';

class LikesModel
{
  String?uId;
  String? name;
  String? image;
  FieldValue? dateTime;


  LikesModel({
    this.uId,
    this.name,
    this.image,
    this.dateTime,
  });

  LikesModel.fromJson(Map<String, dynamic>? json){
    uId = json!['uId'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toMap (){
    return {
      'uId' : uId,
      'name':name,
      'image':image,
      'dateTime':dateTime,

    };
  }
}