import 'package:chat_app/app/data/models/users_model.dart';
import 'package:chat_app/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AuthController extends GetxController {
  var isSkip = false.obs;
  var isAuth = false.obs;
  var isLoading = false.obs;

  final GoogleSignIn _googleSignIn = GoogleSignIn(
      // scopes: [
      //   'email',
      //   'https://www.googleapis.com/auth/contacts.readonly',
      // ],
      );
  GoogleSignInAccount? _accountUser;
  UserCredential? userCredential;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  var user = UsersModel().obs;

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
        await _googleSignIn
            .signInSilently()
            .then((value) => _accountUser = value);

        CollectionReference users = fireStore.collection('users');

        await users.doc(_accountUser!.email).update({
          "lastSignIn":
              userCredential!.user!.metadata.lastSignInTime!.toIso8601String(),
        });

        final accUser = await users.doc(_accountUser!.email).get();
        final accUserData = accUser.data() as Map<String, dynamic>;

        user(UsersModel(
          uid: accUserData["uid"],
          name: accUserData["name"],
          keyName: accUserData["keyName"],
          email: accUserData["email"],
          photoUrl: accUserData["photoUrl"],
          status: accUserData["status"],
          createdAt: accUserData["createdAt"],
          lastSignIn: accUserData["lastSignIn"],
          updatedAt: accUserData["updatedAt"],
        ));

        return true;
      }
      return false;
    } catch (error) {
      return false;
    }
  }

  Future<void> login() async {
    try {
      isLoading.value = true;

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
            "keyName": _accountUser!.displayName!.substring(0, 1).toUpperCase(),
            "email": _accountUser!.email,
            "photoUrl": _accountUser!.photoUrl ?? "noimage",
            "status": "",
            "createdAt":
                userCredential!.user!.metadata.creationTime!.toIso8601String(),
            "lastSignIn": userCredential!.user!.metadata.lastSignInTime!
                .toIso8601String(),
            "updatedAt": DateTime.now().toIso8601String(),
          });
        } else {
          await users.doc(_accountUser!.email).update({
            "lastSignIn": userCredential!.user!.metadata.lastSignInTime!
                .toIso8601String(),
          });
        }

        final accUser = await users.doc(_accountUser!.email).get();
        final accUserData = accUser.data() as Map<String, dynamic>;

        user(UsersModel(
          uid: accUserData["uid"],
          name: accUserData["name"],
          keyName: accUserData["keyName"],
          email: accUserData["email"],
          photoUrl: accUserData["photoUrl"],
          status: accUserData["status"],
          createdAt: accUserData["createdAt"],
          lastSignIn: accUserData["lastSignIn"],
          updatedAt: accUserData["updatedAt"],
        ));

        isAuth.value = true;
        isLoading.value = false;
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

  Future<void> changeProfile(String name, String status) async {
    CollectionReference users = fireStore.collection("users");

    final date = DateTime.now().toIso8601String();

    users.doc(_accountUser!.email).update({
      "name": name,
      "status": status,
      "keyName": name.substring(0, 1).toUpperCase(),
      "lastSignIn":
          userCredential!.user!.metadata.lastSignInTime!.toIso8601String(),
      "updatedAt": date,
    });

    user.update((val) {
      val!.name = name;
      val.status = status;
      val.keyName = name.substring(0, 1).toUpperCase();
      val.lastSignIn =
          userCredential!.user!.metadata.lastSignInTime!.toIso8601String();
      val.updatedAt = date;
    });

    user.refresh();

    Get.defaultDialog(
      title: "Success",
      middleText: "Profile Changed",
    );
  }

  void addConnection(String email) async {
    String date = DateTime.now().toIso8601String();

    CollectionReference chats = fireStore.collection("chats");

    final newChat = await chats.add({
      "connection": [
        _accountUser!.email,
        email,
      ],
      "total_chats": 0,
      "total_read": 0,
      "total_unread": 0,
      "chats": [],
      "lastTime": date,
    });

    CollectionReference users = fireStore.collection("users");

    users.doc(_accountUser!.email).update(
      {
        "chats": [
          {
            "connection": email,
            "chats_id": newChat.id,
            "lastTime": date,
          }
        ],
      },
    );

    user.update(
      (val) {
        val!.chats = [
          ChatUser(
            chatId: newChat.id,
            connection: email,
            lastTime: date,
          )
        ];
      },
    );

    user.refresh();

    Get.toNamed(Routes.CHAT_ROOM);
  }
}
