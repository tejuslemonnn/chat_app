import 'package:chat_app/app/controllers/auth_controller.dart';
import 'package:flutter/material.dart';

import 'app/utils/error_page.dart';
import 'app/utils/loading_page.dart';
import 'app/utils/splash_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final authC = Get.put(
    AuthController(),
    permanent: true,
  );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const ErrorScreen();
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return FutureBuilder(
            future: Future.delayed(
              Duration(seconds: 3),
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Obx(
                  () {
                    return GetMaterialApp(
                      debugShowCheckedModeBanner: false,
                      title: "Chat App",
                      initialRoute: authC.isSkip.isTrue
                          ? authC.isAuth.isTrue
                              ? Routes.HOME
                              : Routes.LOGIN
                          : Routes.INTRODUCTION,
                      getPages: AppPages.routes,
                    );
                  },
                );
              }

              return FutureBuilder(
                future: authC.firstInitialized(),
                builder: (context, snapshot) => SplashScreen(),
              );
            },
          );
        }

        return const LoadingScreen();
      },
    );
  }
}
