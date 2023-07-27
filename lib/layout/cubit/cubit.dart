import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socail_app/layout/cubit/states.dart';
import 'package:socail_app/modules/chats/chats_screen.dart';
import 'package:socail_app/modules/feeds/feeds_screen.dart';
import 'package:socail_app/modules/profile/profile_screen.dart';
import 'package:socail_app/shared/components/components.dart';
import 'package:socail_app/shared/components/constants.dart';
import 'package:socail_app/shared/network/local/casheHelper.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../../models/messege_model.dart';
import '../../models/post_model.dart';
import '../../models/user_model.dart';

 class SocialCubit extends Cubit<SocialCubitStates> {
  SocialCubit() : super(SocialCubitInitState());

  static SocialCubit get(context) => BlocProvider.of(context);

  SocialUserModel userModel;

  bool isHomeScreen = true;

  var id;

  int index = 0;

  static bool isDark = false ;

  List<Widget> screens = [
    FeedsScreen(),
    ChatsScreen(),
    ProfileScreen(),
  ];

  List<String> titles = [
    'Feeds',
    'Chats',
    'Profile',
  ];

  void changeCurrentIndex({index, context}) {
    this.index = index;
    emit(SocialCubitChangeCurrentIndexState());
  }

  void changeThemeMode({dynamic fromShared})
  {
    if(fromShared != null)
      isDark = fromShared ;
    else
      isDark = !isDark ;
    CacheHelper.putData(key: 'isDark', value: isDark).then((value) {
      emit(SocialChangeModeState()) ;
    }) ;
  }
  void logOut() {
    CacheHelper.removeData(key: 'uId');
    emit(SocialCubitLogOutState());
  }

  Future<void> getUserData() async {
    emit(SocialGetUserLoadingState());

    return await FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value) {
      print('hi');
      userModel = SocialUserModel.fromJson(value.data());
      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

  File profileImage;

  var piker = ImagePicker();

  Future getProfileImage() async {
    XFile PickedFile = await piker.pickImage(
      source: ImageSource.gallery,
    );

    if (PickedFile != null) {
      profileImage = File(PickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    } else {
      print('No image selected');
      emit(SocialProfileImagePickedErrorState());
    }
  }

  File coverImage;

  Future getCoverImage() async {
    XFile PickedFile = await piker.pickImage(
      source: ImageSource.gallery,
    );

    if (PickedFile != null) {
      coverImage = File(PickedFile.path);
      emit(SocialCoverImagePickedSuccessState());
    } else {
      print('No image selected');
      emit(SocialCoverImagePickedErrorState());
    }
  }

  void uploadProfileImage({
    @required String phone,
    @required String name,
    @required String bio,
  }) {
    emit(SocialUpdateUserLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage.path).pathSegments.last}')
        .putFile(profileImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUser(
          phone: phone,
          name: name,
          bio: bio,
          image: value,
        );
      }).catchError((error) {
        print(error.toString());
        emit(SocialUploadProfileImageErrorState());
      });
    }).catchError((error) {
      print(error.toString());
      emit(SocialUploadProfileImageErrorState());
    });
  } //عمل اب لوود للصورة

  void uploadCoverImage({
    @required String phone,
    @required String name,
    @required String bio,
  }) {
    emit(SocialUpdateUserLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage.path).pathSegments.last}')
        .putFile(coverImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUser(
          phone: phone,
          name: name,
          bio: bio,
          cover: value,
        );
      }).catchError((error) {
        print(error.toString());
        emit(SocialUploadCoverImageErrorState());
      });
    }).catchError((error) {
      print(error.toString());
      emit(SocialUploadCoverImageErrorState());
    });
  }

  void updateUser({
    @required String phone,
    @required String name,
    @required String bio,
    String cover,
    String image,
  }) {
    SocialUserModel model = SocialUserModel(
      phone: phone,
      name: name,
      uId: userModel.uId,
      email: userModel.email,
      isEmailVerified: false,
      bio: bio,
      image: image ?? userModel.image,
      cover: cover ?? userModel.cover,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
      showToast(message: 'Update successfully', states: ToastStates.SUCCESS);
    }).catchError((error) {
      emit(SocialUpdateUserErrorState());
    });
  }



  PostModel postModel ;
  void cretePost({
    @required String dateTime,
    @required String text,
    String postImage,
    String postId,
  }) {
    emit(SocialCreatePostLoadingState());
    postModel = PostModel(
      name: userModel.name,
      uId: userModel.uId,
      image: userModel.image,
      text: text,
      dateTime: dateTime,
      isSaved: false,
      postImage: postImage ?? '',
      postId: postId,
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(postModel.toMap())
        .then((value) {
      print(postModel.postId);
      createProfilePost(dateTime: dateTime, text: text) ;
      showToast(message: 'post created', states: ToastStates.SUCCESS);
      emit(SocialCreatePostSuccessState());
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  PostModel userPostModel;

  Future<void>getSavedPostData()async{
    return await FirebaseFirestore.instance
    .collection('users')
    .doc(uId)
    .collection('savedPosts')
    .get()
    .then((value){
      value.docs.forEach((element)
      {
        postModel = PostModel.fromJson(element.data()) ;
        if(postModel.isSaved)
          getSavedPosts(model: postModel) ;
      }) ;
      emit(SocialGetPostDataSuccessState()) ;
    })
    .catchError((error){
      print(error.toString()) ;
      emit(SocialGetPostDataErrorState(error.toString()));
    });
  }

  void createProfilePost({
    @required String dateTime,
    @required String text,
    String postImage,
    String postId,
  }) {
    emit(SocialCreateProfilePostLoadingState());
    userPostModel = PostModel(
      name: userModel.name,
      uId: userModel.uId,
      image: userModel.image == null
          ? NetworkImage(
              'https://img.freepik.com/free-icon/user_318-644324.jpg?size=626&ext=jpg&ga=GA1.1.457670682.1677506347&semt=ais')
          : userModel.image,
      text: text,
      dateTime: dateTime,
      postImage: postImage ?? '',
      postId: postId,
      isSaved: false
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uId)
        .collection('profilePosts')
        .add(userPostModel.toMap())
        .then((value) {
      getProfilePosts(model: userPostModel);
      emit(SocialCreateProfilePostSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialCreateProfilePostErrorState(error.toString()));
    });
  }

  File postImage;

  Future getPostImage() async {
    XFile PickedFile = await piker.pickImage(
      source: ImageSource.gallery,
    );

    if (PickedFile != null) {
      postImage = File(PickedFile.path);
      emit(SocialPostImagePickedSuccessState());
    } else {
      print('No image selected');
      emit(SocialPostImagePickedErrorState());
    }
  }

  void uploadPostWithImage({
    @required String dateTime,
    @required String text,
  }) {
    emit(SocialCreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage.path).pathSegments.last}')
        .putFile(postImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        cretePost(
          dateTime: dateTime,
          text: text,
          postImage: value,
        );

        createProfilePost(dateTime: dateTime, text: text, postImage: value);
      }).catchError((error) {
        emit(SocialCreatePostErrorState());
      });
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  List<PostModel> posts = [];

  List<PostModel> userPosts = [];

  List<String> postsId = [];

  List<int> likes = [];

  List<int> comments = [];

  Future<void> getPosts() async {
    emit(SocialGetPostLoadingState());
    return await FirebaseFirestore.instance
        .collection('posts')
        .get()
        .then((value) {
          posts = [] ;
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);
          comments.add(value.docs.length);
          postsId.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
          emit(SocialGetPostSuccessState());
        }).catchError((error) {
          print(error.toString());
        });
      });
      emit(SocialGetPostSuccessState());
    }).catchError((error) {
      emit(SocialGetPostErrorState(error.toString()));
    });
  }

  Future getProfilePosts({PostModel model}) async {
    return await FirebaseFirestore.instance
    .collection('users')
    .doc(uId)
    .collection('profilePosts')
    .get()
    .then((value)
    {
      userPosts = [] ;
      value.docs.forEach((element) {
        userPosts.add(PostModel.fromJson(element.data())) ;
        emit(SocialGetProfilePostSuccessState()) ;
      }) ;
    })
    .catchError((error){
      print(error.toString());
      emit(SocialGetProfilePostErrorState(error.toString()));
    }
    );
  }

  // void getProfilePosts({UserPostsModel model , index}) {
  //   emit(SocialGetProfilePostLoadingState());
  //   FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(uId)
  //       .collection('profilePosts')
  //       .get()
  //       .then((value)
  //   {
  //
  //   }).catchError((error) {
  //     emit(SocialGetProfilePostErrorState(error.toString()));
  //   });
  // }

  void commentPost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(userModel.uId)
        .set({
      'comment': true,
    }).then((value) {
      emit(SocialCommentPostSuccessState());
    }).catchError((error) {
      emit(SocialCommentPostErrorState(error.toString()));
    });
  }

  bool isLiked = false ;

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel.uId)
        .set({
      'like': true,
    }).then((value) {
      emit(SocialLikePostSuccessState());
    }).catchError((error) {
      emit(SocialLikePostErrorState(error.toString()));
    });
  }

  void deletePostImage() {
    postImage = null;
    emit(SocialDeletePostImageState());
  }

  void sendMessage({
    @required String receiverId,
    @required String dateTime,
    @required String text,
  }) {
    MessageModel model = MessageModel(
      receiverId: receiverId,
      dateTime: dateTime,
      text: text,
      senderId: userModel.uId,
    );

    //set my chats
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });

    //set receiver chats
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });
  }

  List<MessageModel> messages = [];

  void getMessages({@required receiverId}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
      emit(SocialGetMessageSuccessState());
    });
  }

  List<SocialUserModel> users = [];

  Future<void> getAllUsers() async {
    if (users.length == 0)
      return await FirebaseFirestore.instance
          .collection('users')
          .get()
          .then((value) {
        value.docs.forEach((element) {
          if (element.data()['uId'] != userModel.uId)
            users.add(SocialUserModel.fromJson(element.data()));
        });
        emit(SocialGetAllUsersSuccessState());
      }).catchError((error) {
        emit(SocialGetAllUsersErrorState(error.toString()));
      });
  }

  Future<void> loadResources() async {
    posts = [];
    return await FirebaseFirestore.instance
        .collection('posts')
        .get()
        .then((value) {
      getPosts();
      emit(SocialGetPostSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetPostErrorState(error));
    });
  }

  List<PostModel> savedPosts = [];



  void savePost({
    @required postId,
    model,
    int index,
  }
  ) {
    emit(SocialSavePostLoadingState());
    model.isSaved = true ;
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uId)
        .collection('savedPosts')
        .doc(postId)
        .set(model.toMap())
        .then((value)
    {
      getSavedPosts(model: model) ;
      showToast(message: 'saved successfully', states: ToastStates.SUCCESS);
      emit(SocialSavePostSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialSavePostErrorState());
    });

  }

  Future<void>getSavedPosts({PostModel model}) async {
      savedPosts.add(PostModel.fromJson(model.toMap())) ;
    print(savedPosts.first.name) ;
    emit(SocialGetSavedPostSuccessState()) ;
  }

  void deleteProfilePost(index)
  {
    emit(SocialDeletePostLoadingState()) ;
    FirebaseFirestore.instance.collection('users')
        .doc(uId)
        .collection('profilePosts')
        .get()
        .then((value)
    {
      value.docs.elementAt(index).reference.delete().then((value){
        emit(SocialDeletePostSuccessState()) ;
      }).catchError((error){
        emit(SocialDeletePostErrorState()) ;

      }) ;
      userPosts.removeAt(index) ;
      emit(SocialDeletePostSuccessState()) ;
    })
        .catchError((error)
    {
      print(error.toString()) ;
      emit(SocialDeletePostErrorState()) ;

    }) ;
  }

  void deletePost(index)
  {
    emit(SocialDeletePostLoadingState()) ;
    FirebaseFirestore.instance.collection('posts')
        .get()
        .then((value) {
      value.docs.elementAt(index).reference.delete().then((value){
           emit(SocialDeletePostSuccessState()) ;
         }).catchError((error){
           emit(SocialDeletePostErrorState()) ;
         }) ;
      userPosts.removeAt(index) ;
      emit(SocialDeletePostSuccessState()) ;
    }).catchError((error){
      print(error.toString()) ;
      emit(SocialDeletePostErrorState()) ;
    }) ;
  }
}

