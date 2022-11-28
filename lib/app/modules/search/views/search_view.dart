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
    final List<Widget> contacts = List.generate(
      20,
      (index) => ListTile(
        onTap: () => Get.toNamed(Routes.CHAT_ROOM),
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: Colors.black26,
          child: Image.asset(
            "assets/logo/noimage.png",
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          "Lorem ${index + 1}",
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
    );

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(130),
        child: AppBar(
          title: const Text('Search'),
          centerTitle: true,
          backgroundColor: Colors.red[900],
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Icons.arrow_back,
            ),
          ),
          flexibleSpace: SearchBar.search,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: contacts.length == 0
                  ? Center(
                      child: SizedBox(
                        height: Get.width * 0.7,
                        width: Get.width * 0.7,
                        child: Lottie.asset("assets/lottie/empty.json"),
                      ),
                    )
                  : ListView.builder(
                      itemCount: 20,
                      itemBuilder: (context, index) => contacts[index],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
