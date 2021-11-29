import 'package:assesmentbyafridee/Screens/Authentication/login.dart';
import 'package:assesmentbyafridee/controllers/authentication.dart';
import 'package:assesmentbyafridee/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  late TextEditingController email;
  late TextEditingController password;
  final Authentication authenticationController = Get.put(Authentication());

  @override
  void initState() {
    email = TextEditingController();
    password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Authentication>(builder: (ac){
     return ModalProgressHUD(
        inAsyncCall: ac.screenLoading,
        child: Scaffold(
          backgroundColor: primaryColor,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back_ios)),
            backgroundColor: primaryColor,
            elevation: 0,
          ),
          body: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                const Center(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                            text: "Let's get you registered..\n",
                            style: TextStyle(color: textColorYellow, fontSize: 30)),
                        TextSpan(
                          text: "Please enter your email and give a password.",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                CustomizedTextField1(hint: "E.g. john@gmail.com", controller: email, icon: Icons.email, hideText: false, inputType: TextInputType.emailAddress),
                const SizedBox(
                  height: 20,
                ),
                CustomizedTextField1(hint: "Enter password..", controller: password, icon: Icons.remove_red_eye, hideText: true, inputType: TextInputType.text),
                const SizedBox(
                  height: 50,
                ),
                InkWell(onTap: (){
                  authenticationController.loginWithEmail(context, email.text, password.text, true);
                },child: const AuthButton(bg: Colors.white, text: "Register", textColor: primaryColor))
              ],
            ),
          ),
        ),
      );
    });
  }
}
