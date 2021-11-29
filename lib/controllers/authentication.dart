import 'dart:async';
import 'package:assesmentbyafridee/Screens/Authentication/otp.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart' as fba;
import 'package:google_sign_in/google_sign_in.dart';

class Authentication extends GetxController {
  bool emailSelected = true;
  bool get isLoggedIn => fba.FirebaseAuth.instance.currentUser != null;
  late int phoneAuthResendToken = 0;
  late String phoneVerId;
  int timer = 0;
  bool screenLoading = false;

  startTimer(){
    timer = 30;
    update();
    for(int i=30; i>0; i--){
        Timer(Duration(seconds: i), () async {
          timer--;
          update();
        });
    }
  }

  resetPassword({required String email, required BuildContext context}) async{

    if(email.contains("@") && email.contains(".com")){
      await fba.FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      AwesomeDialog(
        context: context,
        dialogType: DialogType.SUCCES,
        animType: AnimType.BOTTOMSLIDE,
        title: 'Email Sent',
        desc: "A mail has been sent to ${email} for resetting password.",
      ).show();
    }else{
      AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.BOTTOMSLIDE,
        title: 'Oops!',
        desc: "Make Sure You have typed the email properly before pressing 'forgot your password'",
      ).show();
    }
  }


  loginWithEmail(BuildContext context, String email, String password, bool newUser) async{

    screenLoading = true;
    update();

    final fba.UserCredential authResult;

    try {
      if(newUser){
              authResult = await fba.FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
            }else{
              authResult = await fba.FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
            }

      if(newUser){
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      }else{
        Navigator.of(context).pop();
      }

      screenLoading = false;
      update();

      update();
    } catch (e) {
      screenLoading = false;
      update();
      AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.BOTTOMSLIDE,
        title: 'Oopsie!!',
        desc: e.toString(),
      ).show();
    }
  }

  toggleBetweenEmailandPhone() {
    emailSelected = !emailSelected;
    update();
  }

  loginWithFB(BuildContext context) async {
    try {
      await FacebookAuth.instance
          .login(permissions: ["public_profile", "email"]).then((value) => {
                FacebookAuth.instance.getUserData().then((userData) {
                  ///todo: you can do something with userData
                  print(userData);
                })
              });

      final AccessToken? accessToken = await FacebookAuth.instance.accessToken;

      if (accessToken != null) {
        final authResult;

        authResult = await fba.FirebaseAuth.instance.signInWithCredential(
          fba.FacebookAuthProvider.credential(accessToken.token),
        );

        update();

        Navigator.of(context).pop();
      }
    } catch (e) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.BOTTOMSLIDE,
        title: 'Oopsie!!',
        desc: e.toString(),
      ).show();
    }
  }

  loginWithGoogle(BuildContext context) async {
    try {
      GoogleSignIn _googleSignIn = GoogleSignIn(
        scopes: [
          'email',
        ],
      );

      final googleUser = await _googleSignIn.signIn();

      if (googleUser != null) {
        final authResult;

        final googleAuth = await googleUser.authentication;

        final credential = fba.GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

        authResult =
            await fba.FirebaseAuth.instance.signInWithCredential(credential);

        update();

        Navigator.of(context).pop();
      }
    } catch (e) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.BOTTOMSLIDE,
        title: 'Oopsie!!',
        desc: e.toString(),
      ).show();
    }
  }

  Future<void> logInWIthPhone(BuildContext context, String phoneNumber) async{
      if(timer==0){

        startTimer();

        screenLoading = true;
        update();

        final _firebaseAuth = fba.FirebaseAuth.instance;

        await _firebaseAuth.verifyPhoneNumber(
            phoneNumber: phoneNumber,
            verificationCompleted: (phoneAuthCredential) async {
              ///todo: after verification is completed
              print("verification completed");
            },
            verificationFailed: (verificationFailed) async {
              screenLoading = false;
              update();
              AwesomeDialog(
                context: context,
                dialogType: DialogType.ERROR,
                animType: AnimType.BOTTOMSLIDE,
                title: 'Oopsie!!',
                desc: verificationFailed.toString(),
              ).show();
            },
            codeSent: (verificationId, resendingToken) async {
              print("code sent");
              Navigator.of(context).pop();
              goToOTPScreen(context, phoneNumber);
              phoneVerId = verificationId;
              phoneAuthResendToken = resendingToken!;
              screenLoading = false;
              update();
            },
            codeAutoRetrievalTimeout: (verificationId) async {
              phoneVerId = verificationId;
              update();
            },
            forceResendingToken: phoneAuthResendToken
        );
      }
  }

  goToOTPScreen(BuildContext context, String phoneNumber){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OTP(phoneNumber: phoneNumber),
      ),
    );
  }

  verifyOTP(BuildContext context, String smsCode) async{
    final _firebaseAuth = fba.FirebaseAuth.instance;
    try{
      fba.AuthCredential authCreds = fba.PhoneAuthProvider.credential(verificationId: phoneVerId, smsCode: smsCode.trim());
      await _firebaseAuth.signInWithCredential(authCreds);
      update();
      Navigator.of(context).pop();//goes to main screen
    }catch(e){
      AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.BOTTOMSLIDE,
        title: 'Oopsie!!',
        desc: e.toString(),
      ).show();
    }
  }

  logOut() async {
    await fba.FirebaseAuth.instance.signOut();
    update();
  }
}
