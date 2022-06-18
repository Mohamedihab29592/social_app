

abstract class SocialRegisterStates{}

class SocialRegisterInitialState extends SocialRegisterStates{}
class SocialRegisterLoadingState extends SocialRegisterStates{}
class SocialRegisterSuccessState extends SocialRegisterStates{
  late final String uId;
  SocialRegisterSuccessState(this.uId);
}
class SocialRegisterErrorState extends SocialRegisterStates{
  final String error;
  SocialRegisterErrorState(this.error);
}




class SocialCreateUserSuccessState extends SocialRegisterStates{
  late final String uId;
  SocialCreateUserSuccessState(this.uId);
}
class SocialCreateUserErrorState extends SocialRegisterStates{
  final String error;
  SocialCreateUserErrorState(this.error);
}




class SocialAddPasswordStatue extends SocialRegisterStates{}