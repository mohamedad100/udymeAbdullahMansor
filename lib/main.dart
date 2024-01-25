import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/news_app/cubit/cubit.dart';
import 'package:untitled/layout/news_app/cubit/states.dart';
import 'package:untitled/layout/news_app/news_layout.dart';
import 'package:untitled/layout/shop_app/shop_layout.dart';
import 'package:untitled/layout/social_app/cubit/cubit.dart';
import 'package:untitled/layout/social_app/social_app.dart';
import 'package:untitled/modules/shop_app/on_boarding/on_boarding_screen.dart';
import 'package:untitled/modules/social_app/social_login/social_login_screen.dart';
//import 'package:untitled/layout/todo_app/todo_layout.dart';
//import 'package:untitled/modules/messenger/Messenger_Screen.dart';
//import 'package:untitled/modules/bmi/bmi_screen.dart';
//import 'package:untitled/modules/counter/counter_screen.dart';
//import 'package:untitled/modules/home/home_screen.dart';
//import 'package:untitled/modules/users/users_screen.dart';
import 'package:untitled/shared/bloc_observer.dart';
import 'package:untitled/shared/components/components.dart';
import 'package:untitled/shared/components/constants.dart';
import 'package:untitled/shared/cubit/states.dart';
import 'package:untitled/shared/network/local/cache_helper.dart';
import 'package:untitled/shared/network/remote/dio_helper.dart';
import 'package:untitled/shared/styles/themes.dart';

import 'firebase_options.dart';
import 'layout/shop_app/cubit/cubit.dart';
import 'modules/shop_app/login/shop_login_screen.dart';
import 'shared/cubit/cubit.dart';

//import 'modules/bmi_result/bmi_result_screen.dart';
//import 'modules/login/login_screen.dart';
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('on background message');
  print(message.data.toString());
  showToast(text: 'on background message', states: ToastStates.SUCCESS);
}



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(

    options: DefaultFirebaseOptions.currentPlatform,

  );
  var token =await FirebaseMessaging.instance.getToken();
  print('taaam' + token!);
  FirebaseMessaging.onMessage.listen((event) {    //دا لما يجيلي الاشعار ونا فاتح الابلكييشن
    print(event.data.toString());
    showToast(text: 'on  message', states: ToastStates.SUCCESS);

  });

  FirebaseMessaging.onMessageOpenedApp.listen((event) {   //دا لما يجيلي اشعار و ادوس عليه فيفتح الابلكيشن
    print(event.data.toString());
    showToast(text: 'on  message Opened App', states: ToastStates.SUCCESS);

  });

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

 // WidgetsFlutterBinding.ensureInitialized();  // الميثود دي بتتاكد ان ال تحتها تم عشان تبدا run الابلكيشن
  Bloc.observer = MyBlocObserver();
  DioHelber.init();
 await CacheHelper.init();           //عملت await عشان كانت كدا هناك و عملت async لل main

  //bool? isDark = CacheHelper.getBoolean(key: 'isDark');
  bool isDark=CacheHelper.getData(key: 'isDark')??false;

 // bool? onBoarding=CacheHelper.getData(key: 'onBoarding');
 //  token =CacheHelper.getData(key: 'token');
   uId =CacheHelper.getData(key: 'uId');

  Widget widget;

  // if(onBoarding != null){
  //   if(token != null ) widget = ShopLayout();
  //   else widget = ShopLoginScreen();
  // }else{
  //   widget = OnBoardingScreen();
  // }
  if(uId != null){
    widget = SocialLayout();
  }else{
    widget= SocialLoginScreen();
  }

  runApp(myApp(isDark , widget));
}

class myApp extends StatelessWidget {
  final bool isDark;
 // final bool onBoarding;
  final Widget widget;



  myApp(this.isDark,this.widget);
  @override
  Widget build(BuildContext context) {
    // بيعمل بروفيد ليهم هنا عشان بيعملوا ايرور لو كانوا في ال news layout و بيبقي بروفيد ع الابليكيشن كله عشان من ال main
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>NewsCubit()..getBusiness()..getSports()..getScience()),
        BlocProvider(create: (BuildContext context) => AppCubit()..changeAppMode(fromShared: isDark ) ),
        BlocProvider(create: (BuildContext context) => ShopCubit()..getHomeData()..getCategorieData()..getFavorites()..getUserModel()),
        BlocProvider(create: (BuildContext context) => SocialCubit()..getUserData()..getPosts())

      ],
      child: BlocConsumer<AppCubit,AppStates>(

        listener: (BuildContext context, state) {  },
        builder: (BuildContext context, Object? state) {
         return  MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            //darkTheme: darkTheme,
           // themeMode: AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
         // home:onBoarding ? ShopLoginScreen() : OnBoardingScreen(),
           home:widget,



         );
        } ,

      ),
    );
  }
}
