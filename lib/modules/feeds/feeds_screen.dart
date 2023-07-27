import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:socail_app/layout/cubit/cubit.dart';
import 'package:socail_app/layout/cubit/states.dart';
import 'package:socail_app/modules/add_posts/add_posts_screen.dart';
import 'package:socail_app/modules/add_story/add_story_screen.dart';
import 'package:socail_app/modules/chats/chats_screen.dart';
import 'package:socail_app/modules/profile/profile_screen.dart';
import 'package:socail_app/shared/components/components.dart';

class FeedsScreen extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  var formKey = GlobalKey<FormState>();

  var textController = TextEditingController();

  var postController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialCubitStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Builder(
          builder: (context) {
            SocialCubit.get(context).getPosts;
            return ConditionalBuilder(
              condition: SocialCubit.get(context).posts.length > 0 &&
                  SocialCubit.get(context).userModel.image != '',
              builder: (context) => Scaffold(
                key: scaffoldKey,
                appBar: defultAppBar(context: context , title: 'Feeds'),
                body: LiquidPullToRefresh(
                  onRefresh: () async {
                    await cubit.loadResources();
                  },
                  animSpeedFactor: 3,
                  showChildOpacityTransition: false,
                  backgroundColor: Colors.deepPurple[200],
                  height: 50,
                  color: Colors.grey[50],
                  child:  SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(top: 5),
                      child: Expanded(
                        child: Container(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          navigateTo(context, ProfileScreen());
                                        },
                                        child: CircleAvatar(
                                          radius: 25.0,
                                          backgroundImage: NetworkImage(
                                              '${cubit.userModel.image}'),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      // Expanded(
                                      //   child: defaultFormField(
                                      //     isBorder: true,
                                      //     textInputType: TextInputType.none,
                                      //     controller: TextEditingController(),
                                      //     lable: 'what is on your mind ...',
                                      //     suffixIcon: IconButton(
                                      //       icon: Icon(
                                      //         IconBroken.Image ,
                                      //         color: Colors.black,
                                      //       ),
                                      //       onPressed: ()
                                      //       {
                                      //         print('image select') ;
                                      //       },
                                      //     ) ,
                                      //   ),
                                      // ),

                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            navigateTo(
                                                context, AddPostScreen());
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black38),
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              color: Colors.grey[50],
                                            ),
                                            height: 50,
                                            width: double.infinity,
                                            child: Align(
                                              alignment: AlignmentDirectional
                                                  .centerStart,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "What's on your mind ...",
                                                    ),
                                                    Spacer(),
                                                    Icon(IconBroken.Image),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  height: 40.0,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                width: double.infinity,
                                height: 110.0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: ListView.separated(
                                        itemBuilder: (context, index) =>
                                            buildStoryItem(context, index),
                                        scrollDirection: Axis.horizontal,
                                        physics: BouncingScrollPhysics(),
                                        separatorBuilder: (context, index) =>
                                            SizedBox(
                                          width: 0.0,
                                        ),
                                        itemCount: cubit.users.length,
                                        shrinkWrap: true,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              //posts ....
                              ListView.separated(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) => buildPost(
                                    context: context,
                                    cubit: SocialCubit.get(context),
                                    index: index,
                                    model:
                                        SocialCubit.get(context).posts[index],
                                    scaffoldKey: scaffoldKey),
                                separatorBuilder: (context, index) => SizedBox(
                                  height: 10.0,
                                ),
                                itemCount: cubit.posts.length,
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )  ,
                ),
              ),
              fallback: (context) => Scaffold(
                key: scaffoldKey,
                appBar: defultAppBar(context: context , title: 'Feeds'),
                body: LiquidPullToRefresh(
                  onRefresh: () async {
                    await cubit.loadResources();
                  },
                  animSpeedFactor: 3,
                  showChildOpacityTransition: false,
                  backgroundColor: Colors.deepPurple[200],
                  height: 50,
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(top: 5),
                      child: Expanded(
                        child: Container(
                          color: Colors.white,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          navigateTo(context, ProfileScreen());
                                        },
                                        child: CircleAvatar(
                                          radius: 25.0,
                                          backgroundImage: NetworkImage(
                                              '${cubit.userModel.image}'),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      // Expanded(
                                      //   child: defaultFormField(
                                      //     isBorder: true,
                                      //     textInputType: TextInputType.none,
                                      //     controller: TextEditingController(),
                                      //     lable: 'what is on your mind ...',
                                      //     suffixIcon: IconButton(
                                      //       icon: Icon(
                                      //         IconBroken.Image ,
                                      //         color: Colors.black,
                                      //       ),
                                      //       onPressed: ()
                                      //       {
                                      //         print('image select') ;
                                      //       },
                                      //     ) ,
                                      //   ),
                                      // ),

                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            navigateTo(
                                                context, AddPostScreen());
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black38),
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              color: Colors.grey[50],
                                            ),
                                            height: 50,
                                            width: double.infinity,
                                            child: Align(
                                              alignment: AlignmentDirectional
                                                  .centerStart,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "What's on your mind ...",
                                                    ),
                                                    Spacer(),
                                                    Icon(IconBroken.Image),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  height: 40.0,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                width: double.infinity,
                                height: 110.0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: ListView.separated(
                                        itemBuilder: (context, index) =>
                                            buildStoryItem(context, index),
                                        scrollDirection: Axis.horizontal,
                                        physics: BouncingScrollPhysics(),
                                        separatorBuilder: (context, index) =>
                                            SizedBox(
                                          width: 0.0,
                                        ),
                                        itemCount: cubit.users.length,
                                        shrinkWrap: true,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Center(child: CircularProgressIndicator()),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget buildStoryItem(context, index) => Padding(
        padding: EdgeInsetsDirectional.only(start: 8),
        child: GestureDetector(
          onTap: () {
            navigateTo(context, AddStoryScreen());
          },
          child: Container(
            width: 70,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      radius: 35.0,
                      backgroundColor: Colors.blueGrey,
                    ),
                    CircleAvatar(
                      radius: 33.0,
                      backgroundColor: Colors.white,
                    ),
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          '${SocialCubit.get(context).users[index].image}'),
                      radius: 29,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  '${SocialCubit.get(context).users[index].name}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall
                      .copyWith(fontSize: 10),
                ),
              ],
            ),
          ),
        ),
      );
}
