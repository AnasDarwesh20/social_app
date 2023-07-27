import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:min_id/min_id.dart';
import 'package:socail_app/layout/cubit/cubit.dart';
import 'package:socail_app/layout/cubit/states.dart';

class AddPostScreen extends StatelessWidget {
  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialCubitStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: EdgeInsetsDirectional.only(
              top: 40,
              start: 20,
              end: 20,
            ),
            child: Column(
              children: [
                if (state is SocialCreatePostLoadingState)
                  LinearProgressIndicator(),
                if (state is SocialCreatePostLoadingState)
                  SizedBox(
                    height: 10.0,
                  ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage(
                          '${SocialCubit.get(context).userModel.image}'),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Expanded(
                      child: Text(
                        SocialCubit.get(context).userModel.name,
                        style: Theme.of(context).textTheme.subtitle2.copyWith(
                              height: 1.4,
                            ),
                      ),
                    ),
                    Spacer(),
                    TextButton(
                        onPressed: () {
                          SocialCubit.get(context).id = MinId.getId();
                          var now = DateTime.now();
                          if (SocialCubit.get(context).postImage == null) {
                            SocialCubit.get(context).cretePost(
                              dateTime: now.toString(),
                              text: textController.text,
                              postId: SocialCubit.get(context).id,
                            );
                            textController = null ;
                          } else {
                            SocialCubit.get(context).uploadPostWithImage(
                              dateTime: now.toString(),
                              text: textController.text,
                            );

                            SocialCubit.get(context).postImage = null ;
                            textController = null ;
                          }
                        },
                        child: Text(
                          'post',
                        )),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                      hintText: 'what is on your mind ...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Spacer(),
                SizedBox(
                  height: 10.0,
                ),
                if (SocialCubit.get(context).postImage != null)
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 230,
                        child: Card(
                          margin: EdgeInsets.all(0.0),
                          child: Image(
                            fit: BoxFit.cover,
                            image:NetworkImage(
                              '${SocialCubit.get(context).postImage}' ,
                            ),
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: CircleAvatar(
                          radius: 13.0,
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          child: IconButton(
                            onPressed: () {
                              SocialCubit.get(context).deletePostImage();
                            },
                            alignment: Alignment.center,
                            icon: Icon(
                              Icons.close,
                              size: 10.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                Padding(
                  padding: EdgeInsetsDirectional.only(
                    bottom: 25,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            SocialCubit.get(context).getPostImage();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                IconBroken.Image,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text('add photo'),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () {},
                          child: Text('# tags'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
