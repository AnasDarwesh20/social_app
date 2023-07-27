import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:socail_app/layout/cubit/cubit.dart';
import 'package:socail_app/layout/cubit/states.dart';
import 'package:socail_app/shared/components/components.dart';

class SocialLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialCubitStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            title: Text(
              'Articles',
              style: Theme.of(context).textTheme.labelSmall.copyWith(
                    fontSize: 20,
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          body: Container(
            color: Colors.white,
            child: Padding(
              padding: EdgeInsetsDirectional.only(
                start: 8.0,
                end: 8.0,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) =>
                          buildArticleItem(context, index),
                      separatorBuilder: (context, index) => SizedBox(
                        height: 20,
                      ),
                      itemCount: 5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildArticleItem(context, index) => Padding(
    padding: EdgeInsetsDirectional.only(
      top: 25  ,
    ),
    child: Container(
      decoration:BoxDecoration(
        borderRadius: BorderRadius.circular(10.0) ,
        color: Colors.blueGrey[50],

      ) ,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.only(
                    top: 10 ,
                  end: 10 ,
                  ),
                  child: Container(
                    height: 220,
                    child: Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage(
                                  '${SocialCubit.get(context).userModel.image}'),
                            ),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                            '${SocialCubit.get(context).userModel.name}',
                            style: Theme.of(context).textTheme.labelSmall.copyWith(
                                  color: Colors.black,
                                ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              print('Like');
                            },
                            child: Icon(
                              IconBroken.Heart,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          GestureDetector(
                            onTap: () {
                              print('Comment');
                            },
                            child: Icon(
                              IconBroken.Chat,
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          GestureDetector(
                            onTap: () {
                              print('Follow');
                            },
                            child: Text(
                              'Follow',
                              style: Theme.of(context).textTheme.labelSmall.copyWith(
                                    fontSize: 10,
                                    color: Colors.blue[300],
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.only(
                              start: 5,
                              top: 10,
                            ),
                            child: Text(
                              'Article',
                              style: Theme.of(context).textTheme.labelSmall.copyWith(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.only(
                              start: 5,
                              top: 13,
                            ),
                            child: Text(
                              '7/8/2032',
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          ),
                          Spacer(),
                          Padding(
                            padding: EdgeInsetsDirectional.only(
                              end: 20,
                            ),
                            child: Icon(
                              IconBroken.Bookmark,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.only(
                          start: 5,
                        ),
                        child: Text(
                          " Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source.",
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              .copyWith(fontSize: 13, height: 1.5),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: double.infinity,
                        height: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0) ,
                            color: Colors.red ,
                        ),
                      ) ,
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: double.infinity,
                        height: 1,
                        color: Colors.blueGrey,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        height: 30,
                        width: 150,
                        decoration: BoxDecoration(
                          border:
                          Border.all(color: Colors.grey[300], width: 1.0),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsetsDirectional.only(
                                  start: 20 ,
                                  top: 8
                                ),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    hintText: 'تقييم',
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 50.0,
                              color: Colors.white,
                              child: MaterialButton(
                                minWidth: 1.0,
                                onPressed: () {

                                },
                                child: Icon(
                                  IconBroken.Star,
                                  size: 16.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.only(top: 10),
                  child: Container(
                    height: 50,
                    width: 1,
                    color: Colors.blueGrey,
                  ),
                ),
              ],
            ),
      ),
    ),
  );
}
