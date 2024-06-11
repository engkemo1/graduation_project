
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:graduation_project/view/screens/splashScreen.dart';
import 'package:graduation_project/view_model/cubit/fav_cubit/fav_cubit.dart';
import 'package:graduation_project/view_model/cubit/home_cubit/home_cubit.dart';
import 'package:graduation_project/view_model/cubit/news_cubit/news_cubit.dart';
import 'package:graduation_project/view_model/cubit/notification_cubit/norification_cubit.dart';
import 'package:graduation_project/view_model/database/local.dart';
import 'package:graduation_project/view_model/database/network/dio_helper.dart';
bool isFirstTime=true;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await  CacheHelper.init();
  await  DioHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>(
          create: (BuildContext context) => HomeCubit()..upcomingEvents()..getCategories()..getSubCategories(),
        ),
        BlocProvider<NotificationCubit>(
          create: (BuildContext context) => NotificationCubit()..getNotification(),
        ),
        BlocProvider<FavCubit>(
          create: (BuildContext context) => FavCubit()..getFavourite(),
        ),
        BlocProvider<NewsCubit>(
          create: (BuildContext context) => NewsCubit()..getNews(),
        ),
        // Add more BlocProviders if you have more blocs
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home:  const SplashScreen(),
        navigatorObservers: [FlutterSmartDialog.observer],
        // here
        builder: FlutterSmartDialog.init(),
      ),
    );
  }
}


