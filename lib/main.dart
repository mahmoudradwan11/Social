import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/layout/home/Home_layout.dart';
import 'package:social/modules/login/login.dart';
import 'package:social/shared/components/constants.dart';
import 'package:social/shared/cubit/cubit.dart';
import 'package:social/shared/cubit/states.dart';
import 'package:social/shared/network/local/cache_helper.dart';
import 'package:social/shared/network/remote/dio_helper.dart';
import 'package:social/shared/styles/styles/themes.dart';

Future<void>firebaseMessagingBackgroundHandler(RemoteMessage message)async
{
    print('on background message');
    print('message = ${message.data.toString()}');
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();
  DioHelper.init();
  Widget? widget;
  

  FirebaseMessaging.onMessageOpenedApp.listen((event)
  {
    print('on open message');
      print('Event = ${event.data.toString()}');
  });
  FirebaseMessaging.onMessage.listen((event)
  {
    print('on message');
    print('Event = ${event.data.toString()}');
  });
  
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  uId = CacheHelper.getData(key:'uId');
  if(uId != null)
    {
      widget = const Home();
    }
  else
  {
    widget = LoginScreen();
  }
  print('User ID = $uId');
  runApp(MyApp(startWidget:widget,));
}
class MyApp extends StatelessWidget {
  final Widget? startWidget;

  const MyApp({Key? key, this.startWidget}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(context)=>SocialCubit()..getUserData()..getPosts(),
      child: BlocConsumer<SocialCubit,SocialStates>(
        listener:(context,state){},
        builder:(context,state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            themeMode: ThemeMode.light,
            darkTheme: darkTheme,
            home:startWidget,
          );
        }
      ),
    );
  }
}
