import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/components/components.dart';
import '../login/login_screen.dart';

class EditProfileScreen extends StatelessWidget {
  var nameController = TextEditingController();

  var bioController = TextEditingController();

  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialCubitStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        var model = SocialCubit
            .get(context)
            .userModel;
        var profileImage = SocialCubit
            .get(context)
            .profileImage;
        var coverImage = SocialCubit
            .get(context)
            .coverImage;
        return Scaffold(
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsetsDirectional.only(top: 30),
              child: Column(
                children: [
                  if (state is SocialUpdateUserLoadingState
                  )
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: LinearProgressIndicator(),
                    ),
                  if (state is SocialUpdateUserLoadingState
                  )
                    SizedBox(
                      height: 5.0,
                    ),
                  Container(
                    height: 220,
                    child: Stack(
                      alignment: AlignmentDirectional.topCenter,
                      children: [
                        Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 200,
                              child: Card(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                margin: EdgeInsetsDirectional.all(8),
                                child: Image(
                                  image: coverImage == null
                                      ? NetworkImage(
                                    '${model.cover}',
                                  )
                                      : FileImage(coverImage),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.only(
                                end: 15.0,
                                bottom: 35.0,
                              ),
                              child: Align(
                                alignment: AlignmentDirectional.bottomEnd,
                                child: CircleAvatar(
                                  radius: 15,
                                  child: IconButton(
                                    icon: Icon(
                                      IconBroken.Camera,
                                      size: 15,
                                    ),
                                    onPressed: () {
                                      cubit.getCoverImage();
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Align(
                          alignment: AlignmentDirectional.bottomCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage: profileImage == null
                                    ? NetworkImage(
                                  '${model.image}',
                                )
                                    : FileImage(profileImage),
                              ),
                              CircleAvatar(
                                radius: 13,
                                child: IconButton(
                                  icon: Align(
                                    child: Icon(
                                      IconBroken.Camera,
                                      size: 10,
                                    ),
                                  ),
                                  onPressed: () {
                                    cubit.getProfileImage();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (cubit.profileImage != null || cubit.coverImage != null)
                    SizedBox(
                      height: 10.0,
                    ),
                  if (cubit.profileImage != null || cubit.coverImage != null)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          if (cubit.profileImage != null)
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  cubit.uploadProfileImage(
                                      phone: phoneController.text,
                                      name: nameController.text,
                                      bio: bioController.text ,
                                  ) ;
                                },
                                child: butomn(
                                  text: 'Upload image',
                                ),
                              ),
                            ),
                          SizedBox(
                            width: 10,
                          ),
                          if (cubit.coverImage != null)
                            Expanded(child: GestureDetector(
                              onTap: (){
                                cubit.uploadCoverImage( phone: phoneController.text,
                                  name: nameController.text,
                                  bio: bioController.text ,) ;
                              },
                              child: butomn(
                                  text: 'Upload cover' ,
                              ),
                            )),
                        ],
                      ),
                    ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(children: [
                      TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(IconBroken.User),
                          label: Text(
                            'Name',
                          ),
                        ),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return ' name must not be empty ';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: bioController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(IconBroken.Info_Circle),
                          label: Text(
                            'Bio',
                          ),
                        ),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return ' bio must not be empty ';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: phoneController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(IconBroken.Call),
                          label: Text(
                            'Phone',
                          ),
                        ),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return ' phone must not be empty ';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ]),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  OutlinedButton(
                    onPressed: () {
                      cubit.updateUser(
                        phone: phoneController.text,
                        name: nameController.text,
                        bio: bioController.text,
                      );
                    },
                    child: Text(
                      'Update',
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

  Widget mySizedBox() =>
      SizedBox(
        width: 50.0,
      );

  Widget myColumn(context, {number, text}) =>
      Column(
        children: [
          Text(
            '${number}',
          ),
          Text(
            text,
            style: Theme
                .of(context)
                .textTheme
                .labelSmall
                .copyWith(color: Colors.grey),
          ),
        ],
      );
}
