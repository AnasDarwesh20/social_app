import 'package:flutter/material.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:socail_app/modules/feeds/feeds_screen.dart';

class CommentsScreen extends StatelessWidget {
  var commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          FeedsScreen(),
          Card(
            color: Colors.white,
            margin: EdgeInsets.all(30.0),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation: 5.0,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsetsDirectional.only(
                  start: 30 ,
                  bottom: 25 ,
                  end: 30 ,
                  top: 10
                ),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context , index) => buildCommentItem(),
                        separatorBuilder: (context , index) =>  SizedBox(
                          height: 20,
                        ),
                        itemCount: 10,
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.grey[300], width: 1.0),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: TextFormField(
                                  controller: commentController,
                                  decoration: InputDecoration(
                                    hintText: 'Write a comment...',
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 50.0,
                              color: Colors.blue,
                              child: MaterialButton(
                                minWidth: 1.0,
                                onPressed: () {},
                                child: Icon(
                                  IconBroken.Send,
                                  size: 16.0,
                                  color: Colors.white,
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
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCommentItem() => Container(
        width: 350,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300], width: 1.0),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.only(
            start: 20,
            top: 10,
            bottom: 10,
          ),
          child: Expanded(
            child: Text('hi'),
          ),
        ),
      );
}
