import 'package:assesmentbyafridee/controllers/authentication.dart';
import 'package:assesmentbyafridee/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final Authentication authenticationController = Get.put(Authentication());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: primaryColor,
        body: Container(
          child: Center(
            child: ElevatedButton(
              child: const Text("Log Out"),
              onPressed: (){
                authenticationController.logOut();
              },
            ),
          ),
        ),
      ),
    );
  }
}
