import 'package:socail_app/models/post_model.dart';

class SocialUserModel
{
  String name ;
  String email ;
  String phone  ;
  String uId ;
  String image ;
  String bio ;
  String cover ;
  bool isEmailVerified ;
  List<PostModel> userPosts ;

  SocialUserModel({
    this.name ,
    this.email ,
    this.phone ,
    this.uId ,
    this.image ,
    this.bio,
    this.cover ,
    this.isEmailVerified ,
    this.userPosts  ,
  }) ;
  SocialUserModel.fromJson(Map<String , dynamic>json)
  {
    name = json["name"] ;
    email = json["email"] ;
    phone = json["phone"] ;
    uId = json["uId"] ;
    image = json["image"] ;
    bio = json["bio"] ;
    cover = json["cover"] ;
    isEmailVerified = json["isEmailVerified"] ;
    userPosts = json["userPosts"] ;
  }

  Map<String , dynamic> toMap ()
  {
    return {
      'name' : name ,
      'email' : email ,
      'phone' : phone ,
      'uId' : uId ,
      'image' : image ,
      'bio' : bio ,
      'cover' : cover ,
      'isEmailVerified' : isEmailVerified ,
      'userPosts' : userPosts ,
    };
  }
}