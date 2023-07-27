class PostModel
{
  String name ;
  String uId ;
  String dateTime ;
  String text ;
  String image ;
  String postImage ;
  String postId;
  bool isSaved ;

  PostModel({
    this.name ,
    this.uId ,
    this.image ,
    this.postImage ,
    this.text ,
    this.dateTime ,
    this.postId ,
    this.isSaved ,
  });


  PostModel.fromJson(Map<String , dynamic>json)
  {
    name = json['name'] ;
    uId = json['uId'] ;
    image = json['image'] ;
    postImage = json['postImage'] ;
    text = json['text'] ;
    dateTime = json['dateTime'] ;
    postId = json['postId'] ;
    isSaved = json['isSaved'] ;
  }

  Map<String , dynamic> toMap ()
  {
    return {
      'name' : name ,
      'uId' : uId ,
      'image' : image ,
      'postImage' : postImage ,
      'dateTime' : dateTime ,
      'text' : text ,
      'postId' : postId ,
      'isSaved' : isSaved ,
    };
  }
}