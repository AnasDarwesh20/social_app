import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:intl/message_lookup_by_library.dart';
import 'package:socail_app/models/user_model.dart';
import 'package:socail_app/modules/comments/comments_screen.dart';
import 'package:socail_app/modules/profile/profile_screen.dart';
import 'package:socail_app/shared/network/local/casheHelper.dart';

import '../../layout/cubit/cubit.dart';
import '../../models/post_model.dart';
import '../../modules/chats/chats_screen.dart';
import '../../modules/feeds/feeds_screen.dart';

Widget defaultFormField({
  @required TextInputType textInputType,
  @required dynamic function,
  dynamic onTap,
  @required IconData prefixIcon,
  @required TextEditingController controller,
  @required String lable,
  @required bool isBorder = true,
  var onSubmit,
  dynamic postTap,
  bool isPasswordShown = false,
  IconButton suffixIcon,
}) =>
    TextFormField(
      onFieldSubmitted: onSubmit,
      controller: controller,
      obscureText: isPasswordShown,
      decoration: InputDecoration(
        labelText: lable,
        fillColor: Colors.black,
        prefixIcon: Icon(
          prefixIcon,
        ),
        suffixIcon: GestureDetector(
          onTap: onTap,
          child: suffixIcon,
        ),
        border: OutlineInputBorder(),
      ),
      validator: function,
    );

Widget butomn({
  double width = double.infinity,
  Color background = Colors.blue,
  @required String text,
  bool isUpper = true,
  double radius = 15.0,
  final VoidCallback function,
}) =>
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: background,
      ),
      width: width,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpper ? text.toUpperCase() : text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );

Widget appBar() => AppBar(
      toolbarHeight: 100.0,
      title: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "WhatsApp",
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                Icon(
                  Icons.camera_alt,
                  color: Colors.white60,
                ),
                SizedBox(
                  width: 40.0,
                ),
                Text(
                  "CHATS",
                  style: TextStyle(fontSize: 15.0),
                ),
                SizedBox(
                  width: 40.0,
                ),
                Text(
                  "STATUS",
                  style: TextStyle(fontSize: 15.0),
                ),
                SizedBox(
                  width: 35.0,
                ),
                Text(
                  "CALLS",
                  style: TextStyle(fontSize: 15.0),
                ),
                SizedBox(
                  width: 5.0,
                ),
                CircleAvatar(
                  backgroundColor: Colors.white60,
                  radius: 10.0,
                  child: Text(
                    "4",
                    style: TextStyle(color: Colors.green),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: Colors.green[400],
      actions: [
        Padding(
          padding: const EdgeInsets.only(bottom: 35.0),
          child: Row(
            children: [
              Icon(
                Icons.search,
              ),
              SizedBox(
                width: 8.0,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: Icon(
                  Icons.menu,
                ),
              ),
            ],
          ),
        ),
      ],
    );

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
          start: 10.0, end: 10.0, top: 10.0, bottom: 10.0),
      child: Container(
        height: 1.0,
        width: double.infinity,
        color: Colors.grey[300],
      ),
    );

void navigateTo(context, Widget) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => Widget,
    ));

void navigateToAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => widget),
      (Route<dynamic> route) => false,
    );

void showToast({
  @required String message,
  @required ToastStates states,
}) =>
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: shooseToastColor(states),
      textColor: Colors.white,
      fontSize: 16.0,
    );

enum ToastStates { SUCCESS, ERROR, WARNING }

