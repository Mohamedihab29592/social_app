import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/socialapp/cubit/cubit.dart';
import '../../../layout/socialapp/cubit/state.dart';
import '../../../shared/components/components.dart';
import '../../../shared/styles/changeThemeButton/changeThemeButton.dart';
import '../../../shared/styles/iconbroken.dart';
import '../edit_profile/edit_ProfileScreen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context,state){},
      builder: (context,state)
        {
          var socialUserModel = SocialCubit.get(context).socialUserModel;
          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  SizedBox(
                    height: 180,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          child: Container(
                            height: 140,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(topLeft:Radius.circular(4),topRight:Radius.circular(4) ),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        '${socialUserModel!.cover}'),
                                    fit: BoxFit.cover)),
                          ),
                          alignment: AlignmentDirectional.topCenter,
                        ),
                        CircleAvatar(
                          radius: 64,
                          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                          child: CircleAvatar(
                            radius: 60,
                            backgroundImage: NetworkImage(
                                '${socialUserModel.image}'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5,),
                  Text(
                    '${socialUserModel.name}',
                    style:Theme.of(context).textTheme.bodyText1,
                  ),
                  Text(
                    '${socialUserModel.bio}',
                    style:Theme.of(context).textTheme.caption,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            child: Column(
                              children: [
                                Text(
                                  '100',
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                                Text(
                                  'Posts',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],

                            ),
                            onTap: (){},
                          ),
                        ),

                        Expanded(
                          child: InkWell(
                            child: Column(
                              children: [
                                Text(
                                  '265',
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                                Text(
                                  'Photos',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],

                            ),
                            onTap: (){},
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            child: Column(
                              children: [
                                Text(
                                  '10K',
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                                Text(
                                  'Followers',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],

                            ),
                            onTap: (){},
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            child: Column(
                              children: [
                                Text(
                                  '103',
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                                Text(
                                  'Followings',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],

                            ),
                            onTap: (){},
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(

                          child:const Text('Add Photos',style: TextStyle(color: Colors.blue),) , onPressed: (){},
                          style:OutlinedButton.styleFrom(primary: Colors.grey)
                        ),

                      ),
                      SizedBox(width: 10,),
                      OutlinedButton(

                        child:Icon(IconBroken.Edit, size:16,color: Colors.blue,) , onPressed: (){
                          navigateTo(context, EditProfileScreen(),);
                      },
                          style:OutlinedButton.styleFrom(primary: Colors.grey)

                      ),

                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(

                      children: [
                        Row(

                          children: [

                            Icon(Icons.dark_mode_outlined,size: 20,),
                            Text( '  Night Mode',style: TextStyle(fontSize: 15),),
                            Spacer(),
                            SwitchWidget(),
                          ],
                        ),
                        Container(

                          width: double.infinity,
                          padding: EdgeInsets.all(10),
                          height: 60,
                          child: InkWell(
                            onTap: (){
                              SocialCubit.get(context).signOut(context);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children:
                              const [
                                Icon(Icons.power_settings_new,size: 20,),
                                SizedBox(width: 10,),
                                Text('SignOut',style: TextStyle(fontSize: 15),)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          );
        }


    );
  }
}
