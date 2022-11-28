import 'package:chat_app/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AuthController extends GetxController {
  var isSkip = false.obs;
  var isAuth = false.obs;

  final GoogleSignIn _googleSignIn = GoogleSignIn(
      // scopes: [
      //   'email',
      //   'https://www.googleapis.com/auth/contacts.readonly',
      // ],
      );
  GoogleSignInAccount? _accountUser;
  UserCredential? userCredential;

  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  Future<void> firstInitialized() async {
    await autoLogin().then((value) {
      if (value) {
        isAuth.value = true;
      }
    });

    await skipIntro().then((value) {
      if (value) {
        isSkip.value = true;
      }
    });
  }

  Future<bool> skipIntro() async {
    final box = await Hive.openBox("auth");
    if (box.get('skipIntro') != null || box.get("skipIntro") == true) {
      return true;
    }
    return false;
  }

  Future<bool> autoLogin() async {
    try {
      final isSignIn = await _googleSignIn.isSignedIn();
      if (isSignIn) {
        return true;
      }
      return false;
    } catch (error) {
      return false;
    }
  }

  Future<void> login() async {
    try {
      await _googleSignIn.signOut();
      await _googleSignIn.signIn().then((value) => _accountUser = value);

      final isSignIn = _googleSignIn.isSignedIn();

      if (await isSignIn) {
        final googleAuth = await _accountUser!.authentication;

        final credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        );

        FirebaseAuth.instance.signInWithCredential(credential).then(
          (value) {
            userCredential = value;
          },
        );

        final box = await Hive.openBox("auth");
        if (box.get("skipIntro") != null) {
          box.delete('skipIntro');
        }
        box.put("skipIntro", true);

        CollectionReference users = fireStore.collection('users');

        final checkUser = await users.doc(_accountUser!.email).get();

        if (checkUser.data() == null) {
          await users.doc(_accountUser!.email).set({
            "uid": userCredential!.user!.uid,
            "name": _accountUser!.displayName,
            "email": _accountUser!.email,
            "photoUrl": _accountUser!.photoUrl ?? "noimage",
            "status": "",
            "createdAt":
                userCredential!.user!.metadata.creationTime!.toIso8601String(),
            "lastSignIn": userCredential!.user!.metadata.lastSignInTime!
                .toIso8601String(),
            "updateAt": DateTime.now().toIso8601String(),
          });
        } else {
          await users.doc(_accountUser!.email).update({
            "lastSignInTime": userCredential!.user!.metadata.lastSignInTime!
                .toIso8601String(),
          });
        }

        isAuth.value = true;
        Get.offAllNamed(Routes.HOME);
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> logout() async {
    await _googleSignIn.disconnect().catchError((onError) => print(onError));
    await _googleSignIn.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }
}
