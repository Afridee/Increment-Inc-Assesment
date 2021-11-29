import 'package:assesmentbyafridee/Screens/Authentication/login.dart';
import 'package:assesmentbyafridee/controllers/authentication.dart';
import 'package:assesmentbyafridee/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTP extends StatefulWidget {

  final String phoneNumber;

  const OTP({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  _OTPState createState() => _OTPState();
}

class _OTPState extends State<OTP> {

  final Authentication authenticationController = Get.put(Authentication());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      backgroundColor: primaryColor,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            const Text(
              "One Time Password!!",
              textAlign: TextAlign.center,
              style: TextStyle(color: textColorYellow, fontSize: 30),
            ),
            const SizedBox(
              height: 15,
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20.0, left: 30, right: 30),
              child: Text(
                "Please type the OTP code sent to your phone.",
                style: TextStyle(color: textColorGrey, fontSize: 16),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: PinCodeTextField(
                onCompleted: (smsCode){
                  authenticationController.verifyOTP(context, smsCode);
                },
                textStyle: const TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                keyboardType: TextInputType.number,
                pinTheme: PinTheme(
                    borderRadius: BorderRadius.circular(10),
                    shape: PinCodeFieldShape.box,
                    inactiveColor: otpPurpleborder,
                    activeColor: otpPurpleborder,
                    selectedColor: otpPurpleborder,
                    selectedFillColor: otptextFieldFill,
                    activeFillColor: otptextFieldFill,
                    inactiveFillColor: otptextFieldFill),
                enableActiveFill: true,
                onChanged: (String value) {},
                length: 6,
                appContext: context,
              ),
            ),
            Center(
              child: GetBuilder<Authentication>(builder: (ac){
                return Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(
                          text: "Resend in",
                          style: TextStyle(color: textColorGrey, fontSize: 15)),
                      TextSpan(
                        text: " ${ac.timer} ",
                        style: const TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      const TextSpan(
                          text: "seconds",
                          style: TextStyle(color: textColorGrey, fontSize: 15)),
                    ],
                  ),
                );
              }),
            ),
            const SizedBox(
              height: 100,
            ),
            InkWell(child: const AuthButton(bg: Colors.white, text: "Resend", textColor: primaryColor), onTap: (){
              authenticationController.logInWIthPhone(context, widget.phoneNumber);
            })
          ],
        ),
      ),
    );
  }
}
