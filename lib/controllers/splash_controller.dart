

import 'dart:async';

import 'package:get/get.dart';
import 'package:unsplash_getx/pages/home_page.dart';

class SplashController extends GetxController{

  callHomePage() {
    Get.offNamed( HomePage.id);
  }

  initTimer() {
    Timer(const Duration(seconds: 2), () {
      callHomePage();
    });
  }


}