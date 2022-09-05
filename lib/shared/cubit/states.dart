abstract class SocialStates {}
class InitialState extends SocialStates{}
class GetUserSuccessState extends SocialStates{}
class GetUserErrorState extends SocialStates{
  final String error;

  GetUserErrorState(this.error);
}
class ChangeScreenIndex extends SocialStates{}
class NewPostState extends SocialStates{}
class ProfileImagePickedSuccessState extends SocialStates{}
class ProfileImagePickedFilledState extends SocialStates{}
class CoverImagePickedSuccessState extends SocialStates{}
class CoverImagePickedFilledState extends SocialStates{}
class UploadProfileImagePickedSuccessState extends SocialStates{}
class UploadProfileImagePickedFilledState extends SocialStates{}
class UploadCoverImagePickedSuccessState extends SocialStates{}
class UploadCoverImagePickedFilledState extends SocialStates{}
class UserUpdateError extends SocialStates{}
class UserUpdateLoading extends SocialStates{}
class SocialUserUpdateCoverLoadingState extends SocialStates{}
class SocialCreatePostLoadingState extends SocialStates {}
class SocialCreatePostSuccessState extends SocialStates {}
class SocialCreatePostErrorState extends SocialStates {}
class SocialPostImagePickedSuccessState extends SocialStates {}
class SocialPostImagePickedErrorState extends SocialStates {}
class SocialRemovePostImageState extends SocialStates {}
class SocialGetPostsLoadingState extends SocialStates {}
class SocialGetPostsSuccessState extends SocialStates {}
class SocialGetPostsErrorState extends SocialStates {
  final String error;
  SocialGetPostsErrorState(this.error);
}
class SocialLikePostSuccessState extends SocialStates {}
class SocialLikePostErrorState extends SocialStates {
  final String error;
  SocialLikePostErrorState(this.error);
}
class SocialCreateCommentLoadingState extends SocialStates {}
class SocialCreateCommentSuccessState extends SocialStates {}
class SocialCreateCommentErrorState extends SocialStates {}
class SocialCommentImagePickedSuccessState extends SocialStates {}
class SocialCommentImagePickedErrorState extends SocialStates {}
class SocialRemoveCommentImageState extends SocialStates {}
class SocialGetAllUsersSuccessState extends SocialStates {}
class SocialLoadingGetAllUserDataState extends SocialStates {}
class SocialGetAllUsersErrorState extends SocialStates {
  final String error;
  SocialGetAllUsersErrorState(this.error);
}
class SocialSendMessageSuccessState extends SocialStates{}
class SocialSendMessageErrorState extends SocialStates{}
class SocialGetMessageSuccessState extends SocialStates{}
class SocialGetMessageErrorState extends SocialStates{}

