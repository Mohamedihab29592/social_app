


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

///reset pass

class ResetPasswordLoadingState extends SocialLoginStates{}
class ResetPasswordSuccessState extends SocialLoginStates{}
class ResetPasswordErrorState extends SocialLoginStates{}


///facebook state
class CreateFacebookUserLoadingState extends SocialLoginStates{}
class CreateFacebookUserSuccessState extends SocialLoginStates{
final  String uId;
CreateFacebookUserSuccessState(this.uId);
}
class CreateFacebookUserErrorState extends SocialLoginStates{}

///LoginFacebookleUSer State
class LoginFacebookUserLoadingState extends SocialLoginStates{}
class LoginFacebookUserSuccessState extends SocialLoginStates{
  final  String uId;
  LoginFacebookUserSuccessState(this.uId);
}
class LoginFacebookUserErrorState extends SocialLoginStates{}
///End of LoginUser State

