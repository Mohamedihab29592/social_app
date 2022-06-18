import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/socialapp/cubit/cubit.dart';
import '../../layout/socialapp/cubit/state.dart';
import '../../layout/socialapp/sociallayout.dart';
import '../../models/social_model/post_model.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shared/styles/iconbroken.dart';

class NewPostScreen extends StatelessWidget {
  var textController = TextEditingController();
  String? postId;
  PostModel? postModel;

  NewPostScreen({Key? key,this.postId,this.postModel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SocialCreatePostSuccessState)
        {
          navigateTo(context, SocialLayout(0));
          SocialCubit.get(context).currentIndex = 0;
        }
      },
      builder: (context, state) {

        var socialUserModel = SocialCubit.get(context).socialUserModel;


        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Create Post',
            actions: [
              defaultTextButton(
                text: 'post',
                function: () {
                  if (SocialCubit.get(context).postImage == null) {
                    SocialCubit.get(context).createPost(
                      name: socialUserModel!.name,
                     postText:  textController.text,
                        image: socialUserModel.image,
                        date: getDate(),
                  time: DateFormat.jm().format(DateTime.now()),

                    );
                  } else {
                    SocialCubit.get(context).uploadPost(
                        name: socialUserModel!.name,
                        postText:  textController.text,
                        image: socialUserModel.image,
                        date: getDate(),
                  time: DateFormat.jm().format(DateTime.now()),);
                  }
                },
              )
            ],
          ),

          body: Padding(

            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                if (state is SocialCreatePostLoadingState)
                  LinearProgressIndicator(),
                if (state is SocialCreatePostLoadingState)
                  SizedBox(
                    height: 10,
                  ),
                Row(
                  children:  [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(
                          '${socialUserModel!.image}'),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Text(
                        '${socialUserModel.name}',
                        style: TextStyle(height: 1.4),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                      hintText: 'What is on your mind ...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                if (SocialCubit.get(context).postImage != null)
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        height: 140,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            image: DecorationImage(
                                image: FileImage(
                                    SocialCubit.get(context).postImage!),
                                fit: BoxFit.cover)),
                      ),
                      IconButton(
                        icon: CircleAvatar(
                            radius: 20,
                            child: Icon(
                              Icons.close,
                              size: 16,
                            )),
                        onPressed: () {
                          SocialCubit.get(context).removePostImage();
                        },
                      ),
                    ],
                  ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          SocialCubit.get(context).getPostImage();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(IconBroken.Image),
                            SizedBox(
                              width: 5,
                            ),
                            Text('add photo'),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: Text('# tags'),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
