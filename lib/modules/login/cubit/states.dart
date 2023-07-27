abstract class SocialLoginStates {}

class SocialLoginInitState extends SocialLoginStates {}

class SocialUserLoginLoadingState extends SocialLoginStates {}

class SocialUserLoginSuccessState extends SocialLoginStates
{
  final String uId ;

  SocialUserLoginSuccessState(this.uId);
}

class SocialUserLoginErrorState extends SocialLoginStates
{
  final String error ;

  SocialUserLoginErrorState(this.error);
}