


import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/shared/components/components.dart';
import 'package:socialapp/shared/cubit/cubit.dart';
import 'package:socialapp/shared/cubit/states.dart';
import 'package:socialapp/shared/styles/themes.dart';
import 'layout/socialapp/cubit/cubit.dart';
import 'layout/socialapp/sociallayout.dart';
import 'modules/social_app/social_login/social_login_screen.dart';
import 'modules/splashScreen/splashScreen.dart';
import 'shared/bloc_observer.dart';
import 'shared/components/constants.dart';
import 'shared/network/local/cache_helper.dart';
import 'shared/network/remote/dio_helper.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {

  if (kDebugMode) {
    print('on background message ');
  }
  if (kDebugMode) {
    print(message.data.toString());
  }


}


void main() async
{// be sure all methods finished  to run the app
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  var token = await FirebaseMessaging.instance.getToken();
  if (kDebugMode) {
    print (token);
  }

  FirebaseMessaging.onMessage.listen((event) {
    if (kDebugMode) {
      print('onMessage');
      print(event.data.toString());
      showToast(state: ToastStates.SUCCESS, text: 'onMessage');
    }
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    if (kDebugMode) {
      print('onMessageOpenedApp');
      print(event.data.toString());
      showToast(state: ToastStates.SUCCESS, text: 'onMessageOpenedApp');
    }
  });

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  await DioHelper.init();
  await CacheHelper.init();

  bool ? isDarkMode = CacheHelper.getData(key: 'isDarkMode');

  Widget widget;

  uId = CacheHelper.getData(key: 'uId');

if(uId != null)
  {
    widget = SocialLayout(0);
  }
else{
  widget=SocialLoginScreen();
}
  if(kDebugMode) {
    await FirebaseCrashlytics.instance
        .setCrashlyticsCollectionEnabled(false);
  }
  runApp(MyApp(isDarkMode, widget ,uId ));
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {

    bool ? isDarkMode;
    late final Widget startWidget;
    String? uId;



  MyApp(this.isDarkMode,this.startWidget, String? uId, {Key? key}) : super(key: key) ;


  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [

        BlocProvider( create: (BuildContext context)  => AppCubit()..changeAppMode(fromShared: isDarkMode,),

        ),



        BlocProvider( create: (BuildContext context)  => SocialCubit()..getUserData(uId).. getPosts()..getAllUsers(),
        ),

    ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state){},
        builder: (context ,state){
          return MaterialApp(
                debugShowCheckedModeBanner: false,
                themeMode:  AppCubit.get(context).isDarkMode ? ThemeMode.dark: ThemeMode.light,
            home: AnimatedSplashScreen(
              splash: SplashScreen(),
              nextScreen: startWidget,
              splashIconSize: 700,

              animationDuration: const Duration(milliseconds: 2000),
              splashTransition: SplashTransition.fadeTransition,
            ),
            darkTheme: MyTheme.darkTheme ,
            theme: MyTheme.lightTheme,

                 builder: BotToastInit(),
                 navigatorObservers: [BotToastNavigatorObserver()],


              );
            },




      ),
    );
  }
}
