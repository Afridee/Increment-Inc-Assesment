import 'package:assesmentbyafridee/Screens/Authentication/login.dart';
import 'package:assesmentbyafridee/Screens/Authentication/otp.dart';
import 'package:assesmentbyafridee/Screens/Home/home.dart';
import 'package:assesmentbyafridee/Screens/onboarding.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/authentication.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final Authentication authenticationController = Get.put(Authentication());
    return GetBuilder<Authentication>(builder: (ac){
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ac.isLoggedIn ? const Home() : const Onboarding(),
      );
    });
  }
}
