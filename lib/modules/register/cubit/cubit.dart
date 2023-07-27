import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socail_app/modules/register/cubit/states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../models/user_model.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    @required String email,
    @required String password,
    @required String name,
    @required String phone,
  })
  {
    emit(SocialRegisterLoadingState());

    FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    ).then((value)
    {
      userCreate(email: email, name: name, phone: phone, uId:value.user.uid) ;
      emit(SocialRegisterSuccessState()) ;
    }).catchError((error){
      print(error.toString()) ;
      emit(SocialRegisterErrorState(error.toString())) ;
    });
  }

  void userCreate({
    @required String email,
    @required String name,
    @required String phone,
    @required String uId,
  })
  {
    SocialUserModel model = SocialUserModel(
      email: email,
      phone: phone,
      name: name,
      uId: uId,
      isEmailVerified: false,
      bio: 'write your bio...' ,
      image: 'https://img.freepik.com/free-icon/user_318-644324.jpg?size=626&ext=jpg&ga=GA1.1.457670682.1677506347&semt=ais' ,
      cover: 'https://img.freepik.com/free-vector/basketball-made-with-small-dots-creative-background_1017-24097.jpg?w=1060&t=st=1673515260~exp=1673515860~hmac=a42b4fae171b8e5d7c099c11110b0ee957bc76539b74b40a4655a8e6cc616a7f' ,
    );

    FirebaseFirestore.instance
        .collection('users').doc(uId)
        .set(model.toMap())
        .then((value)
    {
      emit(SocialCreateUserSuccessState());
    }).catchError((error)
    {
      emit(SocialCreateUserErrorState(error.toString()));
    });
  }
}
