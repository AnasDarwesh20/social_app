import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:socail_app/layout/cubit/cubit.dart';
import 'package:socail_app/layout/cubit/states.dart';
import 'package:socail_app/modules/chats/chats_screen.dart';
import 'package:socail_app/modules/edit_profile/edit_profile_screen.dart';
import 'package:socail_app/modules/feeds/feeds_screen.dart';
import 'package:socail_app/modules/login/login_screen.dart';
import 'package:socail_app/modules/saved_posts/saved_posts_screen.dart';
import 'package:socail_app/shared/components/components.dart';


class ProfileScreen extends StatelessWidget {
  var gridKey = GlobalKey<FormState>();

  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialCubitStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        var model = SocialCubit.get(context).userModel;
        return Builder(
          builder: (context) {
            return Scaffold(
              appBar: defultAppBar(context: context , title: 'Profile'),

              body: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      height: 220,
                      child: Stack(
                        alignment: AlignmentDirectional.topCenter,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 200,
                            child: Card(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              margin: EdgeInsetsDirectional.all(8),
                              child: Image(
                                image: NetworkImage(
                                  '${model.cover}',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional.bottomCenter,
                            child: CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(
                                '${model.image}',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      '${model.name}',
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall
                          .copyWith(fontSize: 20),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      '${model.bio}',
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall
                          .copyWith(color: Colors.grey),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          myColumn(context, number: '100 ', text: 'Posts'),
                          mySizedBox(),
                          myColumn(context, number: '25K', text: 'Followers'),
                          mySizedBox(),
                          myColumn(context, number: '1k', text: 'Following'),
                          mySizedBox(),
                          myColumn(context, number: '300', text: 'Photos'),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {},
                              child: Text(
                                'Add photos',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall
                                    .copyWith(
                                        fontSize: 15, color: Colors.blueAccent),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          OutlinedButton(
                            onPressed: () {
                              navigateTo(context, EditProfileScreen());
                            },
                            child: Icon(
                              IconBroken.Edit,
                              size: 15.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 20),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: OutlinedButton(
                                onPressed: () {
                                  navigateTo(context, SavedPostsScreen());
                                },
                                child: Text(
                                  'saved posts',
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 20),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: OutlinedButton(
                                onPressed: () {
                                  SocialCubit.get(context).logOut();
                                  navigateTo(context, SocialLoginScreen());
                                },
                                child: Text(
                                  'Logout',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => Card(
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
                                  CircleAvatar(
                                    radius: 25.0,
                                    backgroundImage: NetworkImage('${SocialCubit.get(context).userPosts[index].image}'),
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
                                              "${SocialCubit.get(context).userPosts[index].name}",
                                              style:
                                              Theme.of(context).textTheme.subtitle2.copyWith(
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
                                          "${SocialCubit.get(context).userPosts[index].dateTime}",
                                          style: Theme.of(context).textTheme.caption.copyWith(
                                            height: 1.4,
                                          ),
                                        ),
                                      ],
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
                                                    SocialCubit.get(context).savePost(
                                                      postId: SocialCubit.get(context).userPosts[index].postId,
                                                      model: SocialCubit.get(context).userPosts[index],
                                                    );
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
                                                  onTap: () {},
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
                                  '${SocialCubit.get(context).userPosts[index].text}',
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
                              if (SocialCubit.get(context).userPosts[index].postImage != '')
                                Padding(
                                  padding: const EdgeInsetsDirectional.only(top: 15.0),
                                  child: Card(
                                    margin: EdgeInsets.zero,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    child: Image(
                                      height: 300,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      image: NetworkImage('${SocialCubit.get(context).userPosts[index].postImage}'),
                                      // fit: BoxFit.cover,
                                      // height: 300.0 ,
                                      // width: double.infinity,
                                    ),
                                  ),
                                ),
                              if (SocialCubit.get(context).userPosts[index].postImage == '')
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
                                                color: Colors.red,
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
                                        onTap: () {},
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
                      ) ,
                      separatorBuilder: (context, index) => SizedBox(
                        height: 15.0,
                      ),
                      itemCount:SocialCubit.get(context).userPosts.length,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget mySizedBox() => SizedBox(
        width: 50.0,
      );

  Widget myColumn(context, {number, text}) => Column(
        children: [
          Text(
            '${number}',
          ),
          Text(
            text,
            style: Theme.of(context)
                .textTheme
                .labelSmall
                .copyWith(color: Colors.grey),
          ),
        ],
      );
}
