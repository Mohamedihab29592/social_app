

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:socialapp/models/social_model/social_user_model.dart';
import 'package:socialapp/modules/social_login/cubit/states.dart';
import 'package:socialapp/shared/components/components.dart';

import '../../../../layout/socialapp/sociallayout.dart';




class SocialLoginCubit extends Cubit<SocialLoginStates>
{
  SocialLoginCubit() : super(SocialLoginInitialState());
  static SocialLoginCubit get(context) => BlocProvider.of(context);




  void userLogin({
  required String email,
    required String password,
}) {
    emit(SocialLoginLoadingState());

    FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    ).then((value) {

      emit(SocialLoginSuccessState(value.user!.uid));
    }).catchError((error){
      emit(SocialLoginErrorState(error.toString()));
    });
  }


    IconData suffix = Icons.visibility_outlined;
   bool isPassword =true;

  void changePasswordVisibility()
  {
    isPassword = !isPassword;
    suffix =isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(SocialChangePasswordState());

  }

  void createGoogleUser({
    required String? uId,
    required String? name,
    required String? phone,
    required String? email,
    required String? profilePic
  }) {
    SocialUserModel model = SocialUserModel(
      uId: uId,
      name: name,
      phone: phone?? '0000-000-0000',
      email: email,
      dateTime: FieldValue.serverTimestamp(),
      cover: 'https://media.cdnandroid.com/27/54/bb/52/imagen-cartoon-photo-editor-art-filter-2018-1gal.jpg',
      image: profilePic ?? 'https://static.toiimg.com/thumb/resizemode-4,msid-76729536,width-1200,height-900/76729536.jpg',
      bio: 'Write you own bio...',
    );
    FirebaseFirestore.instance.collection('users').doc(uId).set(model.toMap())
        .then((value) {
      emit(CreateGoogleUserSuccessState(uId!));

    }).catchError((error) {
      emit(CreateGoogleUserErrorState());
    });
  }

  bool userExist = false;
  Future <void> isUserExist({
    required String? uId,
    required String? name,
    required String? phone,
    required String? email,
    required String? image

  }) async {
    FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((value) {
      for (var element in value.docs) {
        if(element.id == uId) {
          userExist = true;
        }
      }
      if(userExist == false) {
        createGoogleUser(
            uId: uId,
            name: name,
            phone: phone,
            email: email,
            profilePic: image
        );
      }
      else {
        emit(SocialLoginSuccessState(uId!));

      }
    });
  }
  void getGoogleUserCredentials() async {
    emit(LoginGoogleUserLoadingState());
    GoogleSignIn googleSignIn = GoogleSignIn();
    GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);
    FirebaseAuth.instance.signInWithCredential(credential).then((value) {

      isUserExist(
          uId: value.user!.uid,
          name: value.user!.displayName,
          phone: value.user!.phoneNumber,
          email: value.user!.email,
          image: value.user!.photoURL
      );


    });
  }




  }
