import 'package:cloud_firestore/cloud_firestore.dart';

class MessageUserModel
{
  String? senderId;
  String ? receiverId;
  String? time;
  String? date;
  FieldValue? dateTime;
  String ? text;
  Map<String,dynamic>? messageImage;


  MessageUserModel({

    this.receiverId,
    this.senderId,
    this.dateTime,
    this.time,
    this.date,
    this.text,
    this.messageImage,

  });
  MessageUserModel.fromJson(Map<String,dynamic>?json)
  {


  senderId = json!['senderId'];
  receiverId = json['receiverId'];
  messageImage = json['messageImage'];
  time = json['time'];
  date = json['date'];

    text = json['text'];
  }
  Map<String,dynamic>toMap()
  {
    return {

      'senderId':senderId,
      'receiverId':receiverId,
      'messageImage':messageImage,
      'date':date,
      'time':time,

      'dateTime':dateTime,
      'text':text,


    };
  }

}
