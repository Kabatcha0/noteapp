import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteapp/cubit/cubit.dart';
import 'package:noteapp/cubit/states.dart';
import 'package:noteapp/modules/details.dart';
import 'package:noteapp/modules/homescreen.dart';
import 'package:noteapp/modules/splash.dart';
import 'package:noteapp/network/const.dart';
import 'package:noteapp/network/local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();
  uid = CacheHelper.getString("uid");
  print(uid);
  getTheData = false;
  runApp(MyApp(
    uid: uid,
  ));
}

class MyApp extends StatelessWidget {
  String? uid;
  MyApp({required this.uid});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => NoteCubit(),
        child: BlocConsumer<NoteCubit, NoteStates>(
            listener: (context, state) {},
            builder: (context, state) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData(scaffoldBackgroundColor: Colors.black),
                title: 'Note App',
                home: Splash(uid: uid),
              );
            }));
  }
}
