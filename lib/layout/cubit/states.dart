abstract class SocialCubitStates {}

class SocialCubitInitState extends SocialCubitStates {}

class SocialCubitChangeCurrentIndexState extends SocialCubitStates {}

class SocialCubitLogOutState extends SocialCubitStates {}

class SocialGetUserLoadingState extends SocialCubitStates {}

class SocialGetUserSuccessState extends SocialCubitStates {}

class SocialGetUserErrorState extends SocialCubitStates
{
  final String error ;

  SocialGetUserErrorState(this.error);
}

class SocialChangeBotNavBarState extends SocialCubitStates {}
class SocialAddPostState extends SocialCubitStates {}

class SocialProfileImagePickedSuccessState extends SocialCubitStates {}

class SocialProfileImagePickedErrorState extends SocialCubitStates {}

class SocialCoverImagePickedSuccessState extends SocialCubitStates {}

class SocialCoverImagePickedErrorState extends SocialCubitStates {}

class SocialUploadProfileImageSuccessState extends SocialCubitStates {}

class SocialUploadProfileImageErrorState extends SocialCubitStates {}

class SocialUploadCoverImageSuccessState extends SocialCubitStates {}

class SocialUploadCoverImageErrorState extends SocialCubitStates {}

class SocialUpdateUserErrorState extends SocialCubitStates {}

class SocialUpdateUserLoadingState extends SocialCubitStates {}

// create post

class SocialCreatePostLoadingState extends SocialCubitStates {}

class SocialCreatePostErrorState extends SocialCubitStates {}

class SocialCreatePostSuccessState extends SocialCubitStates {}

class SocialPostImagePickedSuccessState extends SocialCubitStates {}

class SocialPostImagePickedErrorState extends SocialCubitStates {}

class SocialDeletePostImageState extends SocialCubitStates {}

class SocialGetPostLoadingState extends SocialCubitStates {}

class SocialGetPostSuccessState extends SocialCubitStates {}

class SocialGetPostErrorState extends SocialCubitStates
{
  final String error ;

  SocialGetPostErrorState(this.error);
}

class SocialGetProfilePostLoadingState extends SocialCubitStates {}

class SocialGetProfilePostSuccessState extends SocialCubitStates {}

class SocialGetProfilePostErrorState extends SocialCubitStates
{
  final String error ;

  SocialGetProfilePostErrorState(this.error);
}

class SocialGetSavedPostLoadingState extends SocialCubitStates {}

class SocialGetSavedPostSuccessState extends SocialCubitStates {}

class SocialGetSavedPostErrorState extends SocialCubitStates
{
  final String error ;

  SocialGetSavedPostErrorState(this.error);
}

class SocialGetPostDataLoadingState extends SocialCubitStates {}

class SocialGetPostDataSuccessState extends SocialCubitStates {}

class SocialGetPostDataErrorState extends SocialCubitStates
{
  final String error ;

  SocialGetPostDataErrorState(this.error);
}

class SocialCreateProfilePostLoadingState extends SocialCubitStates {}

class SocialCreateProfilePostSuccessState extends SocialCubitStates {}

class SocialCreateProfilePostErrorState extends SocialCubitStates
{
  final String error ;

  SocialCreateProfilePostErrorState(this.error);
}

class SocialGetAllUsersLoadingState extends SocialCubitStates {}

class SocialGetAllUsersSuccessState extends SocialCubitStates {}

class SocialGetAllUsersErrorState extends SocialCubitStates
{
  final String error ;

  SocialGetAllUsersErrorState(this.error);
}

class SocialLikePostLoadingState extends SocialCubitStates {}

class SocialLikePostSuccessState extends SocialCubitStates {}

class SocialLikePostErrorState extends SocialCubitStates
{
  final String error ;

  SocialLikePostErrorState(this.error);
}

class SocialCommentPostLoadingState extends SocialCubitStates {}

class SocialCommentPostSuccessState extends SocialCubitStates {}

class SocialCommentPostErrorState extends SocialCubitStates
{
  final String error ;

  SocialCommentPostErrorState(this.error);
}

class SocialSendMessageSuccessState extends SocialCubitStates {}

class SocialSendMessageErrorState extends SocialCubitStates {}

class SocialGetMessageSuccessState extends SocialCubitStates {}

class SocialGetMessageErrorState extends SocialCubitStates {}

class SocialSavePostLoadingState extends SocialCubitStates {}

class SocialSavePostSuccessState extends SocialCubitStates {}

class SocialSavePostErrorState extends SocialCubitStates {}

class SocialDeletePostLoadingState extends SocialCubitStates {}

class SocialDeletePostSuccessState extends SocialCubitStates {}

class SocialDeletePostErrorState extends SocialCubitStates {}

class SocialChangeModeState extends SocialCubitStates {}
