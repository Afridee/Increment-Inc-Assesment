import 'package:assesmentbyafridee/Screens/Authentication/register.dart';
import 'package:assesmentbyafridee/controllers/authentication.dart';
import 'package:assesmentbyafridee/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late TextEditingController email;
  late TextEditingController password;
  late TextEditingController phone;
  final Authentication authenticationController = Get.put(Authentication());

  @override
  void initState() {
    email = TextEditingController();
    password = TextEditingController();
    phone = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    phone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Authentication>(builder: (ac){
      return ModalProgressHUD(
        inAsyncCall: ac.screenLoading,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back_ios)),
            backgroundColor: primaryColor,
            elevation: 0,
          ),
          backgroundColor: primaryColor,
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: ListView(
              children: [
                const Center(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                            text: "Let's sign you in.\n",
                            style: TextStyle(color: textColorYellow, fontSize: 30)),
                        TextSpan(
                          text: "Welcome back.\nYou've been missed.",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                GetBuilder<Authentication>(builder: (ac){
                  return InkWell(
                    onTap: (){
                      authenticationController.toggleBetweenEmailandPhone();
                    },
                    child: ac.emailSelected ? const EmailSelected() : const PhoneSelected(),
                  );
                }),
                GetBuilder<Authentication>(builder: (ac){
                  return !ac.emailSelected ? Padding(
                    padding: const EdgeInsets.only(left: 50.0, right: 50.0),
                    child: CustomizedTextField1(
                        hideText: false,
                        inputType: TextInputType.phone,
                        hint: 'E.g. +880191*******',
                        icon: Icons.phone_android,
                        controller: phone),
                  ) : Container();
                }),
                GetBuilder<Authentication>(builder: (ac){
                  return ac.emailSelected ? Padding(
                    padding: const EdgeInsets.only(left: 50.0, right: 50.0),
                    child: CustomizedTextField1(
                        hideText: false,
                        inputType: TextInputType.emailAddress,
                        hint: 'john@gmail.com',
                        icon: Icons.email,
                        controller: email),
                  ) : Container();
                }),
                const SizedBox(
                  height: 10,
                ),
                GetBuilder<Authentication>(builder: (ac){
                  return ac.emailSelected? Padding(
                    padding: const EdgeInsets.only(left: 50.0, right: 50.0),
                    child: CustomizedTextField1(
                        inputType: TextInputType.text,
                        hideText: true,
                        hint: 'Enter your password',
                        icon: Icons.remove_red_eye,
                        controller: password),
                  ) : Container();
                }),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: InkWell(
                    onTap: (){
                      authenticationController.resetPassword(email: email.text, context: context);
                    },
                    child: const Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                              text: "Forgot password? ",
                              style: TextStyle(color: textColorGrey, fontSize: 15)),
                          TextSpan(
                            text: "Reset",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Center(
                  child: InkWell(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Register(),
                        ),
                      );
                    },
                    child: const Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                              text: "Don't have an account? ",
                              style: TextStyle(color: textColorGrey, fontSize: 15)),
                          TextSpan(
                            text: "Register",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: (){
                    if(authenticationController.emailSelected){
                      authenticationController.loginWithEmail(context, email.text, password.text, false);
                    }else{
                      authenticationController.logInWIthPhone(context, phone.text);
                    }
                  },
                  child: const AuthButton(
                      bg: Colors.white, text: "Sign in", textColor: primaryColor),
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: (){
                    authenticationController.loginWithFB(context);
                  },
                  child: const AuthButton(
                      bg: fbBlue, text: "Facebook", textColor: Colors.white),
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: (){
                    authenticationController.loginWithGoogle(context);
                  },
                  child: const AuthButton(
                      bg: googleGreen, text: "Google", textColor: Colors.white),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class PhoneSelected extends StatelessWidget {
  const PhoneSelected({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding:
            const EdgeInsets.only(left: 50.0, right: 50.0, bottom: 20),
        child: Stack(
          alignment: Alignment.centerRight,
          fit: StackFit.loose,
          children: [
            Container(
              height: 40,
              width: 150,
              decoration: BoxDecoration(
                  color: buttonGrey,
                  borderRadius: BorderRadius.circular(20)),
            ),
            Container(
              height: 40,
              width: 85,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20)),
            ),
            Positioned(
              top: 10,
              left: 20,
              child: Row(
                children: const [
                  Text(
                    'Email',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(width: 35),
                  Text(
                    'Phone',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class EmailSelected extends StatelessWidget {
  const EmailSelected({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 50.0, right: 50.0, bottom: 20),
        child: Stack(
          fit: StackFit.loose,
          children: [
            Container(
              height: 40,
              width: 150,
              decoration: BoxDecoration(
                  color: buttonGrey, borderRadius: BorderRadius.circular(20)),
            ),
            Container(
              height: 40,
              width: 85,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
            ),
            Positioned(
              top: 10,
              left: 20,
              child: Row(
                children: const [
                  Text(
                    'Email',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 35),
                  Text(
                    'Phone',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AuthButton extends StatelessWidget {
  final Color bg;
  final String text;
  final Color textColor;

  const AuthButton({
    Key? key,
    required this.bg,
    required this.text,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 50,
        width: 300,
        decoration:
            BoxDecoration(color: bg, borderRadius: BorderRadius.circular(15)),
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: textColor, fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }
}

class CustomizedTextField1 extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final IconData icon;
  final bool hideText;
  final TextInputType inputType;

  const CustomizedTextField1({
    Key? key,
    required this.hint,
    required this.controller,
    required this.icon,
    required this.hideText,
    required this.inputType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(
        color: Colors.white
      ),
      obscureText: hideText,
      keyboardType: inputType,
      controller: controller,
      onChanged: (value) {
        //Do something with the user input.
      },
      decoration: InputDecoration(
        suffixIcon: Icon(icon, color: textColorGrey),
        fillColor: textFieldFill,
        filled: true,
        hintText: hint,
        hintStyle: const TextStyle(color: textColorGrey),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Colors.grey.withOpacity(0.2), width: 1.0),
          borderRadius: const BorderRadius.all(Radius.circular(15.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Colors.grey.withOpacity(0.2), width: 2.0),
          borderRadius: const BorderRadius.all(Radius.circular(15.0)),
        ),
      ),
    );
  }
}
