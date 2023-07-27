// @dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socail_app/layout/cubit/cubit.dart';
import 'package:socail_app/layout/social_layout.dart';
import 'package:socail_app/modules/design.dart';
import 'package:socail_app/modules/feeds/feeds_screen.dart';
import 'package:socail_app/modules/login/login_screen.dart';
import 'package:socail_app/shared/bloc_observer.dart';
import 'package:socail_app/shared/components/constants.dart';
import 'package:socail_app/shared/network/local/casheHelper.dart';
import 'package:socail_app/shared/network/remote/dioHelper.dart';
import 'package:socail_app/styles/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await FirebaseAnalytics.instance.logBeginCheckout() ;


  await CacheHelper.init();

  DioHelper.init;

  Bloc.observer = MyBlocObserver();

  Widget widget;

  uId = '' ;
  uId = CacheHelper.getData(key: 'uId');


  print(uId) ;

  if (uId == null) {
    widget = SocialLoginScreen();
  } else {
    widget = FeedsScreen();
  }

  bool isDark = CacheHelper.getData(key: 'isDark');

  runApp(MyApp(
    startWidget: widget,
    isDark: isDark,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  bool isDark ;
  MyApp({
    this.startWidget ,
    this.isDark
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => SocialCubit()..getUserData()..getPosts()..getAllUsers()..getSavedPostData()..getProfilePosts()..changeThemeMode(fromShared: this.isDark)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: SocialCubit.isDark  ? ThemeMode.dark : ThemeMode.light,
        home: startWidget,
      ),
    );
  }
}
