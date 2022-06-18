


import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  String? name;
  String? text;
  String? tags;
  String? postImage;
  String? uId;
  String? image;
  int? likes;
  int? comments;
  String? postId;
  String? date;
  String? time;
  FieldValue? dateTime;


  PostModel({
    this.name,
    this.text,
    this.likes,
    this.comments,
    this.uId,
    this.image,
    this.postImage,
    this.postId,
    this.time,
    this.date,
    this.dateTime,

  });

  PostModel.fromJson(Map<String, dynamic>? json) {
    name = json!['name'];
    text = json['text'];
    likes = json['likes'];
    comments = json['comments'];
    postId = json['postId'];
    uId = json['uId'];
    image = json['image'];
    postImage = json['postImage'];
    time = json['time'];
    date = json['date'];


  }





  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'text': text,
      'comments': comments,
      'likes': likes,
      'postId': postId,
      'uId': uId,
      'image': image,
      'postImage': postImage,
      'time':time,
      'date': date,
      'dateTime': dateTime,
    };
  }
}
