import 'package:get/get.dart';

class Screens extends GetxController {

  int screenIndex = 0;

  switchScreen(int index){
    screenIndex = index;
    update();
  }

}