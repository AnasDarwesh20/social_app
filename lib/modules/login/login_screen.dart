import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:socail_app/layout/social_layout.dart';
import 'package:socail_app/modules/login/cubit/cubit.dart';
import 'package:socail_app/modules/login/cubit/states.dart';
import 'package:socail_app/modules/register/register_screen.dart';
import 'package:socail_app/shared/components/components.dart';

import '../../shared/network/local/casheHelper.dart';
import '../feeds/feeds_screen.dart';

class SocialLoginScreen extends StatefulWidget {
  @override
  State<SocialLoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<SocialLoginScreen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  bool isPasswordShown = false;

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        listener: (context, state) {
          if (state is SocialUserLoginErrorState) {
            showToast(message: state.error, states: ToastStates.ERROR);
          }
          if (state is SocialUserLoginSuccessState) {
            showToast(
                message: 'login successfully', states: ToastStates.SUCCESS);
            CacheHelper.saveData(
              key: 'uId',
              value: state.uId,
            ).then((value) {
              navigateToAndFinish(context, FeedsScreen());
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Container(
              color: Colors.blueGrey[100],
              child: Center(
                child: Container(
                  width: 350,
                  height: 500,
                  child: Form(
                    key: formKey,
                    child: Card(
                      color: Colors.grey[200],
                      margin: EdgeInsets.all(20.0),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      elevation: 5.0,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Center(
                            child: Column(
                              children: [
                                Text(
                                  'Login',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1
                                      ?.copyWith(
                                        fontSize: 60.0,
                                        color: Colors.black,
                                      ),
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        width: double.infinity,
                                        color: Colors.black26,
                                        height: 1.0,
                                      ),
                                    ),
                                    SizedBox(width: 5,) ,
                                    Text(
                                      'o',
                                    ),
                                    SizedBox(width: 5,) ,
                                    Expanded(
                                      child: Container(
                                        width: double.infinity,
                                        color: Colors.black26,
                                        height: 1.0,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Column(
                                  children: [
                                    TextFormField(
                                      controller: emailController,
                                      validator: (value) {
                                        if (value.isEmpty)
                                          return 'please enter your email';
                                      },
                                      decoration: InputDecoration(
                                        label: Text(
                                          'email',
                                        ),
                                        border: OutlineInputBorder(),
                                        prefixIcon: Icon(
                                          Icons.mail_outline_outlined,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                    TextFormField(
                                      controller: passwordController,
                                      validator: (value) {
                                        if (value.isEmpty)
                                          return 'please enter your password';
                                      },
                                      obscureText:
                                          isPasswordShown ? false : true,
                                      decoration: InputDecoration(
                                        label: Text(
                                          'password',
                                        ),
                                        border: OutlineInputBorder(),
                                        prefixIcon: Icon(
                                          Icons.lock_open_outlined,
                                        ),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            isPasswordShown
                                                ? Icons.visibility_outlined
                                                : Icons.visibility_off_outlined,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              isPasswordShown =
                                                  !isPasswordShown;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                    ConditionalBuilder(
                                      condition:
                                          state is! SocialUserLoginLoadingState,
                                      builder: (context) => OutlinedButton(
                                        onPressed: () {
                                          if (formKey.currentState.validate()) {
                                            print(emailController.text);
                                            print(passwordController.text);

                                            SocialLoginCubit.get(context)
                                                .userLogin(
                                              email: emailController.text,
                                              password: passwordController.text,
                                            );
                                          }
                                        },
                                        child: Text(
                                          'login',
                                        ),
                                      ),
                                      fallback: (context) => Center(
                                          child: CircularProgressIndicator()),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "Don't have an account ?",
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            navigateTo(context,
                                                SocialRegisterScreen());
                                          },
                                          child: Text(
                                            'register now ...',
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
