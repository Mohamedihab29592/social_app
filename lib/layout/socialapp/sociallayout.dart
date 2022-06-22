// ignore_for_file: unnecessary_import

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../modules/new_post/new_post.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/iconbroken.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';

class SocialLayout extends StatelessWidget {

  int initialIndex = 0;

  SocialLayout(this.initialIndex, {Key? key}) : super(key: key);




@override
  Widget build(BuildContext context) {
     return BlocConsumer<SocialCubit , SocialStates>
       (listener: (context,state){
         if (state is SocialNewPostState)
           {
             navigateTo(context, NewPostScreen());
           }
     },
       builder: (context,state)
       {var cubit = SocialCubit.get(context);
         var initialIndex =SocialCubit.get(context).currentIndex;


         return  Scaffold(
           appBar: AppBar(
             title:   Text(cubit.titles[initialIndex],),
             actions: [
               IconButton(onPressed: (){

               }, icon: Icon(IconBroken.Notification,),
               ),
         IconButton(onPressed: (){}, icon: Icon(IconBroken.Search,),
         ),],
           ),
         body: cubit.screens[initialIndex],
           bottomNavigationBar: BottomNavigationBar(
             currentIndex:initialIndex,
             onTap: (index){
               cubit.changeBottomNav(index);

             },
             items:   const [
               BottomNavigationBarItem(icon: Icon(IconBroken.Home,),label: "Home"),
           BottomNavigationBarItem(icon: Icon(IconBroken.Chat,),label: "Chats"),
               BottomNavigationBarItem(icon: Icon(IconBroken.Paper_Upload,),label: "Post"),
               BottomNavigationBarItem(icon: Icon(IconBroken.User,),label: "Users"),
             BottomNavigationBarItem(icon: Icon(IconBroken.Setting,),label: "Settings"),


             ],
           ),
         );
    }
    );

  }
}
