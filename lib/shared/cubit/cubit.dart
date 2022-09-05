import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social/models/User/User_model.dart';
import 'package:social/models/commentModel.dart';
import 'package:social/models/messagemodel.dart';
import 'package:social/models/postmodel.dart';
import 'package:social/modules/chats/chats.dart';
import 'package:social/modules/feeds/feeds.dart';
import 'package:social/modules/settings/settings.dart';
import 'package:social/shared/components/constants.dart';
import 'package:social/shared/cubit/states.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(InitialState());

  static SocialCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<BottomNavigationBarItem> items = const [
    BottomNavigationBarItem(icon: Icon(Icons.feed), label: 'Feeds'),
    BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chats'),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Setting'),
    BottomNavigationBarItem(icon: Icon(Icons.post_add), label: 'post'),
  ];
  List<String> titles = const [
    'Feed',
    'Chats',
    'Setting',
  ];
  List<Widget> screens = const [
    FeedsScreen(),
    ChatsScreen(),
    SettingsScreen(),
  ];
  UserData? userModel;
  File? profileImage;

  void getUserData() {
    FirebaseFirestore.instance.collection('Users').doc(uId).get().then((value) {
      print(value.data());
      userModel = UserData.fromJson(value.data()!);
      emit(GetUserSuccessState());
    }).catchError((error) {
      print(error);
      emit(GetUserErrorState(error.toString()));
    });
  }

  void changeIndex(int index) {
    if(index==1){getUsers();}
    if (index == 3) {
      emit(NewPostState());
    } else {
      currentIndex = index;
      emit(ChangeScreenIndex());
    }
  }

  var picker = ImagePicker();

  Future<void> getImageProfile() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(ProfileImagePickedSuccessState());
    } else {
      print('No image select');
      emit(ProfileImagePickedFilledState());
    }
  }

  File? coverImage;

  Future<void> getImageCover() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      print('Image : ${pickedFile.path}');
      emit(CoverImagePickedSuccessState());
    } else {
      print('No image select');
      emit(CoverImagePickedFilledState());
    }
  }

  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(UserUpdateLoading());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('Users/${Uri
        .file(profileImage!.path)
        .pathSegments
        .last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //emit(UploadProfileImagePickedSuccessState());
        print(value);
        updateUser(name: name, phone: phone, bio: bio, image: value);
      }).catchError((error) {
        emit(UploadProfileImagePickedFilledState());
      });
    }).catchError((error) {
      emit(UploadProfileImagePickedFilledState());
    });
  }

  File? postImage;

  Future<void> getImagePost() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      print('Image : ${pickedFile.path}');
      emit(SocialPostImagePickedSuccessState());
    } else {
      print('No image select');
      emit(SocialPostImagePickedErrorState());
    }
  }

  void uploadPostImage({
    required String text,
    required String dateTime,
  }) {
    emit(SocialCreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri
        .file(postImage!.path)
        .pathSegments
        .last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //emit(UploadProfileImagePickedSuccessState());
        //print(value);
        createPost(dateTime: dateTime, text: text, postImage: value);
      }).catchError((error) {
        emit(SocialCreatePostErrorState());
      });
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  void updateUser({
    required String name,
    required String phone,
    required String bio,
    String? cover,
    String? image,
  }) {
    emit(UserUpdateLoading());
    UserData model = UserData(
      name: name,
      phone: phone,
      bio: bio,
      email: userModel!.email,
      image: image ?? userModel!.image,
      cover: cover ?? userModel!.cover,
      uid: userModel!.uid,
      isEmailVerified: false,
    );
    FirebaseFirestore.instance
        .collection('Users')
        .doc(userModel!.uid)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(UserUpdateError());
    });
  }

  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(UserUpdateLoading());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('Users/${Uri
        .file(coverImage!.path)
        .pathSegments
        .last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        updateUser(
          name: name,
          phone: phone,
          bio: bio,
          cover: value,
        );
      }).catchError((error) {
        emit(UploadCoverImagePickedSuccessState());
      });
    }).catchError((error) {
      emit(UploadCoverImagePickedFilledState());
    });
  }

  void createPost({
    required String dateTime,
    required String text,
    String? postImage,
  }) {
    emit(SocialCreatePostLoadingState());
    PostModel model = PostModel(
        name: userModel!.name,
        image: userModel!.image,
        uId: userModel!.uid,
        dateTime: dateTime,
        text: text,
        postImage: postImage ?? ''
    );
    FirebaseFirestore.instance
        .collection('Posts')
        .add(model.toMap())
        .then((value) {
      emit(SocialCreatePostSuccessState());
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  void removePostImage() {
    postImage = null;
    emit(SocialRemovePostImageState());
  }

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];
  List<int> comments = [];

  void getPosts() {
    FirebaseFirestore.instance.collection('Posts').get().then((value) {
      posts = [];
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);
          postsId.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
        }).catchError((error) {});
      });
      emit(SocialGetPostsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetPostsErrorState(error.toString()));
    });
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('Posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uid)
        .set({
      'like': true,
    }).then((value) {
      emit(SocialLikePostSuccessState());
    }).catchError((error) {
      emit(SocialLikePostErrorState(error.toString()));
    });
  }
  void createComment({
    required String dateTime,
    required String text,
    String? postId,
  }) {
    emit(SocialCreateCommentLoadingState());

    CommentModel model = CommentModel(
      name: userModel!.name,
      uId: userModel!.uid,
      dateTime: dateTime,
      text: text,
    );

    FirebaseFirestore.instance
        .collection('Posts')
        .doc(postId)
        .collection('comment')
        .doc(userModel!.uid)
        .set(model.toMap())
        .then((value) {
      emit(SocialCreateCommentSuccessState());
    }).catchError((error) {
      emit(SocialCreateCommentErrorState());
    });
  }
  List<UserData> users = [];
  void getUsers() {
    emit(SocialLoadingGetAllUserDataState());
   if (users.isEmpty) {
      FirebaseFirestore.instance.collection('Users').get().then((value) {
        value.docs.forEach((element) {
            users.add(UserData.fromJson(element.data()));
        });
        emit(SocialGetAllUsersSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(SocialGetAllUsersErrorState(error.toString()));
      });
    }
  }

  void sendMessage({
    required String receiverId,
    required String dateTime,
    required String text,})
  {
     MessageModel model = MessageModel(
       text: text,
       dateTime:dateTime,
       senderId: userModel!.uid,
       receiverId: receiverId,
     );
     FirebaseFirestore.instance.collection('Users').
    doc(userModel!.uid).
    collection('chats').
    doc(receiverId).
    collection('message').
    add(model.toMap()).
     then((value){
        emit(SocialSendMessageSuccessState());
     }).catchError((error){
       emit(SocialSendMessageErrorState());
     });
     FirebaseFirestore.instance.collection('Users').
     doc(receiverId).
     collection('chats').
     doc(userModel!.uid).
     collection('message').
     add(model.toMap()).
     then((value){
       emit(SocialSendMessageSuccessState());
     }).catchError((error){
       emit(SocialSendMessageErrorState());
     });
  }
  List<MessageModel> messages = [];
  void getMessages({required String receiverId})
  {
      FirebaseFirestore.instance
      .collection('Users')
      .doc(userModel!.uid)
      .collection('chats')
      .doc(receiverId)
      .collection('message')
      .orderBy('dateTime')
      .snapshots().
      listen((event) {
        messages = [];
        event.docs.forEach((element)
        {
            messages.add(MessageModel.fromJson(element.data()));
        });
          emit(SocialGetMessageSuccessState());
      });
  }
}