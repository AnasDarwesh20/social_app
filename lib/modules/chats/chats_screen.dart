import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:socail_app/layout/cubit/cubit.dart';
import 'package:socail_app/modules/chats/chats_details.dart';
import 'package:socail_app/modules/feeds/feeds_screen.dart';
import 'package:socail_app/shared/components/components.dart';

import '../../models/user_model.dart';

class ChatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defultAppBar(context: context , title: 'Chats'),
      body: ConditionalBuilder(
        condition: SocialCubit.get(context).users.length>0 ,
        builder: (context) => Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder:(context , index) => buildUserChatItem(context, SocialCubit.get(context).users[index] ),
                    separatorBuilder:(context , index) => myDivider(),
                    itemCount: SocialCubit.get(context).users.length,
                  ),
                ),
              ],
            ),
          ),
        ),
        fallback: (context) => Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget buildUserChatItem(context , SocialUserModel model) => GestureDetector(
    onTap: ()
    {
      navigateTo(context, ChatsDetailsScreen(userModel: model,)) ;
    },
    child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(
                '${model.image}' ,
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: Text(
                '${model.name}',
                style: Theme.of(context)
                    .textTheme
                    .labelSmall
                    .copyWith(fontSize: 15.0),
              ),
            ),
          ],
        ),
  );
}
