import 'package:chat_app/app/controllers/auth_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  late TextEditingController searchC;

  var tempQuery = [].obs;
  var tempSearch = [].obs;

  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  final authC = Get.find<AuthController>();

  void searchUser(String data, String email) async {
    if (data.isEmpty) {
      CollectionReference users = await fireStore.collection("users");
      final result = await users.where("email", isNotEqualTo: email).get();

      tempQuery.value = [];
      tempSearch.value = [];

      for (int i = 0; i < result.docs.length; i++) {
        tempSearch.add(result.docs[i].data() as Map<String, dynamic>);
      }
    } else {
      var capitalized = data.substring(0, 1).toUpperCase() + data.substring(1);

      if (tempQuery.isEmpty && data.length == 1) {
        CollectionReference users = await fireStore.collection("users");
        final result = await users
            .where("keyName", isEqualTo: data.substring(0, 1).toUpperCase())
            .where("email", isNotEqualTo: email)
            .get();

        if (result.docs.isNotEmpty) {
          for (int i = 0; i < result.docs.length; i++) {
            tempQuery.add(result.docs[i].data() as Map<String, dynamic>);
          }
        }
      }
      if (tempQuery.isNotEmpty) {
        tempSearch.value = [];
        for (var e in tempQuery) {
          final name = e["name"].toString().substring(0, 1).toUpperCase() +
              e["name"].toString().substring(1);
          if (name.startsWith(capitalized)) {
            tempSearch.add(e);
          }
        }
      }
    }

    tempQuery.refresh();
    tempSearch.refresh();
  }

  @override
  void onInit() {
    searchC = TextEditingController();
    searchUser("", authC.user.value.email.toString());
    super.onInit();
  }

  @override
  void dispose() {
    searchC.dispose();
    super.dispose();
  }
}
