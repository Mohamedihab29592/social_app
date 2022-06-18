import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/modules/social_app/social_register/cubit/states.dart';
import '../../../../models/social_model/social_user_model.dart';




class SocialRegisterCubit extends Cubit<SocialRegisterStates>
{
  SocialRegisterCubit() : super(SocialRegisterInitialState());
  static SocialRegisterCubit get(context) => BlocProvider.of(context);




  void userRegister({
    required String email,
    required String name,
    required String phone,
    required String password,

  })
  {
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
    ).then((value) {
      if (kDebugMode) {
        print(value.user!.email);
      }
      if (kDebugMode) {
        print(value.user!.uid);
      }
      userCreate(name: name,
      uId: value.user!.uid,
      email: email,
      phone: phone,
        bio:'write your bio....',
        image: 'https://image.freepik.com/free-photo/happy-man-wearing-clothing-color-year-2022_23-2149217417.jpg',
        cover: 'https://image.freepik.com/free-photo/hands-isolated-illuminating-color_23-2148791658.jpg',
        isEmailVerified: false,
      );
    })
    .catchError((error){
      if (kDebugMode) {
        print(error.toString());
      }
      emit(SocialRegisterErrorState(error.toString()));
    });
  }

  void userCreate({
    required String email,
    required String name,
    required String phone,
    required String uId,
    required String image,
    required String cover,
    required String bio,
    required bool isEmailVerified,
})
  {
    SocialUserModel model = SocialUserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      image:'https://image.freepik.com/free-photo/happy-man-wearing-clothing-color-year-2022_23-2149217417.jpg',
      cover:'https://image.freepik.com/free-photo/hands-isolated-illuminating-color_23-2148791658.jpg',
      bio:'write your bio....',

    );
  FirebaseFirestore.instance.collection('users').doc(uId).set(model.toMap()).then((value) {
    emit(SocialCreateUserSuccessState(uId));
  }).catchError((error)
        {
          emit(SocialCreateUserErrorState(error.toString()));

        });
  }



  IconData suffix = Icons.visibility_outlined;
  bool isPassword =true;

  void changePasswordVisibility()
  {
    isPassword = !isPassword;
    suffix =isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(SocialAddPasswordStatue());

  }


}
