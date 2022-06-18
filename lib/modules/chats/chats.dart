


import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/socialapp/cubit/cubit.dart';
import '../../../layout/socialapp/cubit/state.dart';
import '../../../models/social_model/social_user_model.dart';
import '../../../shared/components/components.dart';
import '../chat_details/chat_details.dart';

class Chats extends StatelessWidget {
  const Chats({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context ,state){},
      builder: (context,state){
        return ConditionalBuilder(
         condition:SocialCubit.get(context).users.isNotEmpty ,
          builder: (context)=>ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context,index)=> buildChatItem(SocialCubit.get(context).users[index],context),
              separatorBuilder: (context,state) => myDivider(),
              itemCount: SocialCubit.get(context).users.length),
          fallback: (context)=> Center(child: CircularProgressIndicator()),
        );
      },

    );
  }

  Widget buildChatItem(SocialUserModel model ,context) => InkWell(
        onTap: (){
          navigateTo(context, ChatDetailsScreen(
            userModel: model,
          ));
        },
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(
                    '${model.image}'),
              ),
              SizedBox(width: 15,),
              Text(
                '${model.name}',
                style: TextStyle(height: 1.4),
              ),
            ],
          ),
        ),
      );
}
