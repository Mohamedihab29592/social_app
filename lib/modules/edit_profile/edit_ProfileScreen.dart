
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/socialapp/cubit/cubit.dart';
import '../../layout/socialapp/cubit/state.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/iconbroken.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var bioController = TextEditingController();


    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder:(context,state){
        var socialUserModel = SocialCubit.get(context).socialUserModel;
        var profileImage = SocialCubit.get(context).profileImage;
        var coverImage = SocialCubit.get(context).coverImage;
        nameController.text = socialUserModel!.name!;
        phoneController.text = socialUserModel.phone!;
        bioController.text = socialUserModel.bio!;
        return Scaffold(
          appBar: defaultAppBar(
              context :context,
              title: 'Edit Profile ',
              actions: [
                defaultTextButton(function:(){
                  SocialCubit.get(context).updateUser(name: nameController.text, phone: phoneController.text, bio: bioController.text);


                },
                  text: 'Update',
                ),

              ]
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                    if (state is SocialUserUpdateLoadingState)
                  LinearProgressIndicator(),
                  if (state is SocialUserUpdateLoadingState)

                  SizedBox(height: 10,),
                  SizedBox(
                    height: 180,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 140,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(topLeft:Radius.circular(4),topRight:Radius.circular(4) ),
                                    image: DecorationImage(
                                        image:  (coverImage == null ? NetworkImage(
                                            '${socialUserModel.cover}') : FileImage(coverImage))as ImageProvider,
                                        fit: BoxFit.cover)),
                              ),
                              IconButton(icon:CircleAvatar(
                                  radius: 20,child: Icon(IconBroken.Camera,size: 16,)) ,onPressed: (){ SocialCubit.get(context).getCoverImage();},),
                            ],
                          ),
                          alignment: AlignmentDirectional.topCenter,
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [

                            CircleAvatar(
                              radius: 64,
                              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 60,
                                backgroundImage: (profileImage == null ? NetworkImage(
                                    '${socialUserModel.image}') : FileImage(profileImage))as ImageProvider,
                              ),
                            ),
                            IconButton(icon:CircleAvatar(
                                radius: 20,child: Icon(IconBroken.Camera,size: 16,)) ,onPressed: (){
                              SocialCubit.get(context).getProfileImage();
                            },),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15,),

                  if(SocialCubit.get(context).profileImage!= null ||SocialCubit.get(context).coverImage != null )

                  Row(
                    children: [
                      if (SocialCubit.get(context).profileImage!= null)
                      Expanded(
                          child: Column(
                            children: [
                              defaultButton(text: 'Upload profile  ', onTap: (){
                                SocialCubit.get(context).uploadProfileImage(name: nameController.text, phone: phoneController.text, bio: bioController.text);
                              },
                              ),
                              SizedBox(height: 5,),
                              if (state is SocialUploadProfileImageLoadingState)
                              LinearProgressIndicator(),
                            ],
                          ),


                      ),
                      SizedBox(width: 5,),


                      if (SocialCubit.get(context).coverImage!= null)
                        Expanded(
                          child: Column(
                            children: [
                              defaultButton(text: 'Upload Cover  ', onTap: (){
                                SocialCubit.get(context).uploadCoverImage(name: nameController.text, phone: phoneController.text, bio: bioController.text);
                              },
                              ),
                               SizedBox(height: 5,),
                               if (state is SocialUploadCoverImageLoadingState)
                                 LinearProgressIndicator(),

                            ],

                          ))
                    ],
                  ),

                  SizedBox(height: 15,),
                  defaultFormField(controller: nameController, keyboardType: TextInputType.name,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2.0),

                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2.0),
                    ),
                      validate:(value)
                      {
                    if (value!.isEmpty)
                      {
                        return 'name must not be empty !!';
                      }
                    return null;
                  } ,labelText: 'Name', prefix: IconBroken.User, context: context, ),
                  SizedBox(height: 15,),
                  defaultFormField(controller: phoneController, keyboardType: TextInputType.phone,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2.0),

                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2.0),
                    ),
                    validate:(value)
                    {
                      if (value!.isEmpty)
                      {
                        return 'Phone must not be empty !!';
                      }
                      return null;
                    } ,labelText: 'Phone', prefix: IconBroken.Call, context: context, ),
                  SizedBox(height: 15,),
                  defaultFormField(controller: bioController, keyboardType: TextInputType.text,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2.0),

                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2.0),
                    ),
                    validate:(value)
                    {
                      if (value!.isEmpty)
                      {
                        return 'bio must not be empty !!';
                      }
                      return null;
                    } ,labelText: 'Bio', prefix: IconBroken.Info_Circle, context: context, ),

                ],
              ),
            ),
          ),


        );
      },

    );
  }
}
