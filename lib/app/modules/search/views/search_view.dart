import 'package:chat_app/app/controllers/auth_controller.dart';
import 'package:chat_app/app/modules/search/widgets/search_bar.dart';
import 'package:chat_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../controllers/search_controller.dart';

class SearchView extends GetView<SearchController> {
  SearchView({Key? key}) : super(key: key);
  final authC = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(130),
        child: AppBar(
          title: const Text('Contacts'),
          centerTitle: true,
          backgroundColor: Colors.red[900],
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Icons.arrow_back,
            ),
          ),
          flexibleSpace: SearchBar(
            onChanged: (value) => controller.searchUser(
              value,
              authC.user.value.email!,
            ),
            controller: controller.searchC,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Obx(() {
              return Expanded(
                child: ListView.builder(
                  itemCount: controller.tempSearch.length,
                  itemBuilder: (context, index) => ListTile(
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 15,
                    ),
                    onTap: () => authC.addConnection(
                      controller.tempSearch[index]["email"],
                    ),
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.black26,
                      child: Image.asset(
                        "assets/logo/noimage.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      "${controller.tempSearch[index]["name"]}",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: const Text(
                      "Status Lorem",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
