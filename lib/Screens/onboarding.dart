import 'package:assesmentbyafridee/Screens/Authentication/login.dart';
import 'package:assesmentbyafridee/utils/constants.dart';
import 'package:flutter/material.dart';


class Onboarding extends StatelessWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: primaryColor,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: [
              Image.asset("assets/images/onboardingIMG.png"),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Increments Inc.",
                textAlign: TextAlign.center,
                style: TextStyle(color: textColorYellow, fontSize: 30),
              ),
              const Text(
                "Movies in your palm!",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              const SizedBox(
                height: 15,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20.0, left: 30, right: 30),
                child: Text(
                  loremText,
                  style: TextStyle(color: textColorGrey, fontSize: 16),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Login(),
                    ),
                  );
                },
                child: Center(
                  child: Stack(
                    fit: StackFit.loose,
                    children: [
                      Container(
                        height: 60,
                        width: 250,
                        decoration: BoxDecoration(
                            color: buttonGrey,
                            borderRadius: BorderRadius.circular(20)
                        ),
                      ),
                      Container(
                        height: 60,
                        width: 125,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)
                        ),
                      ),
                       Positioned(
                         top: 18,
                         left: 30,
                         child: Row(
                           children: const [
                             Text('Register', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                             SizedBox(width: 50),
                             Text('Sign in', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
                           ],
                         ),
                       )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
