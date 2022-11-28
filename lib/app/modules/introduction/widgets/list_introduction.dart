import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';

abstract class ListIntroduction {
  static final listIntro = [
    PageViewModel(
      title: "Simple Interaction",
      body: "Welcome to the app! This is a description of how it works.",
      image: Container(
        height: Get.width * 0.6,
        width: Get.width * 0.6,
        child: Center(
          child: Lottie.asset(
            "assets/lottie/main-laptop-duduk.json",
          ),
        ),
      ),
    ),
    PageViewModel(
      title: "Find Your Friend",
      body: "You can find best friend in this app",
      image: Container(
        height: Get.width * 0.6,
        width: Get.width * 0.6,
        child: Center(
          child: Lottie.asset(
            "assets/lottie/ojek.json",
          ),
        ),
      ),
    ),
    PageViewModel(
      title: "Free App",
      body: "This app not paid",
      image: Container(
        height: Get.width * 0.6,
        width: Get.width * 0.6,
        child: Center(
          child: Lottie.asset(
            "assets/lottie/payment.json",
          ),
        ),
      ),
    ),
    PageViewModel(
      title: "Join Now!",
      body: "Register your account for join in this app",
      image: Container(
        height: Get.width * 0.6,
        width: Get.width * 0.6,
        child: Center(
          child: Lottie.asset(
            "assets/lottie/register.json",
          ),
        ),
      ),
    ),
  ];
}
