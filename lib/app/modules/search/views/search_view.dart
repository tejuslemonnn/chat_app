import 'package:chat_app/app/modules/search/widgets/search_bar.dart';
import 'package:chat_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../controllers/search_controller.dart';

class SearchView extends GetView<SearchController> {
  const SearchView({Key? key}) : super(key: key);

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
            onChanged: (value) => controller.searchUser(value),
            controller: controller.searchC,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Obx(() {
              return Expanded(
                child: controller.tempSearch.isEmpty
                    ? Center(
                        child: SizedBox(
                          height: Get.width * 0.7,
                          width: Get.width * 0.7,
                          child: Lottie.asset("assets/lottie/empty.json"),
                        ),
                      )
                    : ListView.builder(
                        itemCount: controller.tempSearch.length,
                        itemBuilder: (context, index) => ListTile(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 15,
                          ),
                          onTap: () => Get.toNamed(Routes.CHAT_ROOM),
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
