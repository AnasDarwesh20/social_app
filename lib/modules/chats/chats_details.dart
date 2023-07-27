import 'package:bloc_provider/bloc_provider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:socail_app/layout/cubit/states.dart';
import 'package:socail_app/shared/components/components.dart';

import '../../layout/cubit/cubit.dart';
import '../../models/messege_model.dart';
import '../../models/user_model.dart';

class ChatsDetailsScreen extends StatelessWidget {
  SocialUserModel userModel;

  ChatsDetailsScreen({
    this.userModel,
  });

  var messageController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context)
      {
        SocialCubit.get(context).getMessages(
          receiverId: userModel.uId,
        );
        return BlocConsumer<SocialCubit, SocialCubitStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(

                backgroundColor: Colors.white,
                titleSpacing: 1.0,
                leading: IconButton(
                  color: Colors.black,
                  icon: Icon(
                    IconBroken.Arrow___Left_2,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                elevation: 1.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage('${userModel.image}'),
                      radius: 20.0,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      '${userModel.name}',
                      style: Theme.of(context).textTheme.labelSmall.copyWith(
                        fontSize: 15
                      ),
                    ),
                  ],
                ),
              ),
              // body: ConditionalBuilder(
              //   condition: SocialCubit.get(context).messages.length > 0,
              //   builder: (context) => Padding(
              //     padding: const EdgeInsets.all(20.0),
              //     child: Column(
              //       children: [
              //         Expanded(
              //           child: ListView.separated(
              //             physics: BouncingScrollPhysics(),
              //             itemBuilder:(context , index) {
              //               if(SocialCubit.get(context).userModel.uId == SocialCubit.get(context).messages[index].senderId)
              //                 return  buildMyMessage(SocialCubit.get(context).messages[index]) ;
              //              return buildMessage(SocialCubit.get(context).messages[index]) ;
              //             },
              //             separatorBuilder: (context , index) => SizedBox(
              //               height: 15.0,
              //             ) ,
              //             itemCount: SocialCubit.get(context).messages.length,
              //           ),
              //         ),
              //         Spacer(),
              //         Container(
              //           clipBehavior: Clip.antiAliasWithSaveLayer,
              //           decoration: BoxDecoration(
              //             border:
              //                 Border.all(color: Colors.grey[300], width: 1.0),
              //             borderRadius: BorderRadius.circular(15.0),
              //           ),
              //           child: Row(
              //             children: [
              //               Expanded(
              //                 child: Padding(
              //                   padding: const EdgeInsets.symmetric(
              //                       horizontal: 15.0),
              //                   child: TextFormField(
              //                     controller: messageController,
              //                     decoration: InputDecoration(
              //                       hintText: 'Message',
              //                       border: InputBorder.none,
              //                     ),
              //                   ),
              //                 ),
              //               ),
              //               Container(
              //                 height: 50.0,
              //                 color: Colors.blue,
              //                 child: MaterialButton(
              //                   minWidth: 1.0,
              //                   onPressed: () {
              //                     SocialCubit.get(context).senMessage(
              //                       receiverId: userModel.uId,
              //                       dateTime: DateTime.now().toString(),
              //                       text: messageController.text,
              //                     );
              //                   },
              //                   child: Icon(
              //                     IconBroken.Send,
              //                     size: 16.0,
              //                     color: Colors.white,
              //                   ),
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              //   fallback: (context) =>
              //       Center(child: CircularProgressIndicator()),
              // ),
              body:  Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder:(context , index) {
                          if(SocialCubit.get(context).userModel.uId == SocialCubit.get(context).messages[index].senderId)
                            return  buildMyMessage(SocialCubit.get(context).messages[index]) ;
                          return buildMessage(SocialCubit.get(context).messages[index]) ;
                        },
                        separatorBuilder: (context , index) => SizedBox(
                          height: 15.0,
                        ) ,
                        itemCount: SocialCubit.get(context).messages.length,
                      shrinkWrap: true,
                      ),
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
                                controller: messageController,
                                decoration: InputDecoration(
                                  hintText: 'Message',
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
                              onPressed: () {
                                SocialCubit.get(context).sendMessage(
                                  receiverId: userModel.uId,
                                  dateTime: DateTime.now().toString(),
                                  text: messageController.text ,
                                );
                                if(messageController.text.isNotEmpty)
                                {
                                  messageController.text = '' ;
                                }

                              },
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
            );
          },
        );
      },
    );
  }

  Widget buildMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 5.0,
          ),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(10.0),
              topEnd: Radius.circular(10.0),
              topStart: Radius.circular(10.0),
            ),
          ),
          child: Text(
            '${model.text}',
          ),
        ),
      );

  Widget buildMyMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 5.0,
          ),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(
              .2,
            ),
            borderRadius: BorderRadiusDirectional.only(
              bottomStart: Radius.circular(10.0),
              topEnd: Radius.circular(10.0),
              topStart: Radius.circular(10.0),
            ),
          ),
          child: Text(
            '${model.text}',
          ),
        ),
      );
}
