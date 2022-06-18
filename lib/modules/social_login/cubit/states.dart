


abstract class SocialLoginStates{}

class SocialLoginInitialState extends SocialLoginStates{}
class SocialLoginLoadingState extends SocialLoginStates{}
class SocialLoginSuccessState extends SocialLoginStates{
  late final String uId;
  SocialLoginSuccessState(this.uId);

}
class SocialLoginErrorState extends SocialLoginStates{
  final String error;
  SocialLoginErrorState(this.error);
}

class SocialChangePasswordState extends SocialLoginStates{}
///CreateGoogleUSer State
class CreateGoogleUserLoadingState extends SocialLoginStates{}
class CreateGoogleUserSuccessState extends SocialLoginStates{
  final  String uId;
  CreateGoogleUserSuccessState(this.uId);
}
class CreateGoogleUserErrorState extends SocialLoginStates{}
///End of CreateUser State
///LoginGoogleUSer State
class LoginGoogleUserLoadingState extends SocialLoginStates{}
class LoginGoogleUserSuccessState extends SocialLoginStates{
  final  String uId;
  LoginGoogleUserSuccessState(this.uId);
}
class LoginGoogleUserErrorState extends SocialLoginStates{}
///End of LoginUser State