Color shooseToastColor(ToastStates states) {
  Color color;
  switch (states) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

Widget defultAppBar(
        {@required BuildContext context,
        String title,
        SocialUserModel model}) =>
    AppBar(
      titleSpacing: 0.0,
      leadingWidth: 20.0,
      leading: SizedBox(
        width: 0.0,
      ),
      elevation: 0.0,
      title: Text(
        '${title}',
      ),
      actions: [
        IconButton(
          onPressed: () {
            navigateTo(context, ChatsScreen());
          },
          icon: Icon(
            IconBroken.Chat,
          ),
        ),
        IconButton(
          onPressed: () {
            navigateTo(context, FeedsScreen());
          },
          icon: Icon(
            IconBroken.Home,
          ),
        ),
        IconButton(
          onPressed: () {
            SocialCubit.get(context).changeThemeMode() ;
          },
          icon: Icon(
            SocialCubit.isDark ? Icons.dark_mode : Icons.dark_mode_outlined,
          ),
        ),
      ],
    );

Widget buildPost(
        {context,
        SocialCubit cubit,
        PostModel model,
        GlobalKey<ScaffoldState> scaffoldKey,
        index}) =>
    Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 5.0,
      margin: EdgeInsets.symmetric(
        horizontal: 10.0,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      navigateTo(context, ProfileScreen());
                    },
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 25.0,
                          backgroundImage: NetworkImage('${model.image}'),
                        ),
                        SizedBox(
                          width: 15.0,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "${model.name}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2
                                        .copyWith(
                                          height: 1.4,
                                        ),
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Icon(
                                    Icons.check_circle,
                                    color: Colors.blue,
                                    size: 16.0,
                                  ),
                                ],
                              ),
                              Text(
                                "${model.dateTime}",
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(
                                      height: 1.4,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 15.0,
                ),
                IconButton(
                  iconSize: 18.0,
                  splashRadius: 20.0,
                  splashColor: Colors.white,
                  alignment: Alignment.topCenter,
                  onPressed: () {
                    scaffoldKey.currentState.showBottomSheet(
                      (context) => Container(
                        height: 200,
                        decoration: BoxDecoration(
                            color: Colors.blue[100],
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (!model.isSaved) {
                                    SocialCubit.get(context).savePost(
                                      postId: model.postId,
                                      model: model,
                                    );
                                  }
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      IconBroken.Bookmark,
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Text(
                                      'save post',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall
                                          .copyWith(fontSize: 15.0),
                                    ),
                                  ],
                                ),
                              ),
                              myDivider(),
                              GestureDetector(
                                onTap: () {},
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.link_outlined,
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Text(
                                      'copy link',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall
                                          .copyWith(fontSize: 15.0),
                                    ),
                                  ],
                                ),
                              ),
                              myDivider(),
                              GestureDetector(
                                onTap: () {},
                                child: Row(
                                  children: [
                                    Icon(
                                      IconBroken.Heart,
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Text(
                                      'follow',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall
                                          .copyWith(fontSize: 15.0),
                                    ),
                                  ],
                                ),
                              ),
                              myDivider(),
                              GestureDetector(
                                onTap: () {
                                  SocialCubit.get(context).deletePost(index);
                                  SocialCubit.get(context)
                                      .deleteProfilePost(index);
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      IconBroken.Delete,
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Text(
                                      'delete',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall
                                          .copyWith(fontSize: 15.0),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      elevation: 0.0,
                      backgroundColor: Colors.white,
                    );
                  },
                  icon: Icon(
                    Icons.more_horiz,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            myDivider(),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, right: 10.0, left: 10.0),
              child: Text(
                '${model.text}',
                style: TextStyle(fontSize: 15.0, height: 1.2),
              ),
            ),
            // Container(
            //   width: double.infinity,
            //   padding: EdgeInsets.symmetric(horizontal: 10.0),
            //   child: Wrap(
            //     children: [
            //       MaterialButton(
            //         padding: EdgeInsets.zero,
            //         height: 25.0,
            //         minWidth: 1.0,
            //         onPressed: () {},
            //         child: Text(
            //           '#software',
            //           style: TextStyle(color: Colors.blue),
            //         ),
            //       ),
            //       MaterialButton(
            //         padding: EdgeInsets.zero,
            //         height: 25.0,
            //         minWidth: 1.0,
            //         onPressed: () {},
            //         child: Text(
            //           '#software',
            //           style: TextStyle(color: Colors.blue),
            //         ),
            //       ),
            //       MaterialButton(
            //         padding: EdgeInsets.zero,
            //         height: 25.0,
            //         minWidth: 1.0,
            //         onPressed: () {},
            //         child: Text(
            //           '#software',
            //           style: TextStyle(color: Colors.blue),
            //         ),
            //       ),
            //       MaterialButton(
            //         padding: EdgeInsets.zero,
            //         height: 25.0,
            //         minWidth: 1.0,
            //         onPressed: () {},
            //         child: Text(
            //           '#software',
            //           style: TextStyle(color: Colors.blue),
            //         ),
            //       ),
            //       MaterialButton(
            //         padding: EdgeInsets.zero,
            //         height: 25.0,
            //         minWidth: 1.0,
            //         onPressed: () {},
            //         child: Text(
            //           '#software',
            //           style: TextStyle(color: Colors.blue),
            //         ),
            //       ),
            //       MaterialButton(
            //         padding: EdgeInsets.zero,
            //         height: 25.0,
            //         minWidth: 1.0,
            //         onPressed: () {},
            //         child: Text(
            //           '#software',
            //           style: TextStyle(color: Colors.blue),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            if (model.postImage != '')
              Padding(
                padding: const EdgeInsetsDirectional.only(top: 15.0),
                child: Card(
                  margin: EdgeInsets.zero,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Expanded(
                    child: Image(
                      height: 300,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      image: NetworkImage('${model.postImage}'),
                      // fit: BoxFit.cover,
                      // height: 300.0 ,
                      // width: double.infinity,
                    ),
                  ),
                ),
              ),
            if (model.postImage == '')
              Container(
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
            Padding(
              padding: const EdgeInsetsDirectional.only(
                start: 1.0,
                top: 5.0,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        SocialCubit.get(context)
                            .likePost(SocialCubit.get(context).postsId[index]);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(
                              IconBroken.Heart,
                              size: 17.0,
                              color: SocialCubit.get(context).isLiked
                                  ? Colors.red
                                  : Colors.grey,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              '${SocialCubit.get(context).likes[index]}',
                              style: Theme.of(context).textTheme.caption,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        SocialCubit.get(context).commentPost(
                            SocialCubit.get(context).postsId[index]);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              IconBroken.Chat,
                              size: 17.0,
                              color: Colors.amber,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              '${SocialCubit.get(context).comments[index]} comment',
                              style: Theme.of(context).textTheme.caption,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            myDivider(),
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 10.0, top: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        navigateTo(context, CommentsScreen());
                      },
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 15.0,
                            backgroundImage: NetworkImage(
                                '${SocialCubit.get(context).userModel.image}'),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text("write a comment...",
                              style: Theme.of(context).textTheme.caption),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(end: 8.0),
                      child: Row(
                        children: [
                          Icon(
                            IconBroken.Heart,
                            size: 17.0,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            'Like',
                            style: Theme.of(context).textTheme.caption,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
