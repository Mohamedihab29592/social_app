import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/socialapp/cubit/cubit.dart';
import '../../../layout/socialapp/cubit/state.dart';
import '../../../layout/socialapp/sociallayout.dart';
import '../../../models/social_model/post_model.dart';
import '../../../models/social_model/social_user_model.dart';
import '../../../shared/components/components.dart';
import '../../../shared/styles/iconbroken.dart';
import '../../new_post/new_post.dart';
import '../CommentsScreen.dart';
import '../settings/Profile_screen.dart';

class Feeds extends StatelessWidget {

  const Feeds({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        SocialUserModel? userModel = SocialCubit.get(context).socialUserModel;
        context;
        return ConditionalBuilder(
          condition: SocialCubit.get(context).posts.isNotEmpty &&
              SocialCubit.get(context).socialUserModel != null,
          builder: (context) => SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 5,
                  margin: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              navigateTo(context,SocialLayout(4));
                            },
                            child: CircleAvatar(
                                radius: 22,
                                backgroundImage:
                                NetworkImage('${userModel!.image}')),
                          ),

                          TextButton(
                            onPressed: () {
                              navigateTo(context, NewPostScreen());
                            },
                            child: SizedBox(
                              width: 200,
                              child: Text("What is in your mind ...",
                                style: const TextStyle(color: Colors.grey),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ),
                        ],
                      ),

                      Row(
                        children: [

                          Expanded(
                            child: TextButton(
                                onPressed: () {

                                   navigateTo(context, NewPostScreen());

                                },
                                child: Row(
                                  children: const [
                                    Icon(IconBroken.Image),
                                    SizedBox(width: 5,),
                                    Text("image/video",
                                        ),
                                  ],
                                )),
                          ),
                         Spacer(),

                          Expanded(
                            child: TextButton(
                                onPressed: () {},
                                child: Row(
                                  children: const [
                                    Icon(
                                      Icons.tag,
                                      color: Colors.red,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "#TAGS",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                )),
                          ),



                        ],
                      )
                    ],
                  ),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => buildPost(SocialCubit.get(context).posts[index],userModel,context, index,),
                  separatorBuilder: (context, index) => SizedBox(
                    height: 8,
                  ),
                  itemCount: (SocialCubit.get(context).posts.length),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          fallback: (context) => Center(child: Text('no posts yet')),
        );
      },
    );
  }

  Widget buildPost(PostModel model, SocialUserModel userModel ,context, index,) => Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 5,
        margin: EdgeInsets.zero,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 13),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      // if (postModel.uId != SocialCubit.get(context).model!.uID)
                      //   navigateTo(context, FriendsProfileScreen(postModel.uId));
                      // else
                      //   navigateTo(context, SocialLayout(3));
                    },
                    child: CircleAvatar(
                        radius: 22,
                        backgroundImage: NetworkImage('${model.image}')),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                          onTap: () {
                            // if (postModel.uId != SocialCubit.get(context).model!.uID)
                            //   navigateTo(context, FriendsProfileScreen(postModel.uId));
                            // else
                            //   navigateTo(context, SocialLayout(3));
                          },
                          child: Text(
                            '${model.name}',
                          )),
                      Text(
                        '${model.date} at ${model.time}',
                        style: TextStyle(color: Colors.grey),
                      ),

                    ],
                  ),
                  Spacer(),
                  IconButton(
                        onPressed: () {
                          // scaffoldKey.currentState!.showBodyScrim(true, 0.5);
                          // scaffoldKey.currentState!.
                          // showBottomSheet((context) => Card(
                          //   clipBehavior: Clip.antiAliasWithSaveLayer,
                          //   shape: OutlineInputBorder(
                          //       borderRadius: BorderRadius.only(
                          //           topRight: Radius.circular(15),
                          //           topLeft: Radius.circular(15)),borderSide: BorderSide.none),
                          //   elevation: 15,
                          //
                          //   margin: EdgeInsets.zero,
                          //   child: Padding(
                          //     padding:
                          //     const EdgeInsets.symmetric(horizontal: 15),
                          //     child: Column(
                          //       mainAxisSize: MainAxisSize.min,
                          //       crossAxisAlignment: CrossAxisAlignment.center,
                          //       children: [
                          //         Icon(Icons.drag_handle),
                          //         CircleAvatar(
                          //           backgroundImage: NetworkImage(
                          //               '${postModel.image}'),
                          //           radius: 25,
                          //         ),
                          //         SizedBox(
                          //           height: 10,
                          //         ),
                          //         Text('${postModel.text}', textAlign: TextAlign.center,),
                          //         SizedBox(height:10,),
                          //         Text('This Post was shared on '+'${postModel.dateTime} ',
                          //           style: TextStyle(color: Colors.grey), textAlign: TextAlign.center,),
                          //         SizedBox(
                          //           height: 15,
                          //         ),
                          //         InkWell(
                          //           onTap: (){
                          //             //Scaffold.of(context)._currentBottomSheet!.close();
                          //             // SocialCubit.get(context).deletePost(postModel.postId);
                          //           },
                          //           child: Row(
                          //             children: const [
                          //               CircleAvatar(
                          //                 child:
                          //                 Icon(Icons.delete_outline_outlined),
                          //               ),
                          //               SizedBox(
                          //                 width: 15,
                          //               ),
                          //               Text(
                          //                 'Delete post',
                          //                 style: TextStyle(fontSize: 20),
                          //               ),
                          //             ],
                          //           ),
                          //         ),
                          //         SizedBox(
                          //           height: 15,
                          //         ),
                          //         InkWell(
                          //           onTap: (){
                          //             // Scaffold.of(context).currentBottomSheet!.close();
                          //           },
                          //           child: Row(
                          //             children: const [
                          //               CircleAvatar(
                          //                 child:
                          //                 Icon(Icons.edit_outlined),
                          //               ),
                          //               SizedBox(
                          //                 width: 15,
                          //               ),
                          //               Text(
                          //                 'Edit Post',
                          //                 style: TextStyle(fontSize: 20),
                          //               ),
                          //             ],
                          //           ),
                          //         ),
                          //         SizedBox(
                          //           height: 15,
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          //   shape: OutlineInputBorder(
                          //       borderRadius: BorderRadius.only(
                          //           topRight: Radius.circular(15),
                          //           topLeft: Radius.circular(15)),borderSide: BorderSide.none),
                          // ).closed.then((value) {
                          //   scaffoldKey.currentState!.showBodyScrim(false, 1);
                          // });
                        },
                        icon: Icon(Icons.more_horiz_outlined))
                ],
              ),
              myDivider(),
              model.postImage != null
                  ? Text(
                      '${model.text}',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    )
                  : Text('${model.text}', style: TextStyle(fontSize: 20)),
              if (model.postImage != null)
                Padding(
                    padding: const EdgeInsetsDirectional.only(top: 10),
                    child: Image(
                      image: NetworkImage('${model.postImage}'),
                    )),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.only(end: 6.0),
                    child: SizedBox(
                      height: 20,
                      child: MaterialButton(
                        onPressed: () {},
                        minWidth: 1.0,
                        padding: EdgeInsets.zero,
                        child: Text(
                          "#Software",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {},
                    child: Row(

                      children: [
                        Icon(
                          IconBroken.Heart,
                          color: Colors.red,
                          size: 20,
                        ),
                        Text(
                          '${model.likes}',
                          style: TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  //if(model.comments != 0)
                  Spacer(),
                  InkWell(
                      onTap: () {
                        navigateTo(
                            context,
                            CommentsScreen(likes: model.likes, postId: model.postId,postUid: model.uId,));
                      },
                      child: Row(

                        mainAxisAlignment: MainAxisAlignment.end,
                        children:  [
                          Icon(
                            IconBroken.Chat,
                            color: Colors.amber,
                            size: 20,
                          ),
                          Text('${model.comments} ', style: TextStyle(fontSize: 10)),
                          Text(
                            "Comments",
                            style: TextStyle(fontSize: 10),
                          ),
                        ],
                      )),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              myDivider(),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        navigateTo(
                          context,
                          CommentsScreen(likes: model.likes, postId: model.postId,postUid: model.uId,),
                        );
                      },
                      child: Row(

                        children: [

                          CircleAvatar(
                              radius: 13,
                              backgroundImage: NetworkImage('${userModel.image}')),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "Write a comment",
                            style: TextStyle(color: Colors.grey, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      SocialUserModel ? postUser = SocialCubit.get(context).socialUserModel;
                      await SocialCubit.get(context).likedByMe(
                          postUser: postUser,
                          context: context,
                          postModel: model,
                          postId: model.postId
                      );

                    },
                    child: Row(
                      children: const [
                        Icon(
                          IconBroken.Heart,
                          color: Colors.red,
                          size: 20,
                        ),
                        Text(
                          ' Like',
                          style: TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  PopupMenuButton(
                    // color: SocialCubit.get(context).backgroundColor.withOpacity(1),
                    onSelected: (value) {
                      if (value == 'Share') {
                        // SocialCubit.get(context).createNewPost(
                        //     name: SocialCubit.get(context).model!.name,
                        //     profileImage: SocialCubit.get(context).model!.profilePic,
                        //     postText: postModel.postText,
                        //     postImage: postModel.postImage,
                        //     date: getDate() ,
                        //     time: TimeOfDay.now().format(context).toString()
                        // ) ;
                      }
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(
                          value: 'Share',
                          child: Row(
                            children: const [
                              Icon(Icons.share, color: Colors.green),
                              Text(
                                "Share now",
                              ),
                            ],
                          ))
                    ],
                    child: Row(
                      children: const [
                        Icon(
                          Icons.share,
                          color: Colors.green,
                          size: 20,
                        ),
                        Text(
                          "Share",
                          style: TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      );
}
