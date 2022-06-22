import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/socialapp/cubit/cubit.dart';
import '../../../layout/socialapp/cubit/state.dart';
import '../../../models/social_model/message_model.dart';
import '../../../models/social_model/social_user_model.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/styles/iconbroken.dart';

class ChatDetailsScreen extends StatelessWidget {
  SocialUserModel? userModel;
  var messageTextControl = TextEditingController();


  ChatDetailsScreen({Key? key, this.userModel}) : super(key: key);
  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        SocialCubit.get(context).getMessage(receiverId: userModel!.uId!);

        return BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {},
          builder: (context, state) {
            dynamic messageImage = SocialCubit.get(context).messageImage;
            SocialUserModel? user = SocialCubit.get(context).socialUserModel;

            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20.0,
                      backgroundImage: NetworkImage(userModel!.image!),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(userModel!.name!),
                  ],
                ),
              ),
              body: ConditionalBuilder(
                condition: SocialCubit.get(context).message.isEmpty ||
                    SocialCubit.get(context).message.isNotEmpty,
                builder: (context) => Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      myDivider(),
                      SizedBox(
                        height: 15,
                      ),
                      Expanded(
                        child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              var message =
                                  SocialCubit.get(context).message[index];
                              if (SocialCubit.get(context)
                                      .socialUserModel!
                                      .uId ==
                                  message.senderId) {
                                return buildMyMessage(message, context);
                              } else {
                                return buildMessage(message, context);
                              }
                            },
                            separatorBuilder: (context, state) => SizedBox(
                                  height: 15,
                                ),
                            itemCount: SocialCubit.get(context).message.length),
                      ),
                      if (SocialCubit.get(context).isMessageImageLoading == true)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: LinearProgressIndicator(
                          color: Colors.blueAccent,
                      ),
                        ),

                      if (messageImage != null)
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.only(bottom: 8.0),
                          child: Align(
                            alignment: AlignmentDirectional.topStart,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: Image.file(messageImage,
                                      fit: BoxFit.cover, width: 100),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                SizedBox(
                                  width: 30,
                                  height: 30,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.grey[300],
                                    child: IconButton(
                                      onPressed: () {
                                        SocialCubit.get(context)
                                            .popMessageImage();
                                      },
                                      icon: Icon(Icons.close),
                                      iconSize: 15,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey.shade500,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: TextFormField(
                                  controller: messageController,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "type your message here ..."),
                                ),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  SocialCubit.get(context).getMessageImage();
                                },
                                icon: Icon(
                                  Icons.camera_alt_outlined,
                                  color: Colors.grey,
                                )),
                            Container(
                              color: Colors.blue,
                              height: 50,
                              child: MaterialButton(
                                onPressed: () {
                                  if (messageImage == null) {
                                    SocialCubit.get(context).sendMessage(
                                      receiverId: userModel!.uId!,
                                      text: messageController.text,
                                      date: getDate(),
                                      time: TimeOfDay.now().format(context),
                                    );
                                  } else {
                                    SocialCubit.get(context).uploadMessagePic(
                                      receiverId: userModel!.uId!,
                                      text: messageController.text == ''
                                          ? null
                                          : messageController.text,
                                      date: getDate(),
                                      time: TimeOfDay.now().format(context),
                                    );
                                  }

                                  messageController.clear();
                                  SocialCubit.get(context).popMessageImage();
                                },
                                minWidth: 1.0,
                                child: Icon(
                                  IconBroken.Send,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                fallback: (context) =>
                    Center(child: CircularProgressIndicator()),
              ),
            );
          },
        );
      },
    );
  }
}

Widget buildMessage(MessageUserModel message, context) =>
    Align(
      alignment: AlignmentDirectional.topStart,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              message.text != null && message.messageImage != null
                  ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      padding: const EdgeInsets.all(8),
                      width: intToDouble(
                          message.messageImage!['width']) <
                          150
                          ? intToDouble(
                          message.messageImage!['width'])
                          : 150,

                      decoration: BoxDecoration(

                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                          )),
                      child: imagePreview(
                          message.messageImage!['image'])),
                  Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 8),
                      decoration: BoxDecoration(
                          color:Colors.grey[500],
                          borderRadius: const BorderRadiusDirectional.only(
                            topStart: Radius.circular(10.0),
                            bottomEnd: Radius.circular(10.0),
                            topEnd: Radius.circular(10.0),
                          )),
                      child: Text('${message.text}',
                        )),
                ],
              )
                  : message.messageImage != null
                  ? Container(
                  padding: const EdgeInsets.all(8),
                  width: intToDouble(
                      message.messageImage!['width']) <
                      230
                      ? intToDouble(message.messageImage!['width'])
                      : 230,
                  height: intToDouble(
                      message.messageImage!['height']) <
                      250
                      ? intToDouble(message.messageImage!['height'])
                      : 250,

                  child:
                  imagePreview(message.messageImage!['image']))
                  : message.text != null
                  ? Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: Colors.grey[500],
                      borderRadius: const BorderRadiusDirectional.only(
                        topStart: Radius.circular(10.0),
                        bottomEnd: Radius.circular(10.0),
                        topEnd: Radius.circular(10.0),
                      )),
                  child: Text('${message.text}',
                      ))
                  : const SizedBox(
                height: 0,
                width: 0,
              )
            ],
          ),
          Text(
            '${message.date} at ${message.time}',
            style: TextStyle(color: Colors.grey,fontSize: 10),
          ),
        ],
      ),
    );

Widget buildMyMessage(MessageUserModel message, context) =>
    Align(
      alignment: AlignmentDirectional.topEnd,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              message.text != null && message.messageImage != null
                  ? Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                      width: intToDouble(
                          message.messageImage!['width']) <
                          230
                          ? intToDouble(
                          message.messageImage!['width'])
                          : 230,

                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: imagePreview(
                              message.messageImage!['image']))),
                  Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadiusDirectional.only(
                            bottomStart: Radius.circular(10.0),
                            topStart: Radius.circular(10.0),
                            topEnd: Radius.circular(10.0),
                          )),

                      child: Text('${message.text}',
                          style: const TextStyle(color: Colors.white))),
                ],
              )
                  : message.messageImage != null
                  ? Container(
                  padding: const EdgeInsets.all(8),
                  width: 150,

                  child:
                  imagePreview(message.messageImage!['image']))
                  : message.text != null
                  ? Container(
                  padding: const EdgeInsets.all(13),
                  decoration: BoxDecoration(
                      color:  Colors.blueAccent,
                      borderRadius: BorderRadiusDirectional.only(
                        bottomStart: Radius.circular(10.0),
                        topStart: Radius.circular(10.0),
                        topEnd: Radius.circular(10.0),
                      )),
                  child: Text('${message.text}',
                      style: const TextStyle(color: Colors.white)))
                  : const SizedBox(
                height: 0,
                width: 0,
              )
            ],
          ),

          Text(
            '${message.date} at ${message.time}',
            style: TextStyle(color: Colors.grey,fontSize: 10),
          ),
        ],
      ),
    );
