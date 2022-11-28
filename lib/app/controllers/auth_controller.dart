import 'package:chat_app/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  var isSkip = false.obs;
  var isAuth = false.obs;

  GoogleSignIn _googleSignIn = GoogleSignIn(
      // scopes: [
      //   'email',
      //   'https://www.googleapis.com/auth/contacts.readonly',
      // ],
      );
  GoogleSignInAccount? _accountUser;
  UserCredential? userCredential;

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
            print(value);
          },
        );
        isAuth.value = true;
        Get.offAllNamed(Routes.HOME);
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> logout() async {
    await _googleSignIn.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }
}
