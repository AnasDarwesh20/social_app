import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:socail_app/layout/cubit/states.dart';
import '../../layout/cubit/cubit.dart';
import '../../shared/components/components.dart';

class SavedPostsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();
    return BlocConsumer<SocialCubit, SocialCubitStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Builder(
          builder: (context) {
            return Scaffold(
              body: ConditionalBuilder(
                condition: SocialCubit.get(context).savedPosts.length > 0,
                builder: (context) => SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 20,
                          left: 20,
                          right: 20,
                        ),
                        child: Expanded(
                          child: ListView.separated(
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
                                          backgroundImage: NetworkImage(
                                              '${SocialCubit.get(context).savedPosts[index].image}'),
                                        ),
                                        SizedBox(
                                          width: 15.0,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    "${SocialCubit.get(context).savedPosts[index].name}",
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
                                                "${SocialCubit.get(context).savedPosts[index].dateTime}",
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
                                        SizedBox(
                                          width: 15.0,
                                        ),
                                        IconButton(
                                          iconSize: 18.0,
                                          splashRadius: 20.0,
                                          splashColor: Colors.white,
                                          alignment: Alignment.topCenter,
                                          onPressed: () {
                                            scaffoldKey.currentState
                                                ?.showBottomSheet(
                                              (context) => Container(
                                                height: 200,
                                                decoration: BoxDecoration(
                                                    color: Colors.blue[100],
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(20.0),
                                                      topRight:
                                                          Radius.circular(20.0),
                                                    )),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      20.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          SocialCubit.get(
                                                                  context)
                                                              .savePost(
                                                            postId:
                                                                SocialCubit.get(
                                                                        context)
                                                                    .savedPosts[
                                                                        index]
                                                                    .postId,
                                                            model: SocialCubit.get(
                                                                        context)
                                                                    .savedPosts[
                                                                index],
                                                          );
                                                        },
                                                        child: Row(
                                                          children: [
                                                            Icon(
                                                              IconBroken
                                                                  .Bookmark,
                                                            ),
                                                            SizedBox(
                                                              width: 5.0,
                                                            ),
                                                            Text(
                                                              'save post',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .labelSmall
                                                                  .copyWith(
                                                                      fontSize:
                                                                          15.0),
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
                                                              Icons
                                                                  .link_outlined,
                                                            ),
                                                            SizedBox(
                                                              width: 5.0,
                                                            ),
                                                            Text(
                                                              'copy link',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .labelSmall
                                                                  .copyWith(
                                                                      fontSize:
                                                                          15.0),
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
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .labelSmall
                                                                  .copyWith(
                                                                      fontSize:
                                                                          15.0),
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
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .labelSmall
                                                                  .copyWith(
                                                                      fontSize:
                                                                          15.0),
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
                                      padding: const EdgeInsets.only(
                                          top: 8.0, right: 10.0, left: 10.0),
                                      child: Text(
                                        '${SocialCubit.get(context).savedPosts[index].text}',
                                        style: TextStyle(
                                            fontSize: 15.0, height: 1.2),
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
                                    if (SocialCubit.get(context)
                                            .savedPosts[index]
                                            .postImage !=
                                        '')
                                      Padding(
                                        padding:
                                            const EdgeInsetsDirectional.only(
                                                top: 15.0),
                                        child: Card(
                                          margin: EdgeInsets.zero,
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          child: Image(
                                            height: 180,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                '${SocialCubit.get(context).savedPosts[index].postImage}'),
                                            // fit: BoxFit.cover,
                                            // height: 300.0 ,
                                            // width: double.infinity,
                                          ),
                                        ),
                                      ),
                                    if (SocialCubit.get(context)
                                            .savedPosts[index]
                                            .postImage ==
                                        '')
                                      Container(
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
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
                                                    .likePost(
                                                        SocialCubit.get(context)
                                                            .postsId[index]);
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
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
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .caption,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: InkWell(
                                              onTap: () {
                                                SocialCubit.get(context)
                                                    .commentPost(
                                                        SocialCubit.get(context)
                                                            .postsId[index]);
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
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
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .caption,
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
                                      padding: const EdgeInsetsDirectional.only(
                                          start: 10.0, top: 8.0),
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
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .caption),
                                                ],
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {},
                                            child: Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .only(end: 8.0),
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
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .caption,
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
                            ),
                            separatorBuilder: (context, index) => SizedBox(
                              height: 15.0,
                            ),
                            itemCount:
                                SocialCubit.get(context).savedPosts.length,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                fallback: (context) => Center(
                    child: Text(
                  'No Saved Posts ...',
                      style: Theme.of(context).textTheme.labelSmall,
                )),
              ),
            );
          },
        );
      },
    );
  }
}
