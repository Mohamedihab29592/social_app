import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../layout/socialapp/cubit/cubit.dart';
import '../layout/socialapp/cubit/state.dart';
import '../models/social_model/comment_model.dart';
import '../models/social_model/post_model.dart';
import '../models/social_model/social_user_model.dart';
import '../shared/components/components.dart';
import '../shared/components/constants.dart';
import '../shared/styles/iconbroken.dart';

class CommentsScreen extends StatelessWidget {
  var commentTextControl = TextEditingController();
  var formKey = GlobalKey<FormState>();
  int? likes;

  String? postId;
  String? postUid;

  CommentsScreen({this.postId,  this.likes, this.postUid});

  @override
  Widget build(BuildContext context) {
    String? postId = this.postId;
    return Builder(
      builder: (context) {
        SocialCubit.get(context).getComments(postId);
        SocialCubit.get(context).getUserData(postUid);

        return BlocConsumer<SocialCubit, SocialStates>(
            listener: (context, state) {},
            builder: (context, state) {
              dynamic commentImage = SocialCubit.get(context).commentImage;
              PostModel? post = SocialCubit.get(context).singlePost;
              List<CommentModel> comments = SocialCubit.get(context).comments;
              SocialUserModel? user = SocialCubit.get(context).socialUserModel;
              return Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: true,
                  leading: IconButton(
                    onPressed: () {
                      comments.clear();
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back),
                  ),
                ),
                body: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            // navigateTo(context, WhoLikedScreen(postId));
                          },
                          child: Row(
                            children: const [
                              Icon(
                                IconBroken.Heart,
                                color: Colors.red,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'tap to see who like your post',
                              ),

                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        comments.isNotEmpty
                            ? Expanded(
                                child: ListView.separated(
                                  itemBuilder: (context, index) => buildComment(
                                    comments[index],
                                    context,
                                  ),
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                    height: 20,
                                  ),
                                  itemCount: (SocialCubit.get(context)
                                      .comments
                                      .length),
                                ),
                              )
                            : Expanded(
                                child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      "no comments",
                                    ),
                                  ],
                                ),
                              )),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: SocialCubit.get(context).isCommentImageLoading
                              ? LinearProgressIndicator(
                                  color: Colors.blueAccent,
                                )
                              : myDivider(),
                        ),
                        if (commentImage != null)
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
                                    child: Image.file(commentImage,
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
                                              .popCommentImage();
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
                        SizedBox(
                          height: 45,
                          child: TextFormField(
                              controller: commentTextControl,
                              autofocus: true,
                              textAlignVertical: TextAlignVertical.center,
                              cursorColor: Colors.black,
                              style: TextStyle(color: Colors.black),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "write a Something to share ";
                                }
                                return null;
                              },

                              decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(40),
                                      borderSide: BorderSide.none),
                                  //contentPadding: EdgeInsets.all(10),

                                  hintText: "Write a comment",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  suffixIcon: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                          padding: EdgeInsets.zero,
                                          onPressed: () {
                                            SocialCubit.get(context)
                                                .getCommentImage();
                                          },
                                          icon: Icon(
                                            Icons.camera_alt_outlined,
                                            color: Colors.grey,
                                          )),
                                      IconButton(
                                          padding: EdgeInsets.zero,
                                          onPressed: () {
                                            if (commentImage == null ) {
                                                SocialCubit.get(context)
                                                    .commentPost(
                                                  postId: postId,
                                                  comment: commentTextControl.text,
                                                  date: getDate(),
                                                  time: TimeOfDay.now().format(context),
                                                );
                                              } else {
                                                SocialCubit.get(context)
                                                    .uploadCommentPic(
                                                  postId: postId,
                                                  commentText: commentTextControl
                                                      .text ==
                                                      ''
                                                      ? null
                                                      : commentTextControl.text,
                                                  date: getDate(),
                                                  time: TimeOfDay.now().format(context),
                                                );
                                              }

                                              commentTextControl.clear();
                                            SocialCubit.get(context).popCommentImage();



                                            },
                                          icon: Icon(
                                            Icons.send,
                                            color: Colors.blue,
                                          )),
                                    ],
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey[300],
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(40)))),
                        ),
                      ],
                    )),
              );
            });
      },
    );
  }

  Widget buildComment(
    CommentModel comment,
    context,

  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
                radius: 25, backgroundImage: NetworkImage('${comment.image}')),
            SizedBox(
              width: 5,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                comment.commentText != null && comment.commentImage != null ?
                /// If its (Text & Image) Comment
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey[500],
                                    borderRadius: BorderRadiusDirectional.only(
                                      bottomEnd: Radius.circular(10.0),
                                      topStart: Radius.circular(10.0),
                                      topEnd: Radius.circular(10.0),
                                    )),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 5,
                                    horizontal: 10,),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${comment.name}',
                                        style:
                                            TextStyle(fontWeight: FontWeight.bold),
                                      ),

                                      Text(
                                        '${comment.commentText}',
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                          Container(
                              width: intToDouble(comment.commentImage!['width']) <= 400
                                  ? intToDouble(comment.commentImage!['width'])
                                  : 250,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Image(
                                  image:
                                      NetworkImage(comment.commentImage!['image']))),
                        ],
                      )
                    : comment.commentImage != null
                        ?
                /// If its (Image) Comment
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text( '${comment.name}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  )),
                              Container(
                                  padding: EdgeInsets.all(8),
                                  width: intToDouble(comment.commentImage!['width']) <=
                                          400
                                      ? intToDouble(comment.commentImage!['width'])
                                      : 250,

                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Image(
                                      image: NetworkImage(
                                          comment.commentImage!['image']))),
                            ],
                          ):
                comment.commentText != null ?

                /// If its (Text) Comment
                Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[500],
                        borderRadius: BorderRadiusDirectional.only(
                          bottomEnd: Radius.circular(10.0),
                          topStart: Radius.circular(10.0),
                          topEnd: Radius.circular(10.0),
                        )),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${comment.name}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),

                        Text(
                          '${comment.commentText}',
                        ),
                      ],
                    )
                ):
                SizedBox(
                  height: 0,
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 8.0),
                  child: Text(
                    '${comment.date} at ${comment.time}',
                    style: TextStyle(color: Colors.grey,fontSize: 10),
                  ),
                )
              ],
            ),
          ],
        ),
      ],
    );
  }
}
